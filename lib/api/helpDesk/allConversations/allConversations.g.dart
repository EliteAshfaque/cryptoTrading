// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allConversations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllConversationsApiStruct _$AllConversationsApiStructFromJson(
        Map<String, dynamic> json) =>
    AllConversationsApiStruct(
      success: json['success'] as bool,
    )..result = json['result'];

Map<String, dynamic> _$AllConversationsApiStructToJson(
        AllConversationsApiStruct instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result': instance.result,
    };

ConversationsStruct _$ConversationsStructFromJson(Map<String, dynamic> json) =>
    ConversationsStruct(
      id: (json['id'] as num?)?.toInt(),
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      source: (json['source'] as num?)?.toInt(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => AttachmentsStruct.fromJson(e as Map<String, dynamic>))
          .toList(),
      body: json['body'] as String?,
      body_text: json['body_text'] as String?,
      category: (json['category'] as num?)?.toInt(),
      from_email: json['from_email'] as String?,
      incoming: json['incoming'] as bool?,
      private: json['private'] as bool?,
      support_email: json['support_email'] as String?,
      ticket_id: (json['ticket_id'] as num?)?.toInt(),
      to_emails: (json['to_emails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      user_id: (json['user_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ConversationsStructToJson(
        ConversationsStruct instance) =>
    <String, dynamic>{
      'body': instance.body,
      'body_text': instance.body_text,
      'incoming': instance.incoming,
      'private': instance.private,
      'user_id': instance.user_id,
      'support_email': instance.support_email,
      'to_emails': instance.to_emails,
      'from_email': instance.from_email,
      'id': instance.id,
      'ticket_id': instance.ticket_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'source': instance.source,
      'category': instance.category,
      'attachments': instance.attachments,
    };
