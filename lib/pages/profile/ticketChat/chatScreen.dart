import 'dart:async';

import 'package:cryptox/api/helpDesk/allConversations/allConversations.dart';
import 'package:cryptox/api/helpDesk/createTicket/createTicket.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/profile/ticketChat/message.dart';
import 'package:cryptox/pages/profile/ticketChat/message_attachment.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:cryptox/util/loader.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {

  final HelpDeskTicketStruct ticket;

  const ChatScreen({super.key, required this.ticket});

  @override
  _ChatScreen createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {

  List<ConversationsStruct> allConversations = [];
  late StreamSubscription conSubscription;
  late StreamSubscription replySubscription;
  TextEditingController msgController = new TextEditingController();
  String userEmail = "";
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getUserEmail().then((value) {
      setState(() {
        userEmail = value;
      });
    });
    conSubscription = apiCalls.conversations$.listen((value) {
      if(value is String) {
        return;
      }
      if(value is List<ConversationsStruct>) {
        // List has been reversed as we are applying reverse true in ListView so that
        // listView can pop up with keyboard...
        setState(() {
          allConversations = value.reversed.toList();
        });
      }
    });
    replySubscription = apiCalls.reply$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if(value is String) {
        return;
      }
      if(value is ConversationsStruct) {
        setState(() {
          // as list is reversed so appending at 0 index...
          allConversations.insert(0, value);
          msgController.text = "";
        });
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
    apiCalls.getAllConversations(widget.ticket.id!,context);
  }

  @override
  void dispose() {
    super.dispose();
    conSubscription.cancel();
    replySubscription.cancel();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          titleSpacing: 0.0,
          title: Text(
            widget.ticket.id!.toString(),
            style: white16SemiBoldTextStyle,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            // if(!isLoading)
            Expanded(
              child: ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  controller: controller,
                  itemCount: allConversations.length,
                  itemBuilder: (BuildContext context, int index) {
                    ConversationsStruct item = allConversations[index];
                    //bool flag = item.user_id! == widget.ticket.requester_id;
                    return Message(con: item, ticket: widget.ticket);
                  }
              ),
            ),
            Row(
              children: [
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    bottomSheet();
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: msgController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,//Normal textInputField will be displayed
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    if(msgController.text.isNotEmpty) {
                      Object body = {
                        "reply" : msgController.text,
                        "id" : widget.ticket.id!,
                        "user_id" : widget.ticket.requester_id
                      };
                      apiCalls.createReply(body, context);
                      LoadingOverlay.showLoader(context);
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
                SizedBox(width: 10),
              ],
            )
          ],
        )
    );
  }

  bottomSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0)
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return MessageAttachment(ticket: widget.ticket,msgController: msgController);
      }
    );
  }

}
