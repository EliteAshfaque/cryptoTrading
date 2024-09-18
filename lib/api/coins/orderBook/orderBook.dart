import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderBook.g.dart';

@JsonSerializable()
class OrderBookStruct extends Base {

  OrderBookStruct({required bool success}) : super(result: Result(message: AllOrderResponse), success: success);

  factory OrderBookStruct.fromJson(Map<String, dynamic> json) =>  _$OrderBookStructFromJson(json);
  Map<String, dynamic> toJson() => _$OrderBookStructToJson(this);
}

@JsonSerializable()
class AllOrderResponse {

  @JsonKey(name:"buy")
  List<OrderResponse>? buy;

  @JsonKey(name:"sell")
  List<OrderResponse>? sell;

  AllOrderResponse({this.buy, this.sell});

  factory AllOrderResponse.fromJson(Map<String, dynamic> json) =>  _$AllOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AllOrderResponseToJson(this);

}

@JsonSerializable()
class OrderResponse {

  @JsonKey(name:"price")
  dynamic price;

  @JsonKey(name:"totalQty")
  double? totalQty;

  OrderResponse({this.price, this.totalQty});

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>  _$OrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);

}