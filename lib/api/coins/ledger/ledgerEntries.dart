import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ledgerEntries.g.dart';

@JsonSerializable()
class LedgerEntriesApiStruct extends Base {

  LedgerEntriesApiStruct({required bool success})
      : super(result: Result(message: LedgerEntryApiResp),
      success: success);

  factory LedgerEntriesApiStruct.fromJson(Map<String, dynamic> json) =>
      _$LedgerEntriesApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$LedgerEntriesApiStructToJson(this);
}

@JsonSerializable()
class LedgerEntryApiResp {

  @JsonKey(name:"data")
  List<LedgerStruct>? data;

  @JsonKey(name:"totalCount")
  int? totalCount;

  LedgerEntryApiResp({this.data, this.totalCount});

  factory LedgerEntryApiResp.fromJson(Map<String, dynamic> json) =>
      _$LedgerEntryApiRespFromJson(json);
  Map<String, dynamic> toJson() => _$LedgerEntryApiRespToJson(this);

}

@JsonSerializable()
class LedgerStruct {

  @JsonKey(name:"requestId")
  String? requestId;

  @JsonKey(name:"txId")
  String? txId;

  @JsonKey(name:"referenceId")
  String? referenceId;

  @JsonKey(name:"charge")
  String? charge;

  @JsonKey(name:"openingBalance")
  String? openingBalance;

  @JsonKey(name:"amount")
  String? amount;

  @JsonKey(name:"createdAt")
  int? createdAt;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"closingBalance")
  String? closingBalance;

  @JsonKey(name:"type")
  String? type;

  @JsonKey(name:"remarks")
  String? remarks;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"symbol")
  String? symbol;

  @JsonKey(name:"transactionType")
  String? transactionType;

  @JsonKey(name:"utrNo")
  String? utrNo;

  LedgerStruct({this.uniqueId, this.txId, this.symbol, this.type, this.createdAt, this.email, this.amount,
    this.utrNo, this.charge, this.closingBalance, this.openingBalance, this.referenceId, this.remarks,
    this.requestId, this.transactionType});

  factory LedgerStruct.fromJson(Map<String, dynamic> json) =>  _$LedgerStructFromJson(json);
  Map<String, dynamic> toJson() => _$LedgerStructToJson(this);

}
