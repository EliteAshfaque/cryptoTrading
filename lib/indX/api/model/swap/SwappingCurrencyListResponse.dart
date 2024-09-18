import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'SwappingCurrencyListData.dart';

part 'SwappingCurrencyListResponse.g.dart';

@JsonSerializable()
class SwappingCurrencyListResponse extends BasicResponse {

  @JsonKey(name: "data")
  List<SwappingCurrencyListData>? data;


  SwappingCurrencyListResponse({this.data});

  factory SwappingCurrencyListResponse.fromJson(Map<String, dynamic> json) =>
      _$SwappingCurrencyListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SwappingCurrencyListResponseToJson(this);
}
