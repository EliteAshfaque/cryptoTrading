import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'completedOrderEntries.g.dart';

@JsonSerializable()
class CompletedOrderEntriesApiStruct extends Base {

  CompletedOrderEntriesApiStruct({required bool success})
      : super(result: Result(message: CompletedOrderApiResp),
      success: success);

  factory CompletedOrderEntriesApiStruct.fromJson(Map<String, dynamic> json) =>
      _$CompletedOrderEntriesApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$CompletedOrderEntriesApiStructToJson(this);
}

@JsonSerializable()
class CompletedOrderApiResp {

  @JsonKey(name:"data")
  List<OrderFillsStruct>? data;

  @JsonKey(name:"totalCount")
  int? totalCount;

  CompletedOrderApiResp({this.data, this.totalCount});

  factory CompletedOrderApiResp.fromJson(Map<String, dynamic> json) =>
      _$CompletedOrderApiRespFromJson(json);
  Map<String, dynamic> toJson() => _$CompletedOrderApiRespToJson(this);

}

@JsonSerializable()
class OrderFillsStruct {

  @JsonKey(name:"txId")
  String? txId;

  @JsonKey(name:"coinOrderId")
  String? coinOrderId;

  @JsonKey(name:"price")
  String? price;

  @JsonKey(name:"qty")
  String? qty;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"type")
  String? type;

  @JsonKey(name:"matchId")
  String? matchId;

  @JsonKey(name:"matchLedgerId")
  String? matchLedgerId;

  @JsonKey(name:"symbol")
  String? symbol;

  @JsonKey(name:"updatedAt")
  String? updatedAt;

  @JsonKey(name:"createdAt")
  String? createdAt;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"originalOrderQty")
  String? originalOrderQty;

  @JsonKey(name:"orderPrice")
  String? orderPrice;

  OrderFillsStruct({this.txId, this.orderPrice, this.price, this.qty, this.uniqueId, this.email, this.symbol,
    this.type, this.createdAt, this.name, this.updatedAt, this.coinOrderId, this.matchId, this.matchLedgerId,
    this.originalOrderQty});

  factory OrderFillsStruct.fromJson(Map<String, dynamic> json) =>  _$OrderFillsStructFromJson(json);
  Map<String, dynamic> toJson() => _$OrderFillsStructToJson(this);

}
