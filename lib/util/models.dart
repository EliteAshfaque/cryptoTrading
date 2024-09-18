import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class OrderPlacingModel {
  String price;
  String qty;

  OrderPlacingModel({required this.price, required this.qty});

  factory OrderPlacingModel.fromJson(Map<String, dynamic> json) =>  _$OrderPlacingModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderPlacingModelToJson(this);
}

class AccountActionsModel {
  String name;
  IconData icon;
  String route;

  AccountActionsModel({required this.name, required this.icon, required this.route});
}

class LogDelFilter {
  String text;
  String type;

  LogDelFilter({required this.text, required this.type});
}