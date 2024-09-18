import 'package:cryptox/api/base.dart';
import 'package:cryptox/api/helpDesk/replyTicket/replyTicket.dart';
import 'package:json_annotation/json_annotation.dart';

part 'replyTicketWithDoc.g.dart';

@JsonSerializable()
class ReplyTicketWithDocApiStruct extends Base {

  ReplyTicketWithDocApiStruct({required bool success}) : super(result: Result(message: ReplyTicketStruct),
      success: success);

  factory ReplyTicketWithDocApiStruct.fromJson(Map<String, dynamic> json) =>
      _$ReplyTicketWithDocApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyTicketWithDocApiStructToJson(this);
}