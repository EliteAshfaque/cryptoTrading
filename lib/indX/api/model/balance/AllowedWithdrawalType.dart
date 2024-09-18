import 'package:json_annotation/json_annotation.dart';

part 'AllowedWithdrawalType.g.dart';

@JsonSerializable()
class AllowedWithdrawalType {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "serviceId")
  int? serviceId;
  @JsonKey(name: "walletId")
  int? walletId;
  @JsonKey(name: "isActive")
  bool? isActive;
  @JsonKey(name: "serviceName")
  String? serviceName;


  AllowedWithdrawalType(
      {this.id,
      this.serviceId,
      this.walletId,
      this.isActive,
      this.serviceName});

  factory AllowedWithdrawalType.fromJson(Map<String, dynamic> json) =>
      _$AllowedWithdrawalTypeFromJson(json);

  Map<String, dynamic> toJson() => _$AllowedWithdrawalTypeToJson(this);
}
