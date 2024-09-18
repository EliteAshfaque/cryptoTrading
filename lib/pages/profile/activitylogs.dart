import 'dart:async';

import 'package:cryptox/api/user/activityLogs/activityLogs.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ActivityLogs extends StatefulWidget {
  const ActivityLogs({Key? key}) : super(key: key);

  @override
  _ActivityLogs createState() => _ActivityLogs();
}

class _ActivityLogs extends State<ActivityLogs> {

  bool isLoading = true;
  List<ActivityLogsStruct> logs = [];
  late StreamSubscription activityLogsSubscription;

  @override
  void initState() {
    super.initState();
    activityLogsSubscription = apiCalls.userLogs$.listen((value) {
      if(value is String) {
        isLoading = false;
        return;
      }
      if(value is List<ActivityLogsStruct>) {
        setState(() {
          isLoading = false;
          logs = value;
        });
      }
    });
    apiCalls.getUserAuthLogs(context);
  }

  @override
  void dispose() {
    super.dispose();
    activityLogsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: Com.barGradient(),
            )
        ),
        title: Text(
          'Activity Logs',
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
      body: fiatRequestHistory(),
    );
  }

  Widget fiatRequestHistory() {
    return isLoading ? SkeletonListView() : ListView.builder(
        shrinkWrap: true,
        itemCount: logs.length,
        itemBuilder: (BuildContext context, int index) {
          ActivityLogsStruct item = logs[index];
          var parsedDate = DateTime.fromMicrosecondsSinceEpoch(int.parse(item.createdAt!.toString() + "000"));
          // var parsedUpdatedDate = DateTime.parse(item.updatedAt!);
          // print(parsedUpdatedDate.month);
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 90.0,
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
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date: ${parsedDate.day}/${parsedDate.month}/${parsedDate.year}'
                        ' ${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}',
                        style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w600)),
                    heightSpace,
                    Text("Ip: ${item.ip!.replaceFirst("::ffff:", "")}",style: TextStyle(color: Color(0xff959595),
                        fontWeight: FontWeight.w600, fontSize: 11.0
                    )),
                    height5Space,
                    Text("Activity: "+item.message!, style: TextStyle(color: Color(0xff959595),
                        fontWeight: FontWeight.w600, fontSize: 11.0
                    )),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

}