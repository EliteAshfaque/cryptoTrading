import 'dart:async';

import 'package:cryptox/api/request/allRequest/allRequests.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:skeletons/skeletons.dart';

class FiatDepositHistory extends StatefulWidget {

  @override
  _FiatDepositHistory createState() => _FiatDepositHistory();
}

class _FiatDepositHistory extends State<FiatDepositHistory> with SingleTickerProviderStateMixin {

  List<RequestStruct> fiatRequests = [];
  late StreamSubscription fiatRequestsSubscription;
  bool isLoading = true;
  int totalCount = 1;
  String page = "1";

  @override
  void initState() {
    super.initState();
    fiatRequestsSubscription = apiCalls.userDeposits$.listen((value) {
      if (kDebugMode){ print("GOT FIAT DEPOSIT RESP ON PAGE "+ value.toString());}
      if(value is String) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      if(value is List<RequestStruct>) {
        setState(() {
          fiatRequests = value;
          isLoading = false;
        });
      }
    });
    getFiatRequestEntries(page, LedgerStatus.ALL);
  }

  @override
  void dispose() {
    super.dispose();
    fiatRequestsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          iconTheme: IconThemeData(
            color: primaryColor, //change your color here
          ),
          // automaticallyImplyLeading: false,
          title: Text(
            'Fiat Deposit History',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
              },
              icon: Icon(
                Icons.search,
                color: primaryColor,
              ),
            ),
          ],
        ),
        bottomNavigationBar: NumberPaginator(
          numberPages: totalCount,
          onPageChange: (int index) {
            print("PAGE INDEX "+index.toString());
            index ++;
            setState(() {
              page = index.toString();
            });
            getFiatRequestEntries(page, LedgerStatus.ALL);
          },
          config: NumberPaginatorUIConfig(
            height: 40,
            buttonSelectedForegroundColor: Colors.white,
            buttonUnselectedForegroundColor: primaryColor,
            buttonSelectedBackgroundColor: primaryColor,
          ),
        ),
        body: fiatRequestHistory()
    );
  }

  Widget fiatRequestHistory() {
    return isLoading ? SkeletonListView() : ListView.builder(
        shrinkWrap: true,
        itemCount: fiatRequests.length,
        itemBuilder: (BuildContext context, int index) {
          RequestStruct item = fiatRequests[index];
          var parsedDate = DateTime.fromMicrosecondsSinceEpoch(int.parse(item.createdAt!.toString() + "000"))
              .add(Duration(minutes: 330));
          var parsedUpdatedDate = DateTime.parse(item.updatedAt!);
          if (kDebugMode) {print(parsedUpdatedDate.month);}
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 110.0,
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
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(item.uniqueId!, style: TextStyle(color: Color(0xff000000),
                                    fontWeight: FontWeight.w600)),
                                Container(
                                  margin: EdgeInsets.only(left: 8.0),
                                  child: Text('(${item.status})',style: TextStyle(
                                      color: item.status == LedgerStatus.COMPLETED.name ? Color(0xff0E8730) :
                                      item.status == LedgerStatus.FAILED.name ? Color(0xffFF1300) : Color(0xffE1A303),
                                      fontWeight: FontWeight.w600, fontSize: 12.0)),
                                )
                              ],
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text('₹'+Com().roundToDecimals(item.balance!, decimal),style: TextStyle(
                                  color: item.status == LedgerStatus.COMPLETED.name ? Color(0xff0E8730) :
                                  item.status == LedgerStatus.FAILED.name ? Color(0xffFF1300) : Color(0xffE1A303),
                                  fontWeight: FontWeight.w600, fontSize: 12.0)),
                            )
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${parsedDate.day}/${parsedDate.month}/${parsedDate.year} ${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}",style: TextStyle(color: Color(0xff959595),
                                fontWeight: FontWeight.w600, fontSize: 11.0
                            )),
                            Text("Utr: "+item.utrNo!, style: TextStyle(color: Color(0xff959595),
                                fontWeight: FontWeight.w600, fontSize: 11.0
                            ))
                          ],
                        ),
                        height5Space,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text("Remark: "+ (item.remark!.isEmpty ? "N/A" : item.remark!),
                                  style: TextStyle(color: Color(0xff959595),
                                  fontWeight: FontWeight.w600, fontSize: 11.0)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 14.0, right: 14.0),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text('Created: ${parsedDate.day}/${parsedDate.month}/${parsedDate.year}'
                          //     ' ${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}',
                          // style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0, color: Colors.white)),
                          Text('Updated At: ${parsedUpdatedDate.day}/${parsedUpdatedDate.month}/${parsedUpdatedDate.year}'
                              ' ${parsedUpdatedDate.hour}:${parsedUpdatedDate.minute}:${parsedUpdatedDate.second}',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11.0, color: Colors.white))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }

  getFiatRequestEntries(String page, LedgerStatus status) {
    Map<String, dynamic> body = {
      "page": page,
      "status": status.name
    };
    apiCalls.getUserDepositEntries(body, context).then((value) {
      setState(() {
        totalCount = (value / 10).ceil();
      });
    });
  }

}