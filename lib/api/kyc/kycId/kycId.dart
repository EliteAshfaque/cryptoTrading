import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kycId.g.dart';

@JsonSerializable()
class KycIdApiStruct extends Base {
  KycIdApiStruct({required bool success})
      : super(result: Result(message: KycStruct), success: success);

  factory KycIdApiStruct.fromJson(Map<String, dynamic> json) =>
      _$KycIdApiStructFromJson(json);

  Map<String, dynamic> toJson() => _$KycIdApiStructToJson(this);
}

@JsonSerializable()
class KycStruct {
  @JsonKey(name: "failedReason")
  String? failedReason;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "aadhaarBackDocId")
  String? aadhaarBackDocId;

  @JsonKey(name: "aadhaarFrontDocId")
  String? aadhaarFrontDocId;

  @JsonKey(name: "createdAt")
  String? createdAt;

  @JsonKey(name: "docsArr")
  List<KycDocsArr>? docsArr;

  @JsonKey(name: "panDocId")
  String? panDocId;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "uniqueId")
  String? uniqueId;

  @JsonKey(name: "userDocId")
  String? userDocId;

  @JsonKey(name: "userImgId")
  String? userImgId;

  @JsonKey(name: "aadhaarNumber")
  String? aadhaarNumber;

  @JsonKey(name: "panNumber")
  String? panNumber;

  @JsonKey(name: "originalOrderQty")
  String? originalOrderQty;

  @JsonKey(name: "orderPrice")
  String? orderPrice;

  KycStruct(
      {this.uniqueId,
      this.email,
      this.createdAt,
      this.originalOrderQty,
      this.orderPrice,
      this.status,
      this.aadhaarBackDocId,
      this.aadhaarFrontDocId,
      this.aadhaarNumber,
      this.docsArr,
      this.failedReason,
      this.panDocId,
      this.panNumber,
      this.userDocId,
      this.userImgId});

  factory KycStruct.fromJson(Map<String, dynamic> json) =>
      _$KycStructFromJson(json);

  Map<String, dynamic> toJson() => _$KycStructToJson(this);
}

@JsonSerializable()
class KycDocsArr {
  @JsonKey(name: "docType")
  String? docType;

  @JsonKey(name: "status")
  bool? status;

  KycDocsArr({this.status, this.docType});

  factory KycDocsArr.fromJson(Map<String, dynamic> json) =>
      _$KycDocsArrFromJson(json);

  Map<String, dynamic> toJson() => _$KycDocsArrToJson(this);
}
