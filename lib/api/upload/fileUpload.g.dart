// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fileUpload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileUploadApiStruct _$FileUploadApiStructFromJson(Map<String, dynamic> json) =>
    FileUploadApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$FileUploadApiStructToJson(
        FileUploadApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

FileUploadApiResp _$FileUploadApiRespFromJson(Map<String, dynamic> json) =>
    FileUploadApiResp(
      data: json['data'] == null
          ? null
          : DocumentsStruct.fromJson(json['data'] as Map<String, dynamic>),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FileUploadApiRespToJson(FileUploadApiResp instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

DocumentsStruct _$DocumentsStructFromJson(Map<String, dynamic> json) =>
    DocumentsStruct(
      path: json['path'] as String?,
      uniqueId: json['uniqueId'] as String?,
      email: json['email'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$DocumentsStructToJson(DocumentsStruct instance) =>
    <String, dynamic>{
      'uniqueId': instance.uniqueId,
      'email': instance.email,
      'type': instance.type,
      'path': instance.path,
    };
