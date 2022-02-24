import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:get/get.dart';
import 'package:verifier_core/core/model/eu_dcc_payload_model.dart';
import 'package:verifier_core/helper/const.dart';
import 'package:verifier_core/helper/eu_dcc_mapping.dart';
import 'package:verifier_core/helper/utils.dart';

abstract class BaseResultViewModel extends GetxController {
  List<DetailedInfo> generateDetailedInfo();

  late String displayTitle;
  late Color displayColor;
  late IconData displayIcon;
}

class DccResultViewModel extends BaseResultViewModel {
  late CoseResult _result;
  late EUDCCPayloadModel _data;
  late bool _showRawData;
  late String certificateType;

  List<VerificationError> verificationErrors = [];
  List<VerificationLimit> verificationLimits = [];

  void checkValidity(
    CoseResult coseResult, {
    bool showRawData = false,
  }) {
    _result = coseResult;
    _showRawData = showRawData;
    bool validity = _result.verified;
    try {
      _data = EUDCCPayloadModel.fromMap(_result.payload);
      verificationErrors = [];
      verificationLimits = [];
    } catch (e) {
      //!
    }

    bool isCompleteVaccination = (_data.vaccinationList == null);

    /// 檢驗時間介於注意時間~有效時間之間，代表需經人工確認
    bool needNotice = false;

    // *G-COMPARE 0: 憑證有效性
    if (!validity) {
      verificationErrors.add(VerificationError.cryptographic_signature_invalid);
    }

    // *G-COMPARE 1: 憑證效期
    bool isExpValid = DateTime(1970)
        .add(Duration(seconds: _data.exp))
        .isAfter(DateTime.now());
    if (!isExpValid) {
      verificationErrors.add(VerificationError.green_certificate_expired);
    }
    bool isIatValid = DateTime(1970)
        .add(Duration(seconds: _data.iat))
        .isBefore(DateTime.now());
    if (!isIatValid) {
      verificationErrors.add(VerificationError.green_certificate_in_future);
    }

    // *G-COMPARE 2: 目標疾病清單
    if (!TargetDisease.map.containsKey(_data.statement.disease)) {
      verificationLimits.add(VerificationLimit.diseaseOutList);
    }

    switch (_data.getCertificateType()) {
      case CertType.vaccine:
        final vaccine = (_data.statement as VaccinationModel);
        certificateType = '$vaccinationText ${vaccine.doseDesc}';

        // *V-COMPARE 0: 完整接種
        isCompleteVaccination = vaccine.isCompleteVaccination();

        // *V-COMPARE 1: 核定清單
        bool isAllowVaccines = VaccineMedicinalProduct.allowList
            .contains(vaccine.medicinalProduct);
        if (!isAllowVaccines) {
          verificationLimits.add(VerificationLimit.allowVaccine);
        }

        // *V-COMPARE 2: 疫苗有效期
        DateTime? vaccinationTime =
            DateTime.tryParse(vaccine.dateOfVaccination);
        if (vaccinationTime != null) {
          bool isVaccineEffective = (vaccinationTime
                      .toUtc()
                      .add(vaccineEffectiveDurationAfter)
                      .isBefore(DateTime.now().toUtc()) ||
                  vaccine.doseNumber != 2) &&
              (vaccinationTime
                      .toUtc()
                      .add(vaccineEffectiveDurationBefore)
                      .isAfter(DateTime.now().toUtc()) ||
                  vaccine.isBooster());
          if (!isVaccineEffective) {
            verificationLimits.add(VerificationLimit.verificationTime);
          }
        }
        break;

      case CertType.recovery:
        final recovery = (_data.statement as RecoveryModel);
        certificateType = recoveryText;

        // *R-COMPARE 0: 康復有效期
        bool certificateNotValidAnymore =
            (DateTime.tryParse(recovery.certificateValidFrom) ?? DateTime.now())
                .isBefore(DateTime.now());
        bool certificateNotValidSoFar =
            (DateTime.tryParse(recovery.certificateValidUntil) ??
                    DateTime.now())
                .isAfter(DateTime.now());
        if (!certificateNotValidAnymore) {
          verificationErrors.add(VerificationError.recovery_not_valid_anymore);
        }

        if (!certificateNotValidSoFar) {
          verificationErrors.add(VerificationError.recovery_not_valid_so_far);
        }

        break;

      case CertType.test:
        final test = (_data.statement as TestedModel);
        certificateType = testResultText;

        // *T-COMPARE 0: 檢驗結果
        bool isResultNegative =
            TestResult.mapEnum[test.testResult] == TestResultEnum.not_detected;

        if (!isResultNegative) {
          verificationErrors.add(VerificationError.test_result_positive);
          verificationLimits.add(VerificationLimit.resultPositive);
        }

        // *T-COMPARE 1: 快篩
        TypeOfTestEnum tt =
            TypeOfTest.mapEnum[(_data.statement as TestedModel).typeOfTest] ??
                TypeOfTestEnum.unKnown;
        if (tt == TypeOfTestEnum.lP217198_3) {
          verificationErrors.add(VerificationError.test_tt_is_lP217198_3);
        }

        // *T-COMPARE 2: 檢驗有效期
        bool isDateInThePast;
        bool isInTestLimitTime; // 未超過檢驗有效時間 (<120hr)
        DateTime? collectionTime = DateTime.tryParse(
            (_data.statement as TestedModel).dateTimeOfCollection);

        if (collectionTime != null && tt != TypeOfTestEnum.unKnown) {
          int hoursInRed = TypeOfTest.RedLightHourRule[tt]!;
          int hoursInAmber = TypeOfTest.AmberLightHourRule[tt]!;
          isDateInThePast =
              collectionTime.toUtc().isBefore(DateTime.now().toUtc());
          isInTestLimitTime = collectionTime
              .toUtc()
              .add(Duration(hours: hoursInRed))
              .isAfter(DateTime.now().toUtc());
          needNotice = collectionTime
                  .toUtc()
                  .add(Duration(hours: hoursInAmber))
                  .isBefore(DateTime.now().toUtc()) &&
              isInTestLimitTime; // (between 48~120hr)
        } else {
          if (tt == TypeOfTestEnum.unKnown) {
            verificationLimits.add(VerificationLimit.testTypeOutList);
          }
          isDateInThePast = false;
          isInTestLimitTime = false;
          needNotice = false;
        }
        if (!isInTestLimitTime) {
          verificationErrors.add(VerificationError.test_date_is_excess);
        }
        if (!isDateInThePast) {
          verificationErrors.add(VerificationError.test_date_is_in_the_future);
        }

        // *T-COMPARE 3: RAT 檢驗廠商
        bool isExistMa = (tt == TypeOfTestEnum.lP217198_3)
            ? TestManufacturerAndName.map
                .containsKey(test.testNameAndManufacturer)
            : true;
        if (!isExistMa) {
          verificationLimits.add(VerificationLimit.maOutList);
        }

        break;

      case CertType.unknown:
        certificateType = 'unknown';
        break;
    }

    if (verificationErrors.length > 0) {
      _data.verificationError = verificationErrors[0];
      validity = false;
    }

    bool matchBusinessRules = verificationLimits.isEmpty;

    // 查驗結果顏色
    displayColor = validity
        ? matchBusinessRules
            ? isCompleteVaccination
                ? !needNotice
                    ? validColor
                    : airportNoticeColor
                : incompleteValidColor
            : limitedValidColor
        : invalidColor;

    // 查驗結果文字
    if (!validity) {
      displayTitle = CertValidityExtension.certvalResult[CertValidity.invalid]!;
    } else if (verificationLimits
        .contains(VerificationLimit.verificationTime)) {
      displayTitle = CertValidityExtension.certvalResult[CertValidity.expire]!;
    } else if (verificationLimits.any((VerificationLimit value) => [
          VerificationLimit.diseaseOutList,
          VerificationLimit.testTypeOutList,
          VerificationLimit.maOutList,
          VerificationLimit.allowVaccine,
        ].contains(value))) {
      displayTitle =
          CertValidityExtension.certvalResult[CertValidity.notInWhitelist]!;
    } else if (needNotice) {
      displayTitle = CertValidityExtension.certvalResult[CertValidity.notice]!;
    } else if (!isCompleteVaccination) {
      displayTitle =
          CertValidityExtension.certvalResult[CertValidity.incompletevalid]!;
    } else if (validity && matchBusinessRules) {
      displayTitle = CertValidityExtension.certvalResult[CertValidity.valid]!;
    } else {
      displayTitle = '';
    }

    // 查驗結果圖示
    displayIcon = validity
        ? matchBusinessRules && !needNotice && isCompleteVaccination
            ? Icons.task_alt_outlined
            : Icons.warning_amber_rounded
        : Icons.cancel_outlined;

    update();
  }

