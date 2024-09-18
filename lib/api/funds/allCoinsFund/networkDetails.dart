import 'package:json_annotation/json_annotation.dart';

part 'networkDetails.g.dart';

@JsonSerializable()
class NetworkDetails {

  @JsonKey(name:"_id")
  String? id;

  @JsonKey(name:"symbol")
  String? symbol;

  @JsonKey(name:"techSymbol")
  String? techSymbol;

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"createdAt")
  String? createdAt;

  @JsonKey(name:"updatedAt")
  String? updatedAt;

  @JsonKey(name:"contractAddress")
  String? contractAddress;

  @JsonKey(name:"decimals")
  int? decimals;

  @JsonKey(name:"network")
  String? network;


  NetworkDetails({this.id,this.symbol, this.techSymbol, this.uniqueId, this.createdAt, this.updatedAt,
    this.contractAddress, this.decimals, this.network});

  factory NetworkDetails.fromJson(Map<String, dynamic> json) =>  _$NetworkDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$NetworkDetailsToJson(this);

}