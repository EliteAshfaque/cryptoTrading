import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'Bank.dart';

part 'BankPaymentModeResponse.g.dart';

@JsonSerializable()
class BankPaymentModeResponse extends BasicResponse {
  @JsonKey(name: "banks")
  List<Bank>? banks;

  BankPaymentModeResponse({this.banks});

  factory BankPaymentModeResponse.fromJson(Map<String, dynamic> json) =>
      _$BankPaymentModeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BankPaymentModeResponseToJson(this);
}
