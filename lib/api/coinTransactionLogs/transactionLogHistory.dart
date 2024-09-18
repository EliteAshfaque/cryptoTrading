import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transactionLogHistory.g.dart';

@JsonSerializable()
class TransactionLogHistoryApiStruct extends Base {

  TransactionLogHistoryApiStruct({required bool success})
      : super(result: Result(message: TransactionLogHistoryApiResp),
      success: success);

  factory TransactionLogHistoryApiStruct.fromJson(Map<String, dynamic> json) =>
      _$TransactionLogHistoryApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionLogHistoryApiStructToJson(this);
}

@JsonSerializable()
class TransactionLogHistoryApiResp {

  @JsonKey(name:"data")
  List<TransactionLogsStruct>? data;

  @JsonKey(name:"totalCount")
  int? totalCount;

  TransactionLogHistoryApiResp({this.data, this.totalCount});

  factory TransactionLogHistoryApiResp.fromJson(Map<String, dynamic> json) =>  _$TransactionLogHistoryApiRespFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionLogHistoryApiRespToJson(this);

}

@JsonSerializable()
class TransactionLogsStruct {

  @JsonKey(name:"fromAddress")
  String? fromAddress;

  @JsonKey(name:"toAddress")
  String? toAddress;

  @JsonKey(name:"contractAddress")
  String? contractAddress;

  @JsonKey(name:"status")
  String? status;

  @JsonKey(name:"requestType")
  String? requestType;

  @JsonKey(name:"transactionHash")
  String? transactionHash;

  @JsonKey(name:"amount")
  double? amount;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"symbol")
  String? symbol;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"deductedAmt")
  String? deductedAmt;

  @JsonKey(name:"finalAmount")
  String? finalAmount;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name:"transferFrom")
  String? transferFrom;

  @JsonKey(name:"createdAt")
  String? createdAt;

  @JsonKey(name:"updatedAt")
  String? updatedAt;

  TransactionLogsStruct({this.status, this.uniqueId, this.email, this.symbol, this.contractAddress,
    this.message, this.amount, this.deductedAmt, this.finalAmount, this.fromAddress, this.requestType,
    this.toAddress, this.transactionHash, this.transferFrom, this.updatedAt, this.createdAt});

  factory TransactionLogsStruct.fromJson(Map<String, dynamic> json) =>  _$TransactionLogsStructFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionLogsStructToJson(this);

}
