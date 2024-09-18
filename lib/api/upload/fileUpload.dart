import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fileUpload.g.dart';

@JsonSerializable()
class FileUploadApiStruct extends Base {

  FileUploadApiStruct({required bool success})
      : super(result: Result(message: FileUploadApiResp),
      success: success);

  factory FileUploadApiStruct.fromJson(Map<String, dynamic> json) =>
      _$FileUploadApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$FileUploadApiStructToJson(this);
}

@JsonSerializable()
class FileUploadApiResp {

  @JsonKey(name:"data")
  DocumentsStruct? data;

  @JsonKey(name:"totalCount")
  int? totalCount;

  FileUploadApiResp({this.data, this.totalCount});

  factory FileUploadApiResp.fromJson(Map<String, dynamic> json) =>
      _$FileUploadApiRespFromJson(json);
  Map<String, dynamic> toJson() => _$FileUploadApiRespToJson(this);

}

@JsonSerializable()
class DocumentsStruct {

  @JsonKey(name:"uniqueId")
  String? uniqueId;

  @JsonKey(name:"email")
  String? email;

  @JsonKey(name:"type")
  String? type;

  @JsonKey(name:"path")
  String? path;

  DocumentsStruct({this.path, this.uniqueId, this.email, this.type});

  factory DocumentsStruct.fromJson(Map<String, dynamic> json) =>  _$DocumentsStructFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentsStructToJson(this);

}
