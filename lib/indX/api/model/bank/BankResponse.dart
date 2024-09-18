import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'BankData.dart';

part 'BankResponse.g.dart';

@JsonSerializable()
class BankResponse extends BasicResponse {
  
  @JsonKey(name: "bankMasters")
  List<BankData>? bankMasters;
  @JsonKey(name: "banks")
  List<BankData>? banks;
  @JsonKey(name: "aepsBanks")
  List<BankData>? aepsBanks;
  

  BankResponse(
      {this.bankMasters,
      this.banks,
      this.aepsBanks});

  factory BankResponse.fromJson(Map<String, dynamic> json) =>
      _$BankResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BankResponseToJson(this);
}
