import 'dart:async';

import 'package:cryptox/api/notification/getAllUserNotifications/getAllNotifications.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/api.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class Notification extends StatefulWidget {
  @override
  _Notification createState() => _Notification();
}

class _Notification extends State<Notification> {

  late StreamSubscription notifySubscription;
  late StreamSubscription notifyUpdateSubscription;
  bool isLoading = true;
  List<MobileNotificationsStruct> allNotifications = [];

  void initState() {
    super.initState();
    notifySubscription = apiCalls.notification$.listen((value) {
      // print("GOT NOTIFICATION RESP ON PAGE "+ value.toString());
      if(value is String) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      if(value is List<MobileNotificationsStruct>) {
        setState(() {
          allNotifications = value;
          isLoading = false;
        });
      }
    });
    notifyUpdateSubscription = apiCalls.notificationUpdate$.listen((value) {
      if(value.toString().isNotEmpty) {
        print("UPDATED NOTIFICATION");
      }
    });
    apiCalls.getUserNotification(context);
  }

  @override
  void dispose() {
    super.dispose();
    notifySubscription.cancel();
    notifyUpdateSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text('Notifications', style: white16SemiBoldTextStyle),
        ),
      body: isLoading ? SkeletonListView() : ListView.builder(
          shrinkWrap: true,
          itemCount: allNotifications.length,
          itemBuilder: (BuildContext context, int index) {
            MobileNotificationsStruct item = allNotifications[index];
            //var parsedDate = DateTime.fromMicrosecondsSinceEpoch(int.parse(item.createdAt!.toString() + "000"));
            //double finalAmount = item.amount! - double.parse(item.deductedAmt!.isEmpty ? "0.0" : item.deductedAmt!);
            var parsedDate = DateTime.parse(item.createdAt!).add(Duration(minutes: 330));
            // print(parsedUpdatedDate.month);
            return Padding(
              padding: const EdgeInsets.only(top: 4.0,bottom: 4.0,left: 6.0,right: 6.0),
              child: GestureDetector(
                onTap: () {
                  apiCalls.updateOpenNotification({"uniqueId": item.uniqueId}, context).then((value) {
                    bottomSheet(item);
                  });
                },
                child: Container(
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title!,style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                          maxLines: 2),
                        height5Space,
                        Text(item.body!,style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
                        height5Space,
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('Created' + ': ' +'${parsedDate.day}/${parsedDate.month}/${parsedDate.year}'
                              ' ${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0)),
                        ),
                       /* Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(item.body!,style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12))),
                            Text('Created' + ': ' +'${parsedDate.day}/${parsedDate.month}/${parsedDate.year}'
                                ' ${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0)),
                          ],
                        )*/
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      )
    );
  }

  void bottomSheet(MobileNotificationsStruct item) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          //borderRadius: BorderRadius.circular(10.0)
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(left: 16,right: 16),
            child: ListView(
              children: [
                SizedBox(height: 30,),
                Image.network(mobileNotifyImage),
                height20Space,
                Text('Hello' +',',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black45)),
                Text(item.title!,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black45)),
                heightSpace,
                rowText(item.device!, deviceImageUrl),
                height5Space,
                rowText(item.createdAt!, timeImageUrl),
                height5Space,
                rowText(item.ip!, ipImageUrl),
                height5Space,
              ],
            ),
          );
        });
  }
  
  Widget rowText(String text, String imgUrl) {
    return Row(
      children: [
        Image.network(imgUrl,width: 50,height: 50),
        SizedBox(width: 5),
        Text(text,style: TextStyle(fontWeight: FontWeight.w600))
      ],
    );
  }

}