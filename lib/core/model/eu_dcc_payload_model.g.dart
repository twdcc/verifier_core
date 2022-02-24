// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eu_dcc_payload_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EUDCCPayloadModel _$EUDCCPayloadModelFromJson(Map<String, dynamic> json) {
  return EUDCCPayloadModel(
    json['ver'] as String,
    NameModel.fromJson(json['nam'] as Map<String, dynamic>),
    json['dob'] as String,
    (json['v'] as List<dynamic>?)
        ?.map((e) => VaccinationModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['r'] as List<dynamic>?)
        ?.map((e) => RecoveryModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['t'] as List<dynamic>?)
        ?.map((e) => TestedModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$EUDCCPayloadModelToJson(EUDCCPayloadModel instance) =>
    <String, dynamic>{
      'ver': instance.schemaVersion,
      'nam': instance.nameInfo,
      'dob': instance.dateOfBirth,
      'v': instance.vaccinationList,
      'r': instance.revoeryList,
      't': instance.testList,
    };

NameModel _$NameModelFromJson(Map<String, dynamic> json) {
  return NameModel(
    json['fn'] as String?,
    json['gn'] as String?,
    json['fnt'] as String?,
    json['gnt'] as String?,
  );
}

Map<String, dynamic> _$NameModelToJson(NameModel instance) => <String, dynamic>{
      'fn': instance.familyName,
      'gn': instance.givenName,
      'fnt': instance.standardisedFamilyName,
      'gnt': instance.standardisedGivenName,
    };

StateModel _$StateModelFromJson(Map<String, dynamic> json) {
  return StateModel(
    json['tg'] as String,
    json['co'] as String,
    json['is'] as String,
    json['ci'] as String,
  );
}

Map<String, dynamic> _$StateModelToJson(StateModel instance) =>
    <String, dynamic>{
      'tg': instance.disease,
      'co': instance.country,
      'is': instance.certificateIssuer,
      'ci': instance.certificateIdentifier,
    };

VaccinationModel _$VaccinationModelFromJson(Map<String, dynamic> json) {
  return VaccinationModel(
    json['tg'] as String,
    json['vp'] as String,
    json['mp'] as String,
    json['ma'] as String,
    json['dn'] as int,
    json['sd'] as int,
    json['dt'] as String,
    json['co'] as String,
    json['is'] as String,
    json['ci'] as String,
  );
}

Map<String, dynamic> _$VaccinationModelToJson(VaccinationModel instance) =>
    <String, dynamic>{
      'tg': instance.disease,
      'co': instance.country,
      'is': instance.certificateIssuer,
      'ci': instance.certificateIdentifier,
      'vp': instance.vaccine,
      'mp': instance.medicinalProduct,
      'ma': instance.manufacturer,
      'dn': instance.doseNumber,
      'sd': instance.totalSeriesOfDoses,
      'dt': instance.dateOfVaccination,
    };

RecoveryModel _$RecoveryModelFromJson(Map<String, dynamic> json) {
  return RecoveryModel(
    json['tg'] as String,
    json['fr'] as String,
    json['df'] as String,
    json['du'] as String,
    json['co'] as String,
    json['is'] as String,
    json['ci'] as String,
  );
}

Map<String, dynamic> _$RecoveryModelToJson(RecoveryModel instance) =>
    <String, dynamic>{
      'tg': instance.disease,
      'co': instance.country,
      'is': instance.certificateIssuer,
      'ci': instance.certificateIdentifier,
      'fr': instance.dateOfFirstPositiveTest,
      'df': instance.certificateValidFrom,
      'du': instance.certificateValidUntil,
    };

TestedModel _$TestedModelFromJson(Map<String, dynamic> json) {
  return TestedModel(
    json['tg'] as String,
    json['tt'] as String,
    json['nm'] as String?,
    json['ma'] as String?,
    json['sc'] as String,
    json['tr'] as String,
    json['tc'] as String,
    json['co'] as String,
    json['is'] as String,
    json['ci'] as String,
    json['rd'] as String?,
  );
}

Map<String, dynamic> _$TestedModelToJson(TestedModel instance) =>
    <String, dynamic>{
      'tg': instance.disease,
      'co': instance.country,
      'is': instance.certificateIssuer,
      'ci': instance.certificateIdentifier,
      'tt': instance.typeOfTest,
      'nm': instance.testName,
      'ma': instance.testNameAndManufacturer,
      'sc': instance.dateTimeOfCollection,
      'tr': instance.testResult,
      'tc': instance.testingCentre,
      'rd': instance.reportDate,
    };
