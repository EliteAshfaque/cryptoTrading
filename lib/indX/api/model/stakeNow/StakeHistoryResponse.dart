import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'StakeHistory.dart';

part 'StakeHistoryResponse.g.dart';

@JsonSerializable()
class StakeHistoryResponse extends BasicResponse {
  @JsonKey(name: "stakeHistory")
  List<StakeHistory>? stakeHistory;



  StakeHistoryResponse(
      {this.stakeHistory});

  factory StakeHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StakeHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StakeHistoryResponseToJson(this);
}
