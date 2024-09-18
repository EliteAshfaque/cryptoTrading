import 'package:cryptox/api/Order/placedOrderEntries/placeOrderEntries.dart';
import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cancelOrder.g.dart';

@JsonSerializable()
class CancelOrderApiStruct extends Base {

  CancelOrderApiStruct({required bool success}) : super(result: Result(message: OrderSchedulerStruct),
      success: success);

  factory CancelOrderApiStruct.fromJson(Map<String, dynamic> json) =>  _$CancelOrderApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$CancelOrderApiStructToJson(this);
}
