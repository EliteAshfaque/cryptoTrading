import 'dart:async';

import 'package:cryptox/api/user/getUser/getUser.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:skeletons/skeletons.dart';

class Referral extends StatefulWidget {
  @override
  _Referral createState() => _Referral();
}

class _Referral extends State<Referral> {

  String referralLink = "";
  String referralCode = "";
  bool isLoading = false;
  List<IUserStruct> referrals = [];
  IUserStruct user = IUserStruct();
  StreamSubscription? referralSubscription;
  StreamSubscription? userSubscription;

  @override
  void initState() {
    super.initState();
    referralSubscription = apiCalls.referrals$.listen((value) {
      if(value is List<IUserStruct>) {
        setState(() {
          referrals = value;
        });
      }
    });
    // userSubscription = apiCalls.iUser$.listen((value) {
    //   if(value is IUserStruct) {
    //     setState(() {
    //       user = value;
    //       referralLink = "https://play.google.com/store/apps/details?id=com.solution.cryptox"
    //           "&referrer=${value.uniqueId}";
    //       referralCode = value.uniqueId ?? "";
    //     });
    //   }
    // });
    apiCalls.getIUserDetails(context);
    apiCalls.getNewReferrals(context);
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
          'Referrals',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height20Space,
            Text("Copy the below link to refer: ",style: black14SemiBoldTextStyle,
                textAlign: TextAlign.start),
            heightSpace,
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: Color(0xFF222224),
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(referralLink,
                        style: TextStyle(color: whiteColor,fontSize: 14),
                        overflow: TextOverflow.ellipsis),
                  ),
                  GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: referralLink)).then((value) {
                          showToast("Copied on clipboard.", gravity: ToastGravity.BOTTOM,
                              toast: Toast.LENGTH_LONG);
                        });
                      },
                      child: Icon(Icons.copy_all,color: primaryColor,size: 25,)
                  )
                ],
              ),
            ),
            height20Space,
            Text("Referral Id: ",style: black14SemiBoldTextStyle,
                textAlign: TextAlign.start),
            heightSpace,
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: Color(0xFF222224),
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(referralCode,
                        style: TextStyle(color: whiteColor,fontSize: 14),
                        overflow: TextOverflow.ellipsis),
                  ),
                  GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: referralCode)).then((value) {
                          showToast("Copied on clipboard.", gravity: ToastGravity.BOTTOM,
                              toast: Toast.LENGTH_LONG);
                        });
                      },
                      child: Icon(Icons.copy_all,color: primaryColor,size: 25,)
                  )
                ],
              ),
            ),
            height20Space,
            Text("Your Referrals: ",style: black14SemiBoldTextStyle,
                textAlign: TextAlign.start),
            heightSpace,
            isLoading ? SkeletonListView() : ListView.builder(
                    shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
                    itemCount: referrals.length,
                    itemBuilder: (BuildContext context, int index) {
                      IUserStruct item = referrals[index];
                      var parsedDate = DateTime.parse(item.createdAt!).add(Duration(minutes: 330));
                      return Container(
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
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text("${item.name}",style: TextStyle(color: Color(0xff959595),
                                        fontWeight: FontWeight.w600, fontSize: 13.0
                                    )),
                                  ),
                                  Expanded(
                                    child: Text(
                                        "${item.email}",
                                        style: TextStyle(color: Color(0xff959595),
                                        fontWeight: FontWeight.w600, fontSize: 13.0
                                    )),
                                  ),
                                ],
                              ),
                              height5Space,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.star, color: Color(0xff959595)),
                                  Text(
                                      'Created At: ${parsedDate.day}/${parsedDate.month}/${parsedDate.year}'
                                      ' ${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}',
                                      style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    })
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    if(referralSubscription != null) {
      referralSubscription!.cancel();
    }
    if(userSubscription != null) {
      userSubscription!.cancel();
    }
  }

}