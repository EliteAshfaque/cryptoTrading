import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'placeOrder.g.dart';

@JsonSerializable()
class PlaceOrderApiStruct extends Base {

  PlaceOrderApiStruct({required bool success}) : super(result: Result(message: List<PlaceOrderStruct>),
      success: success);

  factory PlaceOrderApiStruct.fromJson(Map<String, dynamic> json) =>  _$PlaceOrderApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceOrderApiStructToJson(this);
}

@JsonSerializable()
class PlaceOrderStruct {

  @JsonKey(name:"symbol")
  String? symbol;

  @JsonKey(name:"type")
  String? type;

  @JsonKey(name:"totalQty")
  String? totalQty;

  @JsonKey(name:"totalPrice")
  String? totalPrice;

  PlaceOrderStruct({this.type, this.totalQty, this.symbol, this.totalPrice});

  factory PlaceOrderStruct.fromJson(Map<String, dynamic> json) =>  _$PlaceOrderStructFromJson(json);
  Map<String, dynamic> toJson() => _$PlaceOrderStructToJson(this);

}
