import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/model/transfer/BankAccountsData.dart';
import '../../routes/AppRoutes.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import '../../widgets/DataNotFoundView.dart';
import '../../widgets/ShimmerLoaderView.dart';
import 'BankAccountsController.dart';

class BankAccountsPage extends StatelessWidget {
  BankAccountsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AppBarView(
        titleText: "Bank Transfer",
        bodyWidget: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Obx(() => Column(children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.only(
                      bottom: 10, left: 10, right: 10, top: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: primaryColor, width: 1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      Text("Balance",
                          style: poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                      heightSpace_5,
                      Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: List.generate(
                            controller.dashboardController.balanceResponse.value
                                .balanceData!.length, (index) {
                          var item = controller.dashboardController
                              .balanceResponse.value.balanceData![index];

                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: grayishBlue_alpha_55,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            width: controller.dashboardController.balanceResponse.value.balanceData!.length % 2 == 0
                                ? (size.width - 57) / 2
                                : index == (controller.dashboardController.balanceResponse.value.balanceData!.length - 1)
                                    ? (size.width - 52)
                                    : (size.width - 57) / 2,
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: item.walletType ?? "",
                                    style: poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                    children: [
                                      TextSpan(
                                          text:
                                              "\n${Utility.INSTANCE.getCurrencySymbol(item.walletCurrencySymbol ?? "\$")} ${item.balance ?? ""}",
                                          style: poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: primaryColor))
                                    ])),
                          );
                        }),
                      ),
                      heightSpace_5,
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () => Get.toNamed(AppRoutes.addUpdateBank)!.then((value) {
                                  if(value==123){
                                    controller.getBankAccounts();
                                  }
                                }),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                child: Text("Add Bank",
                                    style: poppins(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600))),
                          ),
                          widthSpace_15,
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () => Get.toNamed(AppRoutes.sendMoneyBankReport),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                                child: Text("Transaction History",
                                    style: poppins(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
            Text("Bank Accounts",
                    textAlign: TextAlign.center,
                    style: poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black)),
            heightSpace_10,

            if(controller.baneList.isNotEmpty && controller.isApiCalled.value == true)...[
              TextFormField(
                  controller: controller.searchController,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      controller.searchBeneList.value = controller.baneList
                          .where((element) => ((element.accountHolder ?? "")
                          .toLowerCase()
                          .contains(value.toLowerCase()) ||
                          (element.bankName ?? "")
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          (element.mobileNo ?? "")
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          (element.accountNumber ?? "")
                              .toLowerCase()
                              .contains(value.toLowerCase()) ||
                          (element.ifsc ?? "")
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                          .toList();
                    } else {
                      controller.searchBeneList.value = controller.baneList;
                    }
                  },
                  style: poppins(
                      color: primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 13, right: 13),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey[500],
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        controller.searchController.text = "";
                        controller.searchBeneList.value = controller.baneList;
                      },
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    hintText: "Search",
                    hintStyle: poppins(
                        color: Colors.grey[500]!,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )),
              heightSpace_10,
              if(controller.searchBeneList.isNotEmpty)...[
                for(var item in controller.searchBeneList)...{
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        heightSpace_10,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Account Holder : ",
                                  style: poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11)),
                              Flexible(
                                child: Text(item.accountHolder??"",
                                    textAlign: TextAlign.right,
                                    style: poppins(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right:10, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Bank Name : ",
                                  style: poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11)),
                              Flexible(
                                child: Text(item.bankName??"",
                                    textAlign: TextAlign.right,
                                    style: poppins(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right:10, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Account Number : ",
                                  style: poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11)),
                              Flexible(
                                child: Text(item.accountNumber??"",
                                    textAlign: TextAlign.right,
                                    style: poppins(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right:10, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("IFSC Code : ",
                                  style: poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11)),
                              Flexible(
                                child: Text(item.ifsc??"",
                                    textAlign: TextAlign.right,
                                    style: poppins(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11)),
                              )
                            ],
                          ),
                        ),
                        /*  heightSpace_10,
                      SvgPicture.asset("assets/svg/line.svg"),*/
                        /* heightSpace_10,
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widthSpace_10,
                            Expanded(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: item.approvalText??"",
                                      style: poppins(
                                          color: gray_6,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                            text: "\nApproval Status",
                                            style: poppins(
                                                color: gray_4,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500))
                                      ])),
                            ),
                            Expanded(child: item.approvalStatus==2?
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: item.isDefault==true?green_3:red_2),
                                  borderRadius: const BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  Switch(value: item.isDefault??false, onChanged: (value) => null,
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      inactiveThumbColor: red_2,
                                      inactiveTrackColor: Colors.red[200],
                                      activeColor: green_3),
                                  Text("Default",style: poppins(
                                      color: item.isDefault==true?green_3:red_2,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500))
                                ],
                              ),
                            ):
                            SvgPicture.asset("assets/svg/line.svg",
                                fit: BoxFit.cover)),
                            Expanded(
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      text: item.verificationText??"",
                                      style: poppins(
                                          color: gray_6,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                      children: [
                                        TextSpan(
                                            text: "\nVerification Status",
                                            style: poppins(
                                                color: gray_4,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500))
                                      ])),
                            ),
                            widthSpace_10,
                          ]),*/
                        heightSpace_10,
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Get.toNamed(AppRoutes.sendMoneyBank,arguments: [item,controller.balanceData.id??0]),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: const BoxDecoration(
                                      color: green_1,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20))),
                                  child: Text("Send",
                                      style: poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                            /* if(controller.isSattlmentAccountVerify.value==true && (item.verificationStatus == 1 || item.verificationStatus == 0))...[
                            widthSpace_2,
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                color: orange_1,
                                child: Text(item.verificationStatus == 1?"Update UTR":"Verify",
                                    style: poppins(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                            widthSpace_2
                          ]else...[
                            widthSpace_2,
                          ],*/
                            widthSpace_2,
                            Expanded(
                              child: GestureDetector(
                                onTap: () => showDeleteConfirmDialog(item),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  decoration: const BoxDecoration(
                                      color: red_2,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20))),
                                  child: Text("Delete",
                                      style: poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                }
              ]else...[
                Padding(
                  padding: EdgeInsets.only(top: (size.height/2)-340),
                  child: const DataNotFoundView(
                      text: "Accounts is not available\n\nClick on Add Bank button to add new bank account"),
                )
              ]

              ]
            else if(controller.baneList.isEmpty && controller.isApiCalled.value == false)...[
              ShimmerLoaderView(
                        widget: Column(
                          children: List.generate(6, (index) => Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 150,
                            decoration: const BoxDecoration(
                                color: primaryColorLight,
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                          )),
                        ))
            ]else...[
              Padding(
                padding: EdgeInsets.only(top: (size.height/2)-300),
                child: const DataNotFoundView(
                    text: "Accounts is not available\n\nClick on Add Bank button to add new bank account"),
                    )
                  ]
              ])),
        ));
  }

  void showDeleteConfirmDialog(BankAccountsData bankData){


    if(Get.isDialogOpen==false) {
      Get.bottomSheet(
          isScrollControlled: true,
          isDismissible: false,
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(onTap:() {
                  Get.back();

                },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 5,bottom: 5),
                    child: Icon(Icons.cancel,color: Colors.white,size: 35),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        color: Colors.white),
                    child:  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Confirmation!",
                            style: poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 25)),
                        heightSpace_20,

                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: "Bank : ",
                                style: poppins(
                                    color: gray_5,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                                children: [
                                  TextSpan(
                                      text: bankData.bankName??"",
                                      style: poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)
                                  ),
                                  TextSpan(
                                      text: "\nAc Holder : ",
                                      style: poppins(
                                          color: gray_5,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11)
                                  ),
                                  TextSpan(
                                      text: bankData.accountHolder??"",
                                      style: poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)
                                  ),
                                  TextSpan(
                                      text: "\nAc No : ",
                                      style: poppins(
                                          color: gray_5,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11)
                                  ),
                                  TextSpan(
                                      text: bankData.accountNumber ?? "",
                                      style: poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)
                                  ),
                                  TextSpan(
                                      text: "\nIFSC Code : ",
                                      style: poppins(
                                          color: gray_5,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11)
                                  ),
                                  TextSpan(
                                      text: bankData.ifsc ?? "",
                                      style: poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)
                                  )

                                ]
                            )),


                        heightSpace_20,



                        InkWell(
                          onTap: () async {
                            Get.back();
                            controller.deleteBankAccount(bankData.id??0,bankData);

                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(

                              width: double.infinity,
                              height: 48,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: primaryShadowGrey,
                                      blurRadius: 2,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  gradient: LinearGradient(
                                      colors: [primaryColorLight,primaryColor],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)
                              ),child: Text("Delete",
                                style: poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18)),
                            ),
                          ),
                        ),

                      ],
                    )),

              ],
            ),
          ));
    }
  }
}
