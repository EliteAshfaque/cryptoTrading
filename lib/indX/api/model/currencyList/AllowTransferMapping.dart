import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'AllowTransferMapping.g.dart';

@JsonSerializable()
class AllowTransferMapping {
  
  @JsonKey(name: "serviceId")
 
  int? serviceId;
  @JsonKey(name: "serviceName")
 
  String? serviceName;
  @JsonKey(name: "currencyId")
 
  int? currencyId;
  @JsonKey(name: "currencyName")
 
  String? currencyName;
  @JsonKey(name: "currencySymbol")
 
  String? currencySymbol;


  AllowTransferMapping(
      {this.serviceId,
      this.serviceName,
      this.currencyId,
      this.currencyName,
      this.currencySymbol});

  factory AllowTransferMapping.fromJson(Map<String, dynamic> json) =>
      _$AllowTransferMappingFromJson(json);

  Map<String, dynamic> toJson() => _$AllowTransferMappingToJson(this);
}
