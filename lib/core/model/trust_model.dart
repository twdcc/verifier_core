import 'package:json_annotation/json_annotation.dart';

part 'trust_model.g.dart';

@JsonSerializable()
class TrustModel {
  @JsonKey(name: 'kid')
  String kid;

  @JsonKey(name: 'country')
  String country;

  @JsonKey(name: 'signature')
  String? signature;

  @JsonKey(name: 'rawData')
  String? rawData;

  TrustModel(
    this.kid,
    this.country,
    this.signature,
    this.rawData,
  );

  factory TrustModel.fromJson(Map<String, dynamic> json) =>
      _$TrustModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrustModelToJson(this);
}
