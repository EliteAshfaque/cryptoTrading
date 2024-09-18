import 'package:cryptox/api/base.dart';
import 'package:cryptox/api/helpDesk/createTicket/createTicket.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allConversations.g.dart';

@JsonSerializable()
class AllConversationsApiStruct extends Base {

  AllConversationsApiStruct({required bool success}) : super(result: Result(message: List<ConversationsStruct>),
      success: success);

  factory AllConversationsApiStruct.fromJson(Map<String, dynamic> json) =>
      _$AllConversationsApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$AllConversationsApiStructToJson(this);
}

@JsonSerializable()
class ConversationsStruct {

  @JsonKey(name:"body")
  String? body;

  @JsonKey(name:"body_text")
  String? body_text;

  @JsonKey(name:"incoming")
  bool? incoming;

  @JsonKey(name:"private")
  bool? private;

  @JsonKey(name:"user_id")
  int? user_id;

  @JsonKey(name:"support_email")
  String? support_email;

  @JsonKey(name:"to_emails")
  List<String>? to_emails;

  @JsonKey(name:"from_email")
  String? from_email;

  @JsonKey(name:"id")
  int? id;

  @JsonKey(name:"ticket_id")
  int? ticket_id;

  @JsonKey(name:"created_at")
  String? created_at;

  @JsonKey(name:"updated_at")
  String? updated_at;

  @JsonKey(name:"source")
  int? source;

  @JsonKey(name:"category")
  int? category;

  @JsonKey(name:"attachments")
  List<AttachmentsStruct>? attachments;

  ConversationsStruct({this.id, this.created_at, this.updated_at, this.source, this.attachments,
    this.body, this.body_text, this.category, this.from_email, this.incoming, this.private, this.support_email,
    this.ticket_id, this.to_emails, this.user_id});

  factory ConversationsStruct.fromJson(Map<String, dynamic> json) =>  _$ConversationsStructFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationsStructToJson(this);

}