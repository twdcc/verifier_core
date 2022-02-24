import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:verifier_core/helper/eu_dcc_mapping.dart';

part 'eu_dcc_payload_model.g.dart';

@JsonSerializable()
class EUDCCPayloadModel {
  @JsonKey(name: 'ver')
  String schemaVersion;

  @JsonKey(name: 'nam')
  NameModel nameInfo;

  @JsonKey(name: 'dob')
  String dateOfBirth;

  @JsonKey(name: 'v')
  List<VaccinationModel>? vaccinationList;

  @JsonKey(name: 'r')
  List<RecoveryModel>? revoeryList;

  @JsonKey(name: 't')
  List<TestedModel>? testList;

  @JsonKey(ignore: true)
  VerificationError verificationError = VerificationError.not_error;

  @JsonKey(ignore: true)
  int iat = 0;

  @JsonKey(ignore: true)
  int exp = 0;

  List<StateModel> get statementList {
    List<StateModel> result = [];
    if (this.vaccinationList != null)
      result += (this.vaccinationList as List<StateModel>);
    if (this.testList != null) result += (this.testList as List<StateModel>);
    if (this.revoeryList != null)
      result += (this.revoeryList as List<StateModel>);
    return result;
  }

  StateModel get statement {
    return statementList.first;
  }

  CertType getCertificateType() {
    switch (statement.runtimeType) {
      case VaccinationModel:
        return CertType.vaccine;
      case TestedModel:
        return CertType.test;
      case RecoveryModel:
        return CertType.recovery;
      default:
        return CertType.unknown;
    }
  }

  String get issuerCountry {
    return this.statement.country;
  }

  EUDCCPayloadModel(
    this.schemaVersion,
    this.nameInfo,
    this.dateOfBirth,
    this.vaccinationList,
    this.revoeryList,
    this.testList,
  );

  factory EUDCCPayloadModel.fromJson(Map<String, dynamic> json) =>
      _$EUDCCPayloadModelFromJson(json);

  Map<String, dynamic> toJson() => _$EUDCCPayloadModelToJson(this);

  factory EUDCCPayloadModel.fromMap(Map mapData) {
    bool? isStringKey = mapData.containsKey("-260")
        ? true
        : (mapData.containsKey(-260) ? false : null);
    if (isStringKey == null) {
      throw Exception();
    }
    String jsonString = isStringKey
        ? json.encode(mapData["-260"]["1"])
        : json.encode(mapData[-260][1]);

    final data = _$EUDCCPayloadModelFromJson(json.decode(jsonString));
    data.iat = isStringKey ? mapData["6"] : mapData[6];
    data.exp = isStringKey ? mapData["4"] : mapData[4];

    return data;
  }
}

@JsonSerializable()
class NameModel extends Object {
  @JsonKey(name: 'fn')
  String? familyName;

  @JsonKey(name: 'gn')
  String? givenName;

  @JsonKey(name: 'fnt')
  String? standardisedFamilyName;

  @JsonKey(name: 'gnt')
  String? standardisedGivenName;

  NameModel(
    this.familyName,
    this.givenName,
    this.standardisedFamilyName,
    this.standardisedGivenName,
  );

  factory NameModel.fromJson(Map<String, dynamic> json) =>
      _$NameModelFromJson(json);

  Map<String, dynamic> toJson() => _$NameModelToJson(this);

  String get fullName {
    return (this.familyName ?? ' ') + (this.givenName ?? ' ');
  }

  String? get standardisedFullName {
    if (!(this.standardisedFamilyName?.isEmpty ?? false) ||
        !(this.standardisedGivenName?.isEmpty ?? false)) {
      final fullName =
          '${this.standardisedFamilyName ?? ''}${(this.standardisedGivenName?.isEmpty ?? true) ? '' : ('<<' + this.standardisedGivenName!)}';
      return fullName.replaceAll('<', '').isEmpty ? null : fullName;
    }
    return null;
  }
}

@JsonSerializable()
class StateModel extends Object {
  @JsonKey(name: 'tg')
  String disease;

