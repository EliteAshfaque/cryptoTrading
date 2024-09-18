import 'dart:async';

import 'package:cryptox/api/request/allRequest/allRequests.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/widget/CustomText.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:skeletons/skeletons.dart';

import '../../../indX/utils/Utility.dart';

class CashDepositHistory extends StatefulWidget {
  @override
  _CashDepositHistory createState() => _CashDepositHistory();
}

class _CashDepositHistory extends State<CashDepositHistory>
    with SingleTickerProviderStateMixin {
  List<RequestStruct> fiatRequests = [];
  late StreamSubscription fiatRequestsSubscription;
  bool isLoading = true;
  int totalCount = 1;
  String page = "1";
  List<String> selectActionType = ["Select one", "Delete"];
  String selectTypesVal = "Select one";

  @override
  void initState() {
    super.initState();
    fiatRequestsSubscription = apiCalls.userDeposits$.listen((value) {
      if (kDebugMode) {
        print("GOT FIAT DEPOSIT RESP ON PAGE " + value.toString());
      }
      if (value is String) {
        setState(() {
          isLoading = false;
        });
        return;
      }
      if (value is List<RequestStruct>) {
        setState(() {
          fiatRequests = value;

          isLoading = false;
        });
      }
    });
    getCdmRequestEntries(page, LedgerStatus.ALL);
  }

  @override
  void dispose() {
    super.dispose();
    fiatRequestsSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          iconTheme: IconThemeData(
            color: primaryColor, //change your color here
          ),
          // automaticallyImplyLeading: false,
          title: Text(
            'Cash Deposit History',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
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
            print("PAGE INDEX " + index.toString());
            index++;
            setState(() {
              page = index.toString();
            });
            getCdmRequestEntries(page, LedgerStatus.ALL);
          },
          config: NumberPaginatorUIConfig(
            height: 40,
            buttonSelectedForegroundColor: Colors.white,
            buttonUnselectedForegroundColor: primaryColor,
            buttonSelectedBackgroundColor: primaryColor,
          ),
        ),
        body: cdmRequestHistory());
  }

  Widget cdmRequestHistory() {
    return isLoading
        ? SkeletonListView()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: fiatRequests.length,
            itemBuilder: (BuildContext context, int index) {
              RequestStruct item = fiatRequests[index];
              var parsedDate = DateTime.fromMicrosecondsSinceEpoch(
                      int.parse(item.createdAt!.toString() + "000"))
                  .add(Duration(minutes: 330));
              var parsedUpdatedDate = DateTime.parse(item.updatedAt!);
              print("The updated data is =====>>>> ${parsedUpdatedDate}");
              String formattedDate =
                  DateFormat('dd/MM/yyyy hh:mm:ss a').format(parsedUpdatedDate);
              String formattedCreated =
                  DateFormat('dd/MM/yyyy hh:mm:ss a').format(parsedDate);

              if (kDebugMode) {
                print(parsedUpdatedDate.month);
              }
              return Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 35,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        decoration: BoxDecoration(
                          color: goldenYellow,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        child: Row(
                          children: [
                            CustomText(
                              text: "${item.utrNo}",
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              fontColor: Colors.white,
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                alignment: Alignment.center,
                                height: 55,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: CustomText(
                                    text: '${item.status}',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontColor: item.status ==
                                            LedgerStatus.COMPLETED.name
                                        ? Color(0xff0E8730)
                                        : item.status ==
                                                LedgerStatus.FAILED.name
                                            ? Color(0xffFF1300)
                                            : Color(0xffE1A303),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 250.0, // Adjust the overall height to fit content
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(0.0),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            spreadRadius: 1.0,
                            color: Colors.black.withOpacity(0.05),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        text: 'ID :',
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff000000)),
                                    CustomText(
                                        text: '${item.uniqueId}',
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff000000)),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        text: 'Amount:',
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff000000)),
                                    CustomText(
                                        text: 'Rs. ${item.balance}',
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff000000)),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        text: 'Created Date:',
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff000000)),
                                    CustomText(
                                        text: '${formattedCreated}',
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff000000)),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: 'Updated Date:',
                                      fontWeight: FontWeight.w500,
                                    ),
                                    CustomText(
                                      text: '${formattedDate}',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        text: 'Txn Id:',
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff000000)),
                                    CustomText(
                                        text: '${item.txnNo ?? 'N/A'}',
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff000000)),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        text: 'ATM NO:',
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff000000)),
                                    CustomText(
                                        text: '${item.atmNo ?? 'N/A'}',
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff000000)),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                        text: 'Failed Reason:',
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff000000)),
                                    CustomText(
                                        text: '${item.failedReason ?? 'N/A'}',
                                        fontWeight: FontWeight.w500,
                                        fontColor: Color(0xff000000)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(
                                            text: 'Image:',
                                            fontWeight: FontWeight.w500,
                                            fontColor: Color(0xff000000)),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              Utility.INSTANCE.urlLaunch(
                                                  item.imagePath ?? '');
                                            },
                                            child: Icon(
                                              Icons.visibility_outlined,
                                              color: primaryColor,
                                            ))
                                      ],
                                    ),
                                    item.status == 'PENDING'
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              elevation: 1,
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 32,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: CustomText(
                                                  text: "Delete",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  fontColor: brickRed,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
  }

  getCdmRequestEntries(String page, LedgerStatus status) {
    Map<String, dynamic> body = {"page": page, "status": status.name};
    apiCalls.getUserDepositEntries(body, context).then((value) {
      setState(() {
        totalCount = (value / 10).ceil();
      });
    });
  }
}