  @override
  List<DetailedInfo> generateDetailedInfo() {
    List<DetailedInfo> items = [];
    bool isTested = _data.getCertificateType() == CertType.test;
    bool isVaccination = _data.getCertificateType() == CertType.vaccine;
    bool isRevoery = _data.getCertificateType() == CertType.recovery;
    // BuildContext context = Get.context!;
    if (_showRawData) {
      Map<String, String> rawJsonString =
          Map<String, String>(); //keys as String
      _result.payload.forEach((key, value) {
        rawJsonString.putIfAbsent(key.toString(), () => value.toString());
      });
      items.add(DetailedInfo(
        chTitle: '原始資料',
        enTitle: 'JSON Data',
        info: json.encode(rawJsonString),
      ));
    }

    if (_data.verificationError != VerificationError.not_error) {
      items.add(DetailedInfo(
        chTitle: '無效原因',
        enTitle: 'Reason for Invalidity',
        info: VerificationErrorExtension
            .verificationErrors[_data.verificationError]!,
      ));
    }

    items.add(DetailedInfo(
      chTitle: '證明種類',
      enTitle: 'Certificate Type',
      info: certificateType,
    ));

    if (verificationLimits.length > 0) {
      items.add(DetailedInfo(
        chTitle: '可能限制',
        enTitle: 'Possible Limitation',
        info: this.possibleLimitations,
      ));
    }

    items.add(DetailedInfo(
      chTitle: '生日',
      enTitle: 'Date of Birth (DD/MM/YYYY)',
      info: Utils.dccFormattedDateTime(_data.dateOfBirth),
    ));

    if (isVaccination) {
      items.add(DetailedInfo(
        chTitle: '疫苗類型',
        enTitle: 'Vanccine/prophylaxis',
        info: VaccineProphylaxis
                .map[(_data.statement as VaccinationModel).vaccine] ??
            'unknown',
      ));
    }

    if (isVaccination) {
      items.add(DetailedInfo(
        chTitle: '疫苗產品',
        enTitle: 'Vanccine Medicinal Product',
        info: VaccineMedicinalProduct
                .map[(_data.statement as VaccinationModel).medicinalProduct] ??
            'unknown',
      ));
    }

    if (isVaccination) {
      items.add(DetailedInfo(
        chTitle: '疫苗製造商',
        enTitle: 'Vanccine Manufacturer',
        info: VaccineManufacturer
                .map[(_data.statement as VaccinationModel).manufacturer] ??
            'unknown (${(_data.statement as VaccinationModel).manufacturer})',
      ));
    }

    if (isVaccination) {
      items.add(DetailedInfo(
        chTitle: '接種日期',
        enTitle: 'Date Of Vanccination (DD/MM/YYYY)',
        info: Utils.dccFormattedDateTime(
            (_data.statement as VaccinationModel).dateOfVaccination),
      ));
    }

    if (isRevoery) {
      items.add(DetailedInfo(
        chTitle: '康復日期',
        enTitle: 'Date Of Revoery (DD/MM/YYYY)',
        info: Utils.dccFormattedDateTime(
            (_data.statement as RecoveryModel).certificateValidFrom),
      ));
    }

    if (isRevoery) {
      items.add(DetailedInfo(
        chTitle: '證書有效期限',
        enTitle: 'Certificate Expiration',
        info: '${(_data.statement as RecoveryModel).certificateValidUntil}',
      ));
    }

    if (isTested) {
      items.add(DetailedInfo(
        chTitle: '檢驗結果',
        enTitle: 'Test Result',
        info: TestResult.map[(_data.statement as TestedModel).testResult]!,
      ));
    }

    if (isTested) {
      items.add(DetailedInfo(
        chTitle: '檢驗類型',
        enTitle: 'Type of Test',
        info: TypeOfTest.map[(_data.statement as TestedModel).typeOfTest] ??
            'unknown',
      ));
    }

    if (isTested) {
      items.add(DetailedInfo(
        chTitle: '檢驗樣本採集日期與時間',
        enTitle: 'Time Of Sampling (DD/MM/YYYY)',
        info: Utils.dccFormattedDateTime(
            (_data.statement as TestedModel).dateTimeOfCollection,
            withTime: true,
            withTimeZone: true),
      ));
    }

    if (isTested && (_data.statement as TestedModel).reportDate != null) {
      items.add(DetailedInfo(
        chTitle: '檢驗報告產出日期與時間',
        enTitle: 'Time Of Reporting (DD/MM/YYYY)',
        info: Utils.dccFormattedDateTime(
            (_data.statement as TestedModel).reportDate,
            withTime: true,
            withTimeZone: true),
      ));
    }

    if (isTested &&
        (_data.statement as TestedModel).isRAT &&
        (_data.statement as TestedModel).testNameAndManufacturer != null) {
      items.add(DetailedInfo(
        chTitle: 'RAT 快篩檢驗試劑製造商',
        enTitle: 'Test Manufacturer And Name',
        info: TestManufacturerAndName.map[
                (_data.statement as TestedModel).testNameAndManufacturer] ??
            'unknown (${(_data.statement as TestedModel).testNameAndManufacturer})',
      ));
    }

    if (isTested &&
        (_data.statement as TestedModel).isNAA &&
        (_data.statement as TestedModel).testName != null) {
      items.add(DetailedInfo(
        chTitle: 'NAA 檢驗商',
        enTitle: 'Test Name',
        info: (_data.statement as TestedModel).testName!,
      ));
    }

    if (isTested) {
      items.add(DetailedInfo(
        chTitle: '醫事機構',
        enTitle: 'Testing Centre Or Facility',
        info: (_data.statement as TestedModel).testingCentre,
      ));
    }

    items.add(DetailedInfo(
      chTitle: '預防疾病名稱',
      enTitle: 'Targeted Disease',
      info: (TargetDisease.map[_data.statement.disease] ??
          _data.statement.disease),
    ));

    items.add(DetailedInfo(
      chTitle: '發行國家',
      enTitle: 'Issuer Country',
      info: (CountryMap.map[_data.issuerCountry] ?? _data.issuerCountry),
    ));

    if (_data.nameInfo.standardisedFullName != null) {
      items.add(DetailedInfo(
        chTitle: '持證人姓名',
        enTitle: 'Standardised Name',
        info: _data.nameInfo.standardisedFullName!,
      ));
    }

    return items;
  }
}

extension DccResultExtension on DccResultViewModel {
  String get fullName => _data.nameInfo.fullName;

  String get possibleLimitations {
    String possibleLimitationSrting = '';
    verificationLimits.asMap().forEach((idx, val) {
      final limit = VerificationLimitExtension.verificationLimitDesc[val]!;
      possibleLimitationSrting += '【$idx】\n$limit\n';
    });
    possibleLimitationSrting = (possibleLimitationSrting.endsWith('\n'))
        ? possibleLimitationSrting.substring(
            0, possibleLimitationSrting.lastIndexOf('\n'))
        : possibleLimitationSrting;

    return possibleLimitationSrting;
  }
}

class DetailedInfo {
  String chTitle;
  String enTitle;
  String info;

  DetailedInfo({
    required this.chTitle,
    required this.enTitle,
    required this.info,
  });
}