  @JsonKey(name: 'co')
  String country;

  @JsonKey(name: 'is')
  String certificateIssuer;

  @JsonKey(name: 'ci')
  String certificateIdentifier;

  StateModel(
    this.disease,
    this.country,
    this.certificateIssuer,
    this.certificateIdentifier,
  );

  factory StateModel.fromJson(Map<String, dynamic> json) =>
      _$StateModelFromJson(json);

  Map<String, dynamic> toJson() => _$StateModelToJson(this);
}

@JsonSerializable()
class VaccinationModel extends StateModel {
  @JsonKey(name: 'vp')
  String vaccine;

  @JsonKey(name: 'mp')
  String medicinalProduct;

  @JsonKey(name: 'ma')
  String manufacturer;

  @JsonKey(name: 'dn')
  int doseNumber;

  @JsonKey(name: 'sd')
  int totalSeriesOfDoses;

  @JsonKey(name: 'dt')
  String dateOfVaccination;

  String get doseDesc {
    return '${this.doseNumber} of ${this.totalSeriesOfDoses}';
  }

  VaccinationModel(
    String disease,
    this.vaccine,
    this.medicinalProduct,
    this.manufacturer,
    this.doseNumber,
    this.totalSeriesOfDoses,
    this.dateOfVaccination,
    String country,
    String certificateIssuer,
    String certificateIdentifier,
  ) : super(disease, country, certificateIssuer, certificateIdentifier);

  factory VaccinationModel.fromJson(Map<String, dynamic> json) =>
      _$VaccinationModelFromJson(json);

  Map<String, dynamic> toJson() => _$VaccinationModelToJson(this);

  bool isCompleteVaccination() {
    return this.doseNumber == this.totalSeriesOfDoses;
  }

  bool isBooster() {
    return (this.doseNumber > this.totalSeriesOfDoses) ||
        (isCompleteVaccination() && this.totalSeriesOfDoses > 2);
  }
}

@JsonSerializable()
class RecoveryModel extends StateModel {
  @JsonKey(name: 'fr')
  String dateOfFirstPositiveTest;

  @JsonKey(name: 'df')
  String certificateValidFrom;

  @JsonKey(name: 'du')
  String certificateValidUntil;

  RecoveryModel(
    String disease,
    this.dateOfFirstPositiveTest,
    this.certificateValidFrom,
    this.certificateValidUntil,
    String country,
    String certificateIssuer,
    String certificateIdentifier,
  ) : super(disease, country, certificateIssuer, certificateIdentifier);

  factory RecoveryModel.fromJson(Map<String, dynamic> json) =>
      _$RecoveryModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecoveryModelToJson(this);
}

@JsonSerializable()
class TestedModel extends StateModel {
  @JsonKey(name: 'tt')
  String typeOfTest;

  @JsonKey(name: 'nm')
  String? testName;

  @JsonKey(name: 'ma')
  String? testNameAndManufacturer;

  @JsonKey(name: 'sc')
  String dateTimeOfCollection;

  @JsonKey(name: 'tr')
  String testResult;

  @JsonKey(name: 'tc')
  String testingCentre;

  @JsonKey(name: 'rd')
  String? reportDate;

  TestedModel(
    String disease,
    this.typeOfTest,
    this.testName,
    this.testNameAndManufacturer,
    this.dateTimeOfCollection,
    this.testResult,
    this.testingCentre,
    String country,
    String certificateIssuer,
    String certificateIdentifier,
    this.reportDate,
  ) : super(disease, country, certificateIssuer, certificateIdentifier);

  factory TestedModel.fromJson(Map<String, dynamic> json) =>
      _$TestedModelFromJson(json);

  Map<String, dynamic> toJson() => _$TestedModelToJson(this);

  /// PCR
  bool get isNAA {
    return TypeOfTest.mapEnum[this.typeOfTest] == TypeOfTestEnum.lP6464_4;
  }

  /// 快篩
  bool get isRAT {
    return TypeOfTest.mapEnum[this.typeOfTest] == TypeOfTestEnum.lP217198_3;
  }
}
