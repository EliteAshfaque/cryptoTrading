import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import '../activateUser/TopupDataByUserId.dart';
import 'CurrencyBalanceData.dart';
import 'LiveRateData.dart';

part 'GetCurrencyBalanceResponse.g.dart';

@JsonSerializable()
class GetCurrencyBalanceResponse extends BasicResponse {
  @JsonKey(name: "data")
  CurrencyBalanceData? data;


  GetCurrencyBalanceResponse({this.data});

  factory GetCurrencyBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCurrencyBalanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrencyBalanceResponseToJson(this);
}
