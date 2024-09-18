import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'BankAccountsData.dart';

part 'GetBankAccountsResponse.g.dart';

@JsonSerializable()
class GetBankAccountsResponse extends BasicResponse {
  @JsonKey(name: "data")
  List<BankAccountsData>? data;

  GetBankAccountsResponse({this.data});

  factory GetBankAccountsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBankAccountsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBankAccountsResponseToJson(this);
}
