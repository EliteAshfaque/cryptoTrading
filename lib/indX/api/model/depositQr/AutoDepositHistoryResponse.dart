import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'AutoDepositHistory.dart';

part 'AutoDepositHistoryResponse.g.dart';

@JsonSerializable()
class AutoDepositHistoryResponse extends BasicResponse {
  @JsonKey(name: "data")
  List<AutoDepositHistory>? data;


  AutoDepositHistoryResponse(
      {this.data});

  factory AutoDepositHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AutoDepositHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AutoDepositHistoryResponseToJson(this);
}
