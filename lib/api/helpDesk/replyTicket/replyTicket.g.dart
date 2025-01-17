// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'replyTicket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyTicketApiStruct _$ReplyTicketApiStructFromJson(
        Map<String, dynamic> json) =>
    ReplyTicketApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$ReplyTicketApiStructToJson(
        ReplyTicketApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

ReplyTicketStruct _$ReplyTicketStructFromJson(Map<String, dynamic> json) =>
    ReplyTicketStruct(
      id: (json['id'] as num?)?.toInt(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentsStruct.fromJson(e as Map<String, dynamic>))
          .toList(),
      cc_emails: (json['cc_emails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      user_id: (json['user_id'] as num?)?.toInt(),
      to_emails: (json['to_emails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ticket_id: (json['ticket_id'] as num?)?.toInt(),
      from_email: json['from_email'] as String?,
      body_text: json['body_text'] as String?,
      body: json['body'] as String?,
      bcc_emails: (json['bcc_emails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ReplyTicketStructToJson(ReplyTicketStruct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'from_email': instance.from_email,
      'cc_emails': instance.cc_emails,
      'bcc_emails': instance.bcc_emails,
      'body': instance.body,
      'body_text': instance.body_text,
      'ticket_id': instance.ticket_id,
      'to_emails': instance.to_emails,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'attachments': instance.attachments,
    };
