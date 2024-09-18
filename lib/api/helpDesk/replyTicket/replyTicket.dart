import 'package:cryptox/api/base.dart';
import 'package:cryptox/api/helpDesk/createTicket/createTicket.dart';
import 'package:json_annotation/json_annotation.dart';

part 'replyTicket.g.dart';

@JsonSerializable()
class ReplyTicketApiStruct extends Base {

  ReplyTicketApiStruct({required bool success}) : super(result: Result(message: ReplyTicketStruct),
      success: success);

  factory ReplyTicketApiStruct.fromJson(Map<String, dynamic> json) =>  _$ReplyTicketApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyTicketApiStructToJson(this);
}

@JsonSerializable()
class ReplyTicketStruct {

  @JsonKey(name:"id")
  int? id;

  @JsonKey(name:"user_id")
  int? user_id;

  @JsonKey(name:"from_email")
  String? from_email;

  @JsonKey(name:"cc_emails")
  List<String>? cc_emails;

  @JsonKey(name:"bcc_emails")
  List<String>? bcc_emails;

  @JsonKey(name:"body")
  String? body;

  @JsonKey(name:"body_text")
  String? body_text;

  @JsonKey(name:"ticket_id")
  int? ticket_id;

  @JsonKey(name:"to_emails")
  List<String>? to_emails;

  @JsonKey(name:"created_at")
  String? created_at;

  @JsonKey(name:"updated_at")
  String? updated_at;

  @JsonKey(name:"attachments")
  List<AttachmentsStruct>? attachments;

  ReplyTicketStruct({this.id, this.attachments, this.cc_emails, this.created_at, this.updated_at, this.user_id,
    this.to_emails, this.ticket_id, this.from_email, this.body_text, this.body, this.bcc_emails});

  factory ReplyTicketStruct.fromJson(Map<String, dynamic> json) =>  _$ReplyTicketStructFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyTicketStructToJson(this);

}