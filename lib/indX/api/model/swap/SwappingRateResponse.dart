import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'SwappingCurrencyListData.dart';

part 'SwappingRateResponse.g.dart';

@JsonSerializable()
class SwappingRateResponse extends BasicResponse {

  @JsonKey(name: "fromCurrencyId")
  int? fromCurrencyId;
  @JsonKey(name: "toCurrencyId")
  int? toCurrencyId;
  @JsonKey(name: "fromCurrencyName")
  String? fromCurrencyName;
  @JsonKey(name: "toCurrencyName")
  String? toCurrencyName;
  @JsonKey(name: "rate")
  double? rate;


  SwappingRateResponse(
      {this.fromCurrencyId,
      this.toCurrencyId,
      this.fromCurrencyName,
      this.toCurrencyName,
      this.rate});

  factory SwappingRateResponse.fromJson(Map<String, dynamic> json) =>
      _$SwappingRateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SwappingRateResponseToJson(this);
}
