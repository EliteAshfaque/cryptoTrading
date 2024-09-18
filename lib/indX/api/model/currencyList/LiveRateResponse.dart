import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'AllowTransferMapping.dart';
import 'CurrencyToWalletTransferMapping.dart';

part 'LiveRateResponse.g.dart';

@JsonSerializable()
class LiveRateResponse extends BasicResponse{
  @JsonKey(name: "conversionId")
  int? conversionId;
  @JsonKey(name: "liveRate")
  double? liveRate;


  LiveRateResponse(
      {this.conversionId,
      this.liveRate});

  factory LiveRateResponse.fromJson(Map<String, dynamic> json) =>
      _$LiveRateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LiveRateResponseToJson(this);
}


