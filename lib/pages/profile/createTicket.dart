import 'dart:async';

import 'package:cryptox/api/helpDesk/createTicket/createTicket.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/util/loader.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateTicket extends StatefulWidget {
  @override
  _CreateTicketState createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {

  TextEditingController subjectController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String userPhone = "";
  late StreamSubscription ticketSubscription;
  HelpDeskTicketStruct? ticket;

  @override
  void initState() {
    super.initState();
    getValueForKey(phone).then((value) {
      setState(() {
        userPhone = value;
      });
    });
    ticketSubscription = apiCalls.ticket$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if(value is String) {
        return;
      }
      if(value is HelpDeskTicketStruct) {
        setState(() {
          ticket = value;
        });
        showToast('Successfully created Ticket.', gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    ticketSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: ListView(
        children: [
          heightSpace,
          heightSpace,
          Theme(
            data: Theme.of(context).copyWith(
              primaryColor: primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
              child: TextField(
                style: black16MediumTextStyle,
                keyboardType: TextInputType.text,
                controller: subjectController,
                decoration: InputDecoration(
                  hintText: "Subject",
                  hintStyle: grey16MediumTextStyle,
                  fillColor: scaffoldBgColor,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: primaryColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
                  ),
                ),
              ),
            ),
          ),

          heightSpace,
          heightSpace,

          // Write here textfield start
          Padding(
            padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: TextField(
              controller: descController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              style: black16MediumTextStyle,
              decoration: InputDecoration(
                hintText: "Write here description",
                hintStyle: grey16MediumTextStyle,
                fillColor: scaffoldBgColor,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: primaryColor, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
                ),
              ),
            ),
          ),
          // Write here textfield end

          SizedBox(height: 30.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: () {
                if(subjectController.text.isNotEmpty && descController.text.isNotEmpty &&
                    userPhone.isNotEmpty) {
                  Object body = {
                    "description": descController.text,
                    "subject": subjectController.text,
                    "phone": userPhone
                  };
                  apiCalls.createTicket(body, context);
                  LoadingOverlay.showLoader(context);
                }else {
                  String field = "";
                  if(subjectController.text.isEmpty) {
                    field = "Subject";
                  }
                  if(descController.text.isEmpty) {
                    field = "Description";
                  }
                  if(phone.isEmpty) {
                    field = "Phone";
                  }
                  showToast('$field is Empty.', gravity: ToastGravity.BOTTOM,
                      toast: Toast.LENGTH_LONG);
                }
              },
              child: Container(
                padding: EdgeInsets.all(fixPadding * 1.0),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: primaryColor),
                child: Text(
                  'Submit',
                  style: white14BoldTextStyle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
