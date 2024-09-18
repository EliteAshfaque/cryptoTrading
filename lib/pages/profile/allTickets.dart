import 'dart:async';

import 'package:cryptox/api/helpDesk/createTicket/createTicket.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/pages/profile/ticketChat/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:skeletons/skeletons.dart';

class AllTickets extends StatefulWidget {
  @override
  _AllTickets createState() => _AllTickets();
}

class _AllTickets extends State<AllTickets> with AutomaticKeepAliveClientMixin {

  List<HelpDeskTicketStruct> allTickets = [];
  late StreamSubscription ticketSubscription;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    ticketSubscription = apiCalls.ticket$.listen((value) {
      if(value is String) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      if(value is List<HelpDeskTicketStruct>) {
        setState(() {
          allTickets = value;
          isLoading = false;
        });
      }
    });
    apiCalls.getAllTicket(context);
  }

  @override
  void dispose() {
    super.dispose();
    ticketSubscription.cancel();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading ? SkeletonListView() : ListView.builder(
        shrinkWrap: true,
        itemCount: allTickets.length,
        itemBuilder: (BuildContext context, int index) {
          HelpDeskTicketStruct item = allTickets[index];
          var parsedCreatedDate = DateTime.parse(item.created_at!).add(Duration(minutes: 330));
          var parsedUpdatedDate = DateTime.parse(item.updated_at!).add(Duration(minutes: 330));
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  PageTransition(type: PageTransitionType.fade, child: ChatScreen(ticket: item)));
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 75.0,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      color: blackColor.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Id: "+item.id!.toString(), style: TextStyle(color: Color(0xff000000),
                                  fontWeight: FontWeight.w600)),
                              Container(
                                margin: EdgeInsets.only(left: 8.0),
                                child: Text("Status: ${statusCheck(item.status!)}",style: TextStyle(
                                    color: item.status == 5 ? Color(0xff0E8730) : Color(0xffE1A303),
                                    fontWeight: FontWeight.w600, fontSize: 12.0)),
                              )
                            ],
                          ),
                          height5Space,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("Sub: "+ item.subject!,style: TextStyle(
                                    color: Color(0xff959595), fontWeight: FontWeight.w600,
                                    fontSize: 11.0)),
                              ),
                              Text("${parsedCreatedDate.day}/${parsedCreatedDate.month}/${parsedCreatedDate.year}"
                                  " ${parsedCreatedDate.hour}:${parsedCreatedDate.minute}:${parsedCreatedDate.second}",
                                  style: TextStyle(color: Color(0xff959595),
                                      fontWeight: FontWeight.w600, fontSize: 11.0)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    height5Space,
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 14.0, right: 14.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Req Id: ${item.requester_id}',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0, color: Colors.white)),
                            Text('Updated: ${parsedUpdatedDate.day}/${parsedUpdatedDate.month}/${parsedUpdatedDate.year}'
                                ' ${parsedUpdatedDate.hour}:${parsedUpdatedDate.minute}:${parsedUpdatedDate.second}',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0, color: Colors.white))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  String statusCheck(int number) {
    String val = "";
    switch (number) {
      case 2: {
        val = "OPEN";
        break;
      }
      case 3: {
        val = "PENDING";
        break;
      }
      case 4: {
        val = "RESOLVED";
        break;
      }
      case 5: {
        val = "CLOSED";
        break;
      }
    }
    return val;
  }

}