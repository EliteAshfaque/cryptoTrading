import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import '../activateUser/TopupDataByUserId.dart';
import 'LiveRateData.dart';

part 'GetCurrencyListResponse.g.dart';

@JsonSerializable()
class GetCurrencyListResponse extends BasicResponse {
  @JsonKey(name: "fiatCurrID")
  int? fiatCurrID;
  @JsonKey(name: "fiatCurrName")
  String? fiatCurrName;
  @JsonKey(name: "fiatCurrSymbol")
  String? fiatCurrSymbol;
  @JsonKey(name: "fiatImageUrl")
  String? fiatImageUrl;
  @JsonKey(name: "fiatTechnologyId")
  int? fiatTechnologyId;
  @JsonKey(name: "data")
  List<LiveRateData>? data;


  GetCurrencyListResponse(
      {this.fiatCurrID,
      this.fiatCurrName,
      this.fiatCurrSymbol,
      this.fiatImageUrl,
      this.fiatTechnologyId,
      this.data});

  factory GetCurrencyListResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCurrencyListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrencyListResponseToJson(this);
}
