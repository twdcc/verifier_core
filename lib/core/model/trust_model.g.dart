// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrustModel _$TrustModelFromJson(Map<String, dynamic> json) {
  return TrustModel(
    json['kid'] as String,
    json['country'] as String,
    json['signature'] as String?,
    json['rawData'] as String?,
  );
}

Map<String, dynamic> _$TrustModelToJson(TrustModel instance) =>
    <String, dynamic>{
      'kid': instance.kid,
      'country': instance.country,
      'signature': instance.signature,
      'rawData': instance.rawData,
    };
