import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'placeOrderEntries.g.dart';

@JsonSerializable()
class PlaceOrderEntriesApiStruct extends Base {
  PlaceOrderEntriesApiStruct({required bool success})
      : super(
            result: Result(message: PlacedAndCancelledApiResp),
            success: success);

  factory PlaceOrderEntriesApiStruct.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderEntriesApiStructFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOrderEntriesApiStructToJson(this);
}

@JsonSerializable()
class PlacedAndCancelledApiResp {
  @JsonKey(name: "data")
  List<OrderSchedulerStruct>? data;

  @JsonKey(name: "totalCount")
  int? totalCount;

  PlacedAndCancelledApiResp({this.data, this.totalCount});

  factory PlacedAndCancelledApiResp.fromJson(Map<String, dynamic> json) =>
      _$PlacedAndCancelledApiRespFromJson(json);

  Map<String, dynamic> toJson() => _$PlacedAndCancelledApiRespToJson(this);
}

@JsonSerializable()
class OrderSchedulerStruct {
  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "coin")
  String? coin;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "price")
  String? price;

  @JsonKey(name: "qty")
  String? qty;

  @JsonKey(name: "symbol")
  String? symbol;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "uniqueId")
  String? uniqueId;

  @JsonKey(name: "totalQty")
  String? totalQty;

  @JsonKey(name: "txId")
  String? txId;

  @JsonKey(name: "orderOriginalQty")
  String? orderOriginalQty;

  @JsonKey(name: "orderPrice")
  String? orderPrice;

  @JsonKey(name: "createdAt")
  String? createdAt;

  @JsonKey(name: "name")
  String? name;

  OrderSchedulerStruct(
      {this.name,
      this.createdAt,
      this.status,
      this.type,
      this.symbol,
      this.email,
      this.uniqueId,
      this.totalQty,
      this.coin,
      this.qty,
      this.price,
      this.orderOriginalQty,
      this.orderPrice,
      this.txId});

  factory OrderSchedulerStruct.fromJson(Map<String, dynamic> json) =>
      _$OrderSchedulerStructFromJson(json);

  Map<String, dynamic> toJson() => _$OrderSchedulerStructToJson(this);
}
