import 'package:json_annotation/json_annotation.dart';

import '../BasicResponse.dart';

part 'BankAccountsData.g.dart';

@JsonSerializable()
class BankAccountsData {

 

  @JsonKey(name: "id")
  
   int? id;
  @JsonKey(name: "bankID")
  
   int? bankID;
  @JsonKey(name: "bankName")
  
   String? bankName;
  @JsonKey(name: "ifsc")
  
   String? ifsc;
  @JsonKey(name: "accountNumber")
  
   String? accountNumber;
  @JsonKey(name: "accountHolder")
  
   String? accountHolder;
  @JsonKey(name: "entryBy")
  
   int? entryBy;
  @JsonKey(name: "entryDate")
  
   String? entryDate;
  @JsonKey(name: "approvedBY")
  
   String? approvedBY;
  @JsonKey(name: "approvalIp")
  
   String? approvalIp;
  @JsonKey(name: "approvalDate")
  
   String? approvalDate;
  @JsonKey(name: "actualname")
  
   String? actualname;
  @JsonKey(name: "utr")
  
   String? utr;
  @JsonKey(name: "apiid")
  
   String? apiid;
  @JsonKey(name: "approvalStatus")
  
   int? approvalStatus;
  @JsonKey(name: "verificationStatus")
  
   int? verificationStatus;
  @JsonKey(name: "isdeleted")
  
   String? isdeleted;
  @JsonKey(name: "isDefault")
  
   bool? isDefault;
  @JsonKey(name: "verificationText")
  
   String? verificationText;
  @JsonKey(name: "approvalText")
  
   String? approvalText;
  @JsonKey(name: "bankselect")
  
   String? bankselect;
  @JsonKey(name: "requestdate")
  
   String? requestdate;
  @JsonKey(name: "mobileNo")
  
   String? mobileNo;
  @JsonKey(name: "name")
  
   String? name;
  @JsonKey(name: "requestID")
  
   int? requestID;
  @JsonKey(name: "loginID")
  
   int? loginID;
  @JsonKey(name: "loginTypeID")
  
   int? loginTypeID;
  @JsonKey(name: "userID")
  
   int? userID;
  @JsonKey(name: "commonInt")
  
   int? commonInt;
  @JsonKey(name: "commonInt2")
  
   int? commonInt2;
  @JsonKey(name: "commonStr")
  
   String? commonStr;
  @JsonKey(name: "commonStr2")
  
   String? commonStr2;
  @JsonKey(name: "isListType")
  
   bool? isListType;
  @JsonKey(name: "str")
  
   String? str;
  @JsonKey(name: "commonInt3")
  
   int? commonInt3;
  @JsonKey(name: "commonDecimal")
  
   double? commonDecimal;
  @JsonKey(name: "commonInt4")
  
   int? commonInt4;
  @JsonKey(name: "commonStr3")
  
   String? commonStr3;
  @JsonKey(name: "commonStr4")
  
   String? commonStr4;
  @JsonKey(name: "commonBool")
  
   bool? commonBool;
  @JsonKey(name: "commonBool1")
  
   bool? commonBool1;
  @JsonKey(name: "commonBool2")
  
   bool? commonBool2;
  @JsonKey(name: "commonChar")
  
   String? commonChar;


  BankAccountsData(
      {this.id,
      this.bankID,
      this.bankName,
      this.ifsc,
      this.accountNumber,
      this.accountHolder,
      this.entryBy,
      this.entryDate,
      this.approvedBY,
      this.approvalIp,
      this.approvalDate,
      this.actualname,
      this.utr,
      this.apiid,
      this.approvalStatus,
      this.verificationStatus,
      this.isdeleted,
      this.isDefault,
      this.verificationText,
      this.approvalText,
      this.bankselect,
      this.requestdate,
      this.mobileNo,
      this.name,
      this.requestID,
      this.loginID,
      this.loginTypeID,
      this.userID,
      this.commonInt,
      this.commonInt2,
      this.commonStr,
      this.commonStr2,
      this.isListType,
      this.str,
      this.commonInt3,
      this.commonDecimal,
      this.commonInt4,
      this.commonStr3,
      this.commonStr4,
      this.commonBool,
      this.commonBool1,
      this.commonBool2,
      this.commonChar});

  factory BankAccountsData.fromJson(Map<String, dynamic> json) =>
      _$BankAccountsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BankAccountsDataToJson(this);
}
