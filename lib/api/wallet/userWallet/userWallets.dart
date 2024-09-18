import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../funds/allCoinsFund/allCoinsFund.dart';
import '../../funds/allCoinsFund/networkDetails.dart';

part 'userWallets.g.dart';

@JsonSerializable()
class UserWalletStruct extends Base {

  UserWalletStruct({required bool success}) : super(result: Result(message: List<Wallet>), success: success);

  factory UserWalletStruct.fromJson(Map<String, dynamic> json) =>  _$UserWalletStructFromJson(json);
  Map<String, dynamic> toJson() => _$UserWalletStructToJson(this);
}

@JsonSerializable()
class Wallet {

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

  @JsonKey(name:"maxAmount")
  int? maxAmount;

  @JsonKey(name:"minAmount")
  int? minAmount;

  @JsonKey(name:"type")
  String? type;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"updatedAt")
  String? updatedAt;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"listedPair")
  String? listedPair;

  @JsonKey(name:"total")
  double? total;

  @JsonKey(name:"symbolName")
  String? symbolName;

  /*@JsonKey(name:"network")
  String? network;*/

  @JsonKey(name:"network")
  List<NetworkDetails>? network;

  /*@JsonKey(name:"networkSymbol")
  String? networkSymbol;*/

  @JsonKey(name:"canDeposit")
  bool? canDeposit;

  @JsonKey(name:"canWithdrawal")
  bool? canWithdrawal;

  /*@JsonKey(name:"contractAddress")
  String? contractAddress;*/

  Wallet({this.createdAt, this.updatedAt, this.email, this.name = "", this.active, this.actualBalance,this.balance,
    this.currency, this.freezeAmount, this.maxAmount, this.minAmount, this.type, this.uniqueId,this.total,
    this.listedPair, this.symbolName, this.network, /*this.networkSymbol,*/ this.canDeposit, this.canWithdrawal,
    /*this.contractAddress*/});

  factory Wallet.fromJson(Map<String, dynamic> json) =>  _$WalletFromJson(json);
  Map<String, dynamic> toJson() => _$WalletToJson(this);

}