import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tradeHistory.g.dart';

@JsonSerializable()
class TradeHistoryApiStruct extends Base {

  TradeHistoryApiStruct({required bool success}) : super(result: Result(message: List<TradeHistoryStruct>), success: success);

  factory TradeHistoryApiStruct.fromJson(Map<String, dynamic> json) =>  _$TradeHistoryApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$TradeHistoryApiStructToJson(this);
}

@JsonSerializable()
class TradeHistoryStruct {

  @JsonKey(name:"price")
  String? price;

  @JsonKey(name:"qty")
  String? qty;

  @JsonKey(name:"symbol")
  String? symbol;

  @JsonKey(name:"colorBool")
  bool? colorBool;

  @JsonKey(name:"isDisplay")
  bool? isDisplay;

  @JsonKey(name:"createdAt")
  String? createdAt;


  TradeHistoryStruct({this.price, this.symbol, this.colorBool, this.createdAt, this.isDisplay, this.qty});

  factory TradeHistoryStruct.fromJson(Map<String, dynamic> json) =>  _$TradeHistoryStructFromJson(json);
  Map<String, dynamic> toJson() => _$TradeHistoryStructToJson(this);

}
