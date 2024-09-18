import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

import 'networkDetails.dart';

part 'allCoinsFund.g.dart';

@JsonSerializable()
class AllCoinsFundApiStruct extends Base {

  AllCoinsFundApiStruct({required bool success}) : super(result: Result(message: FundsDummyStruct),
      success: success);

  factory AllCoinsFundApiStruct.fromJson(Map<String, dynamic> json) =>  _$AllCoinsFundApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$AllCoinsFundApiStructToJson(this);
}

@JsonSerializable()
class FundsDummyStruct {

  @JsonKey(name:"allFunds")
  List<FundsStruct>? allFunds;

  @JsonKey(name:"userInrWallet")
  UserInrWalletStruct? userInrWallet;

  FundsDummyStruct({this.allFunds, this.userInrWallet});

  factory FundsDummyStruct.fromJson(Map<String, dynamic> json) =>  _$FundsDummyStructFromJson(json);
  Map<String, dynamic> toJson() => _$FundsDummyStructToJson(this);

}

@JsonSerializable()
class UserInrWalletStruct {

  @JsonKey(name:"active")
  bool? active;

  @JsonKey(name:"actualBalance")
  String? actualBalance;

  @JsonKey(name:"balance")
  String? balance;

  @JsonKey(name:"createdAt")
  int? createdAt;

  @JsonKey(name:"currency")
  String? currency;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"freezeAmount")
  String? freezeAmount;

  @JsonKey(name:"type")
  String? type;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  UserInrWalletStruct({this.balance, this.email, this.uniqueId, this.currency, this.createdAt,
    this.type, this.active, this.freezeAmount, this.actualBalance});

  factory UserInrWalletStruct.fromJson(Map<String, dynamic> json) =>  _$UserInrWalletStructFromJson(json);
  Map<String, dynamic> toJson() => _$UserInrWalletStructToJson(this);

}


@JsonSerializable()
class FundsStruct {

  @JsonKey(name:"balance")
  String? balance;

  @JsonKey(name:"canDeposit")
  bool? canDeposit;

  @JsonKey(name:"canWithdrawal")
  bool? canWithdrawal;

  /*@JsonKey(name:"contractAddress")
  String? contractAddress;

  @JsonKey(name:"network")
  String? network;*/

  @JsonKey(name:"symbol")
  String? symbol;

  @JsonKey(name:"symbolName")
  String? symbolName;

  /*@JsonKey(name:"decimals")
  int? decimals;*/

  @JsonKey(name:"listed")
  int? listed;

  @JsonKey(name:"networkDetails")
  List<NetworkDetails>? networkDetails;

  /*@JsonKey(name:"networkTechSymbol")
  String? networkTechSymbol;

  @JsonKey(name:"networkSymbol")
  String? networkSymbol;*/

  /*FundsStruct({this.symbol,this.symbolName, this.network, this.balance, this.canDeposit, this.canWithdrawal,
    this.contractAddress, this.decimals, this.listed, this.networkTechSymbol, this.networkSymbol});*/

  FundsStruct({this.symbol,this.symbolName, this.balance, this.canDeposit, this.canWithdrawal,
    this.listed,  this.networkDetails});

  factory FundsStruct.fromJson(Map<String, dynamic> json) =>  _$FundsStructFromJson(json);
  Map<String, dynamic> toJson() => _$FundsStructToJson(this);

}