import 'package:cryptox/api/base.dart';
import 'package:cryptox/api/helpDesk/createTicket/createTicket.dart';
import 'package:json_annotation/json_annotation.dart';

part 'allTickets.g.dart';

@JsonSerializable()
class AllTicketsApiStruct extends Base {

  AllTicketsApiStruct({required bool success}) : super(result: Result(message: List<HelpDeskTicketStruct>),
      success: success);

  factory AllTicketsApiStruct.fromJson(Map<String, dynamic> json) =>
      _$AllTicketsApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$AllTicketsApiStructToJson(this);
}
