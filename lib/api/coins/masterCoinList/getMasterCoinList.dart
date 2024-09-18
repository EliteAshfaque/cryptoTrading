import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../funds/allCoinsFund/networkDetails.dart';

part 'getMasterCoinList.g.dart';

@JsonSerializable()
class GetMasterCoinListApiStruct extends Base {

  GetMasterCoinListApiStruct({required bool success}) : super(result: Result(message: List<MasterCoinListingsStruct>),
      success: success);

  factory GetMasterCoinListApiStruct.fromJson(Map<String, dynamic> json) =>  _$GetMasterCoinListApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$GetMasterCoinListApiStructToJson(this);
}

@JsonSerializable()
class MasterCoinListingsStruct {

  @JsonKey(name:"_id")
  String? id;

  @JsonKey(name:"symbol")
  String? symbol;

  @JsonKey(name:"symbolName")
  String? symbolName;

  @JsonKey(name:"status")
  String? status;

  @JsonKey(name:"network")
  List<NetworkDetails>? network;

  @JsonKey(name:"canDeposit")
  bool? canDeposit;

  @JsonKey(name:"canWithdrawal")
  bool? canWithdrawal;

  @JsonKey(name:"imgUrl")
  String? imgUrl;

  @JsonKey(name:"minDeposit")
  String? minDeposit;

  @JsonKey(name:"maxDeposit")
  String? maxDeposit;

  @JsonKey(name:"minWithdrawal")
  String? minWithdrawal;

  @JsonKey(name:"maxWithdrawal")
  String? maxWithdrawal;

  @JsonKey(name:"displayName")
  String? displayName;

  @JsonKey(name:"listed")
  int? listed;

  @JsonKey(name:"createdAt")
  String? createdAt;

  @JsonKey(name:"updatedAt")
  String? updatedAt;

  @JsonKey(name:"depositFee")
  String? depositFee;

  @JsonKey(name:"withdrawalFee")
  String? withdrawalFee;

  @JsonKey(name:"adminApproval")
  bool? adminApproval;

  @JsonKey(name:"dedPercentage")
  String? dedPercentage;

  @JsonKey(name:"dedAmount")
  String? dedAmount;

  @JsonKey(name:"activeDed")
  String? activeDed;


  MasterCoinListingsStruct({this.updatedAt, this.createdAt, this.symbol, this.symbolName, this.id, this.imgUrl, this.listed, this.status, this.network, this.canDeposit, this.canWithdrawal,
    this.activeDed, this.adminApproval, this.dedAmount, this.dedPercentage, this.depositFee,
    this.displayName, this.maxDeposit, this.maxWithdrawal, this.minDeposit, this.minWithdrawal, this.withdrawalFee});

  factory MasterCoinListingsStruct.fromJson(Map<String, dynamic> json) =>  _$MasterCoinListingsStructFromJson(json);
  Map<String, dynamic> toJson() => _$MasterCoinListingsStructToJson(this);

}