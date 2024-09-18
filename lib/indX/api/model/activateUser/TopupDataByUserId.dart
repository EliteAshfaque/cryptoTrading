import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';
import 'PackageList.dart';
import 'WalletTypeList.dart';

part 'TopupDataByUserId.g.dart';

@JsonSerializable()
class TopupDataByUserId {
  @JsonKey(name: "oid")
  int? oid;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "walletTypeList")
  List<WalletTypeList>? walletTypeList;
  @JsonKey(name: "packageList")
  List<PackageList>? packageList;


  TopupDataByUserId(
      {this.oid, this.name, this.walletTypeList, this.packageList});

  factory TopupDataByUserId.fromJson(Map<String, dynamic> json) =>
      _$TopupDataByUserIdFromJson(json);

  Map<String, dynamic> toJson() => _$TopupDataByUserIdToJson(this);
}
