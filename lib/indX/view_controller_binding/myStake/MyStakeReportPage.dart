

import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import '../../widgets/DataNotFoundView.dart';
import '../../widgets/ShimmerLoaderView.dart';
import 'MyStakeReportController.dart';

class MyStakeReportPage extends StatelessWidget {
  MyStakeReportController controller = Get.find();
  var screenWidth;
  @override
  Widget build(BuildContext context) {
     screenWidth=MediaQuery.of(context).size.width;
    return AppBarView(
        titleText: "My Stake",
        bodyWidget: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Obx(() => Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color(0xff01a2af),
                            Color(0xff033ca4)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mint",
                            style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Text(Utility.INSTANCE.formatedAmountNinePlace(controller.withdrawlabelMint.value),
                              style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: primaryColorLight,
                        borderRadius: BorderRadius.vertical(bottom:  Radius.circular(20))
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: () => _showBottomSheet(),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                minimumSize: const Size(130,30),
                                backgroundColor: lightPurple,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)))),
                            child:  Row(
                              children: [
                                SvgPicture.asset("assets/svg/withdrawal_wallet.svg",height: 18,width: 18),
                                widthSpace_3,
                                Text("Withdrawal Wallet",
                                  style: poppins(fontSize: 10,fontWeight: FontWeight.w600,color: primaryColor),),
                              ],
                            )),
                        ElevatedButton(onPressed: () => Utility.INSTANCE.dialogIconTwoButtonWithCallback("error_exclamation","Withdrawal",
                            "Are you sure, want to withdrawal ${Utility.INSTANCE.formatedAmountNinePlace(controller.withdrawlabelMint.value)} mint","Withdrawal","Cancel",(value){
                              if(value==1){

                                controller.withdrawalMint(2, 0, controller.withdrawlabelMint.value.toString(),(response){
                                  Utility.INSTANCE.showResponseDetailDialog("Withdrawal Details",response);
                                });
                              }
                            }),
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                minimumSize: const Size(130,30),
                                backgroundColor: lightPurple,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)))),
                            child:  Row(
                              children: [
                                SvgPicture.asset("assets/svg/withdrawal_crypto.svg",height: 18,width: 18),
                                widthSpace_3,
                                Text("Withdrawal Crypto",
                                  style: poppins(fontSize: 10,fontWeight: FontWeight.w600,color: primaryColor),),
                              ],
                            ))
                      ],),
                  ),
                  heightSpace_10,
                  if(controller.isApiCalled.value==true && controller.list.isNotEmpty)...[
                    for(var item in controller.list)
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.only(bottom: 5),
                        decoration: const BoxDecoration(
                            color: primaryColorLight,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              decoration: const BoxDecoration(
                                  color: grayishBlue_alpha_22,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(item.planName ?? "",
                                        style: poppins(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration:  const BoxDecoration(
                                          color: orange_2,
                                          borderRadius: BorderRadius.all(Radius.circular(8))),
                                      child: Text("Amount : ${Utility.INSTANCE.formatedAmountWithOutRupees(item.amount??0)}",
                                          style: poppins(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600)))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Purchase Date : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                  Flexible(child: Text(item.purchaseDate??"",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                                ],
                              ),
                            ),
                            const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Withdrawal Date : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                  Flexible(child: Text(item.withdrawalDate??"",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                                ],
                              ),
                            ),
                            if((item.lastwithdrwalDate??"").isNotEmpty)...[
                              const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Last Withdrawal Date : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                    Flexible(child: Text(item.lastwithdrwalDate??"",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                                  ],
                                ),
                              ),
                            ]




                          ],
                        ),
                      )

                  ]else if(controller.isApiCalled.value==false && controller.list.isEmpty)...[
                    ShimmerLoaderView(
                        widget: Column(
                          children: List.generate(8, (index) => Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 100,
                            decoration: const BoxDecoration(
                                color: primaryColorLight,
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                          )),
                        ))
                  ]else...[
                    const DataNotFoundView(text: "Staking Details is not available")
                  ],
                  heightSpace_10,
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xff01a2af),
                              Color(0xff033ca4)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Old Mint",
                            style: poppins(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 18)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                          decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Text(Utility.INSTANCE.formatedAmountNinePlace(controller.withdrawlabelOldMint.value),
                              style: poppins(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 15)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: primaryColorLight,
                        borderRadius: BorderRadius.vertical(bottom:  Radius.circular(20))
                    ),
                    child: ElevatedButton(onPressed: () => Utility.INSTANCE.dialogIconTwoButtonWithCallback("error_exclaimation","Withdrawal",
                        "Are you sure, want to withdrawal ${Utility.INSTANCE.formatedAmountNinePlace(controller.withdrawlabelOldMint.value)} mint","Withdrawal","Cancel",(value){
                          if(value==1){
                            controller.withdrawalOldMint(controller.withdrawlabelOldMint.value.toString(),(response){
                              Utility.INSTANCE.showResponseDetailDialog("Withdrawal Details",response);
                            });

                          }
                        }),
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            minimumSize: const Size(130,30),
                            backgroundColor: lightPurple,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)))),
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset("assets/svg/withdrawal_crypto.svg",height: 18,width: 18),
                            widthSpace_3,
                            Text("Withdrawal",
                              style: poppins(fontSize: 10,fontWeight: FontWeight.w600,color: primaryColor),),
                          ],
                        )),
                  ),
                  heightSpace_10,
                  if(controller.isOldApiCalled.value==true && controller.listOld.isNotEmpty)...[
                    for(var item in controller.listOld)
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.only(bottom: 5),
                        decoration: const BoxDecoration(
                            color: primaryColorLight,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                              decoration: const BoxDecoration(
                                  color: grayishBlue_alpha_22,
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(item.planName ?? "",
                                        style: poppins(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.only(left: 5),
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration:  const BoxDecoration(
                                          color: orange_2,
                                          borderRadius: BorderRadius.all(Radius.circular(8))),
                                      child: Text("Amount : ${Utility.INSTANCE.formatedAmountWithOutRupees(item.amount??0)}",
                                          style: poppins(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600)))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Purchase Date : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                  Flexible(child: Text(item.purchaseDate??"",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                                ],
                              ),
                            ),
                            const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Withdrawal Date : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                  Flexible(child: Text(item.withdrawalDate??"",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                                ],
                              ),
                            ),
                            if((item.lastwithdrwalDate??"").isNotEmpty)...[
                              const Divider(color: primaryColor,height: 0,endIndent: 10,indent: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Last Withdrawal Date : ",style: poppins(color: lightPurple,fontWeight: FontWeight.w600,fontSize: 11)),
                                    Flexible(child: Text(item.lastwithdrwalDate??"",style: poppins(color: gray_1,fontWeight: FontWeight.w500,fontSize: 11)))
                                  ],
                                ),
                              ),
                            ]




                          ],
                        ),
                      )
                  ]else if(controller.isOldApiCalled.value==true && controller.listOld.isEmpty)...[
                    const DataNotFoundView(text: "Old Staking Details is not available")
                  ]
                ],
              )),
        ));
  }

  void _showBottomSheet() {

    var selectedWallet= controller.listWallet[0].obs;
    controller.amountController.text="";
    controller.amountError.value="";
    Get.bottomSheet(
        isScrollControlled: true,
        Column(
         mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child:  Container(
                  color: Colors.transparent,
                    padding: const EdgeInsets.only(top: 5,bottom: 5),
                    child: const Icon(Icons.cancel,
                        color: Colors.white, size: 35))),
            Flexible(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 10, right: 10,top: 30,bottom: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text("Withdrawal Wallet!",
                        style: poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20)),
                    heightSpace_15,
                    Flexible(
                      child: SingleChildScrollView(
                        child: Obx(() => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(controller.listWallet.length, (index) {
                                var item =controller.listWallet[index];
                                return GestureDetector(
                                  onTap: () => selectedWallet.value=item,
                                  child: Container(
                                    width: (screenWidth-50)/2,
                                    height: 90,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: selectedWallet.value==item?primaryColor:gray_4,
                                        border: Border.all(color: selectedWallet.value==item?orange_1:gray_4,strokeAlign: BorderSide.strokeAlignOutside,width: 1),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 33,
                                            height: 33,
                                            padding: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                                color: grayishBlue,
                                                borderRadius: BorderRadius.all(Radius.circular(22))
                                            ),
                                            child: SvgPicture.asset("assets/svg/note.svg")),
                                        Expanded(
                                          child: RichText(
                                            textAlign: TextAlign.right,
                                            maxLines: 2,
                                            text: TextSpan(
                                              text: "${item.walletType??""}\n",
                                              style: poppins(color: Colors.black,fontSize: 10,fontWeight: FontWeight.w600),
                                              children: [
                                                TextSpan(
                                                  text: "${Utility.INSTANCE.getCurrencySymbol(item.walletCurrencySymbol??"\$") } ${Utility.INSTANCE.formatedAmountWithOutRupees(item.balance??0.0)}",
                                                  style: poppins(color: Colors.white,fontSize: 11,fontWeight: FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } ),
                            ),
                            heightSpace_20,
                            TextField(
                              controller: controller.amountController,
                              style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                              cursorColor: primaryColor,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                TextInputFormatter.withFunction((oldValue, newValue) {
                                  final text = newValue.text;
                                  return text.isEmpty
                                      ? newValue
                                      : double.tryParse(text) == null
                                      ? oldValue
                                      : newValue;
                                }),
                              ],
                              decoration: InputDecoration(
                                  border: DecoratedInputBorder(
                                      shadow: const [
                                        BoxShadow(
                                            color: primaryShadowGrey,
                                            blurRadius: 2,
                                            spreadRadius: 1.0
                                        )
                                      ],
                                      child:OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(30.0),
                                  )),
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                  errorText: controller.amountError.value.isNotEmpty?controller.amountError.value:null,
                                  errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),
                                  hintStyle: poppins(color: Colors.grey[500]!,fontSize: 14,fontWeight: FontWeight.w500),
                                  hintText: "Enter Amount",
                                  fillColor: Colors.white),
                            ),
                            heightSpace_20,
                            InkWell(
                              onTap: () async {
                                controller.amountError.value="";
                                if(controller.amountController.text.isEmpty){
                                  controller.amountError.value="Enter amount";
                                  return;
                                }
                                Get.back();
                                controller.withdrawalMint(1,selectedWallet.value.id??0,controller.amountController.text.trim(),(response){
                                  Utility.INSTANCE.showResponseDetailDialog("Withdrawal Details",response);
                                });

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
                                  ),child: Text("Apply",
                                    style: poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18)),
                                ),
                              ),
                            )
                          ],
                        )),
                      ),
                    )
                  ])),
            ),
            
          ],
        ));
  }



}
