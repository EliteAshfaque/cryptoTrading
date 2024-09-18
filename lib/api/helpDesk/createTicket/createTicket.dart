import 'package:cryptox/api/base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'createTicket.g.dart';

@JsonSerializable()
class CreateTicketApiStruct extends Base {

  CreateTicketApiStruct({required bool success}) : super(result: Result(message: HelpDeskTicketStruct),
      success: success);

  factory CreateTicketApiStruct.fromJson(Map<String, dynamic> json) =>  _$CreateTicketApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$CreateTicketApiStructToJson(this);
}

@JsonSerializable()
class HelpDeskTicketStruct {

  @JsonKey(name:"cc_emails")
  List<String>? cc_emails;

  @JsonKey(name:"fwd_emails")
  List<String>? fwd_emails;

  @JsonKey(name:"spam")
  bool? spam;

  @JsonKey(name:"priority")
  int? priority;

  @JsonKey(name:"requester_id")
  int? requester_id;

  @JsonKey(name:"source")
  int? source;

  @JsonKey(name:"status")
  int? status;

  @JsonKey(name:"subject")
  String? subject;

  @JsonKey(name:"id")
  int? id;

  @JsonKey(name:"description_text")
  String? description_text;

  @JsonKey(name:"created_at")
  String? created_at;

  @JsonKey(name:"updated_at")
  String? updated_at;

  @JsonKey(name:"form_id")
  String? form_id;

  @JsonKey(name:"attachments")
  List<AttachmentsStruct>? attachments;

  HelpDeskTicketStruct({this.status, this.id, this.attachments, this.cc_emails, this.created_at,
    this.description_text, this.form_id, this.fwd_emails, this.priority, this.requester_id,
    this.source, this.spam, this.subject, this.updated_at});

  factory HelpDeskTicketStruct.fromJson(Map<String, dynamic> json) =>  _$HelpDeskTicketStructFromJson(json);
  Map<String, dynamic> toJson() => _$HelpDeskTicketStructToJson(this);

}

@JsonSerializable()
class AttachmentsStruct {

  @JsonKey(name:"id")
  int? id;

  @JsonKey(name:"content_type")
  String? content_type;

  @JsonKey(name:"size")
  int? size;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"attachment_url")
  String? attachment_url;

  @JsonKey(name:"created_at")
  String? created_at;

  @JsonKey(name:"updated_at")
  String? updated_at;

  AttachmentsStruct({this.updated_at, this.created_at, this.id, this.name, this.attachment_url,
    this.content_type, this.size});

  factory AttachmentsStruct.fromJson(Map<String, dynamic> json) =>  _$AttachmentsStructFromJson(json);
  Map<String, dynamic> toJson() => _$AttachmentsStructToJson(this);

}