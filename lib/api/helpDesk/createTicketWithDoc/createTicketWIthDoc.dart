import 'package:cryptox/api/base.dart';
import 'package:cryptox/api/helpDesk/createTicket/createTicket.dart';
import 'package:json_annotation/json_annotation.dart';

part 'createTicketWIthDoc.g.dart';

@JsonSerializable()
class CreateTicketWithDocApiStruct extends Base {

  CreateTicketWithDocApiStruct({required bool success}) : super(result: Result(message: HelpDeskTicketStruct),
      success: success);

  factory CreateTicketWithDocApiStruct.fromJson(Map<String, dynamic> json) =>
      _$CreateTicketWithDocApiStructFromJson(json);
  Map<String, dynamic> toJson() => _$CreateTicketWithDocApiStructToJson(this);
}
