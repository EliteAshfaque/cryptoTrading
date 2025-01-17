// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'createTicket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTicketApiStruct _$CreateTicketApiStructFromJson(
        Map<String, dynamic> json) =>
    CreateTicketApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$CreateTicketApiStructToJson(
        CreateTicketApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

HelpDeskTicketStruct _$HelpDeskTicketStructFromJson(
        Map<String, dynamic> json) =>
    HelpDeskTicketStruct(
      status: (json['status'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentsStruct.fromJson(e as Map<String, dynamic>))
          .toList(),
      cc_emails: (json['cc_emails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      created_at: json['created_at'] as String?,
      description_text: json['description_text'] as String?,
      form_id: json['form_id'] as String?,
      fwd_emails: (json['fwd_emails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      priority: (json['priority'] as num?)?.toInt(),
      requester_id: (json['requester_id'] as num?)?.toInt(),
      source: (json['source'] as num?)?.toInt(),
      spam: json['spam'] as bool?,
      subject: json['subject'] as String?,
      updated_at: json['updated_at'] as String?,
    );

Map<String, dynamic> _$HelpDeskTicketStructToJson(
        HelpDeskTicketStruct instance) =>
    <String, dynamic>{
      'cc_emails': instance.cc_emails,
      'fwd_emails': instance.fwd_emails,
      'spam': instance.spam,
      'priority': instance.priority,
      'requester_id': instance.requester_id,
      'source': instance.source,
      'status': instance.status,
      'subject': instance.subject,
      'id': instance.id,
      'description_text': instance.description_text,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'form_id': instance.form_id,
      'attachments': instance.attachments,
    };

AttachmentsStruct _$AttachmentsStructFromJson(Map<String, dynamic> json) =>
    AttachmentsStruct(
      updated_at: json['updated_at'] as String?,
      created_at: json['created_at'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      attachment_url: json['attachment_url'] as String?,
      content_type: json['content_type'] as String?,
      size: (json['size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AttachmentsStructToJson(AttachmentsStruct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content_type': instance.content_type,
      'size': instance.size,
      'name': instance.name,
      'attachment_url': instance.attachment_url,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
    };
