import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'GetTechnologyQrResponse.g.dart';

@JsonSerializable()
class GetTechnologyQrResponse extends BasicResponse {
  @JsonKey(name: "technologyId")
  int? technologyId;
  @JsonKey(name: "techaddressUrl")
  String? techaddressUrl;
  @JsonKey(name: "technologyName")
  String? technologyName;
  @JsonKey(name: "techName")
  String? techName;
  @JsonKey(name: "techCode")
  String? techCode;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "depositCurrency")
  String? depositCurrency;
  @JsonKey(name: "isAutoDeposit")
  bool? isAutoDeposit;


  GetTechnologyQrResponse(
      {this.technologyId,
      this.techaddressUrl,
      this.technologyName,
      this.techName,
      this.techCode,
      this.address,
      this.depositCurrency,
      this.isAutoDeposit});

  factory GetTechnologyQrResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTechnologyQrResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTechnologyQrResponseToJson(this);
}
