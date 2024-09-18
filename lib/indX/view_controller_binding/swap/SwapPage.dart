
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../api/model/swap/SwappingCurrencyListData.dart';
import '../../themes/AppTextTheme.dart';
import '../../themes/ThemeColor.dart';
import '../../themes/ThemeHeightWidth.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';
import '../../widgets/CachePlaceHolderImage.dart';
import '../../widgets/DataNotFoundView.dart';
import '../../widgets/LoadingIndicator.dart';
import 'SwapController.dart';
enum SampleItem { itemOne, itemTwo, itemThree }
class SwapPage extends StatelessWidget {

  SwapController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppBarView(
        titleText: "Sell",
        bodyWidget: Obx(() => controller.swappingCurrencyList.isNotEmpty?SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
          child:  Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(15),
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text("Transfer out",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15)),
                        ),
                        InkWell(
                          onTap: () {
                            if(controller.swappingCurrencyList.length>1) {
                              showBottomSheet("Transfer out", controller.swappingCurrencyList, true);
                            }
                          },
                          child: Row(
                            children: [
                               CachePlaceHolderImage(imageUrl: controller.selectedFromCurrency.value.fromImageUrl??"",imgaeWidth: 30,imageHeight: 30, errorIconHeight: 30,errorColorBackground: Colors.transparent),
                              widthSpace_7,
                              Text(controller.selectedFromCurrency.value.symbol??"",
                                  style: poppins(color: primaryColor,fontWeight: FontWeight.w700,fontSize: 15)),
                              if(controller.swappingCurrencyList.length>1)...[
                                widthSpace_3,
                                const Icon(Icons.keyboard_arrow_down)
                              ]

                            ],
                          ),
                        )
                      ],
                    ),
                    heightSpace_10,
                    TextField(
                      onChanged: (value) {
                        if(value.trim().isNotEmpty) {
                          controller.amountError.value="";
                          double convertAmount = (double.tryParse(value.trim()) ?? 0.0) * controller.conversionRate.value;
                          controller.convertAmountController.text = Utility.INSTANCE.formatedAmountReplaceLastZero(convertAmount.toString());
                        }else{
                          controller.convertAmountController.text ="";
                        }
                      },
                      controller: controller.amountController,
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
                      style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (controller.dashboardController.currencyBalanceMap.containsKey(controller.selectedFromCurrency.value.fromCurrId??0) ) {
                                    double amt = ((double.tryParse(controller.dashboardController.currencyBalanceMap[controller.selectedFromCurrency.value.fromCurrId??0]!.balance??"0.0")??0.0) * 25) / 100;
                                    /*if ((controller.selectedFromCurrency.value.symbol??"")=="BNB") {
                                      amt = amt - 0.003;
                                    } else if ((controller.selectedFromCurrency.value.symbol??"")=="TRX") {
                                      amt = amt - 10;
                                    }*/
                                    controller.amountController.text=Utility.INSTANCE.formatedAmountNinePlace(amt);

                                      controller.amountError.value="";
                                      double convertAmount = amt * controller.conversionRate.value;
                                      controller.convertAmountController.text = Utility.INSTANCE.formatedAmountReplaceLastZero(convertAmount.toString());

                                  }
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(left:5,right: 3),
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                                    decoration:  BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: primaryShadowGrey,
                                            blurRadius: 1,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(5),
                                        color: primaryColor
                                    ),
                                    child: Text("25%",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w700),)
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (controller.dashboardController.currencyBalanceMap.containsKey(controller.selectedFromCurrency.value.fromCurrId??0) ) {
                                    double amt = ((double.tryParse(controller.dashboardController.currencyBalanceMap[controller.selectedFromCurrency.value.fromCurrId??0]!.balance??"0.0")??0.0) * 50) / 100;
                                    /*if ((controller.selectedFromCurrency.value.symbol??"")=="BNB") {
                                      amt = amt - 0.003;
                                    } else if ((controller.selectedFromCurrency.value.symbol??"")=="TRX") {
                                      amt = amt - 10;
                                    }*/
                                    controller.amountController.text=Utility.INSTANCE.formatedAmountNinePlace(amt);
                                    controller.amountError.value="";
                                    double convertAmount = amt * controller.conversionRate.value;
                                    controller.convertAmountController.text = Utility.INSTANCE.formatedAmountReplaceLastZero(convertAmount.toString());
                                  }
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(right: 3),
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                                    decoration:  BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: primaryShadowGrey,
                                            blurRadius: 1,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(5),
                                        color: primaryColor
                                    ),
                                    child: Text("50%",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w700),)
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (controller.dashboardController.currencyBalanceMap.containsKey(controller.selectedFromCurrency.value.fromCurrId??0) ) {
                                    double amt = ((double.tryParse(controller.dashboardController.currencyBalanceMap[controller.selectedFromCurrency.value.fromCurrId??0]!.balance??"0.0")??0.0) * 75) / 100;
                                    /*if ((controller.selectedFromCurrency.value.symbol??"")=="BNB") {
                                      amt = amt - 0.003;
                                    } else if ((controller.selectedFromCurrency.value.symbol??"")=="TRX") {
                                      amt = amt - 10;
                                    }*/
                                    controller.amountController.text=Utility.INSTANCE.formatedAmountNinePlace(amt);
                                    controller.amountError.value="";
                                    double convertAmount = amt * controller.conversionRate.value;
                                    controller.convertAmountController.text = Utility.INSTANCE.formatedAmountReplaceLastZero(convertAmount.toString());
                                  }
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(right: 3),
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                                    decoration:  BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: primaryShadowGrey,
                                            blurRadius: 1,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(5),
                                        color: primaryColor
                                    ),
                                    child: Text("75%",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w700),)
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (controller.dashboardController.currencyBalanceMap.containsKey(controller.selectedFromCurrency.value.fromCurrId??0) ) {
                                    double amt = double.tryParse(controller.dashboardController.currencyBalanceMap[controller.selectedFromCurrency.value.fromCurrId??0]!.balance??"0.0")??0.0;
                                    /*if ((controller.selectedFromCurrency.value.symbol??"")=="BNB") {
                                      amt = amt - 0.003;
                                    } else if ((controller.selectedFromCurrency.value.symbol??"")=="TRX") {
                                      amt = amt - 10;
                                    }*/
                                    controller.amountController.text=Utility.INSTANCE.formatedAmountNinePlace(amt);
                                    controller.amountError.value="";
                                    double convertAmount = amt * controller.conversionRate.value;
                                    controller.convertAmountController.text = Utility.INSTANCE.formatedAmountReplaceLastZero(convertAmount.toString());
                                  }
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
                                    decoration:  BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: primaryShadowGrey,
                                            blurRadius: 1,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(5),
                                        color: primaryColor
                                    ),
                                    child: Text("100%",style: poppins(color: Colors.white,fontSize: 10,fontWeight: FontWeight.w700),)
                                ),
                              )
                            ],
                          ),

                          errorText: controller.amountError.value.isNotEmpty
                              ? controller.amountError.value
                              : null,
                          //errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w500),
                          hintStyle: poppins(color: Colors.grey[500]!,fontSize: 12,fontWeight: FontWeight.w500),
                          hintText: "Minimum Flash Amount",
                          fillColor: yellow_alpha),
                    ),
                    heightSpace_10,
                    RichText(text: TextSpan(
                        text: "Balance : ",
                        style: poppins(color: primaryColor_alpha_54,fontWeight: FontWeight.w500,fontSize: 14),
                        children: [
                          TextSpan(text: "${controller.dashboardController.currencyBalanceMap.containsKey(controller.selectedFromCurrency.value.fromCurrId??0)?
                          Utility.INSTANCE.formatedAmountReplaceLastZero(controller.dashboardController.currencyBalanceMap[controller.selectedFromCurrency.value.fromCurrId??0]!.balance??"0.0"):0} ${controller.selectedFromCurrency.value.symbol??""}",
                              style: poppins(color: primaryColor_alpha_54,fontWeight: FontWeight.w700,fontSize: 14))
                        ]
                    ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text("1",style: poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
                  widthSpace_5,
                  CachePlaceHolderImage(imageUrl: controller.selectedFromCurrency.value.fromImageUrl??"",imgaeWidth: 35,imageHeight: 35, errorIconHeight: 35,errorColorBackground: Colors.transparent),
                  widthSpace_10,
                  if(controller.isLoaderShow.value==true)
                  Container(
                      padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.circular(30)),
                      height: 60,
                      width:60,
                      child: const CircularProgressIndicator())
                  else
                  SvgPicture.asset("assets/svg/swap.svg"),
                  widthSpace_10,
                  Text(Utility.INSTANCE.formatedAmountNinePlace(controller.conversionRate.value??0.0),style: poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18)),
                  widthSpace_5,
                  CachePlaceHolderImage(imageUrl: controller.selectedToCurrency.value.toImageUrl??"",imgaeWidth: 35,imageHeight: 35, errorIconHeight: 35,errorColorBackground: Colors.transparent),

                  
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(15),
                decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text("Expected to get",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15)),
                        ),
                        InkWell(
                          onTap: () {
                            if(controller.selectedFromCurrency.value.toCurrency!=null && controller.selectedFromCurrency.value.toCurrency!.length>1){
                            showBottomSheet("Expected to get",controller.selectedFromCurrency.value.toCurrency??<SwappingCurrencyListData>[],false);
                            }
                            },
                          child: Row(
                            children: [
                              CachePlaceHolderImage(imageUrl: controller.selectedToCurrency.value.toImageUrl??"",imgaeWidth: 30,imageHeight: 30, errorIconHeight: 30,errorColorBackground: Colors.transparent),
                              widthSpace_7,
                              Text(controller.selectedToCurrency.value.symbol??"",
                                  style: poppins(color: primaryColor,fontWeight: FontWeight.w700,fontSize: 15)),
                              if(controller.selectedFromCurrency.value.toCurrency!=null && controller.selectedFromCurrency.value.toCurrency!.length>1)...[
                                widthSpace_3,
                                const Icon(Icons.keyboard_arrow_down)
                              ]

                            ],
                          ),
                        )
                      ],
                    ),
                    heightSpace_10,
                    TextField(
                      controller: controller.convertAmountController,
                      readOnly: true,
                      style: poppins(color: primaryColor,fontSize: 14,fontWeight: FontWeight.w500),
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),

                          /*errorStyle: poppins(color: Colors.red,fontSize: 10,fontWeight: FontWeight.w600),*/
                          hintStyle: poppins(color: Colors.grey[500]!,fontSize: 12,fontWeight: FontWeight.w500),
                          hintText: "Expected Amount",
                          fillColor: yellow_alpha),
                    ),
                    heightSpace_10,
                    RichText(text: TextSpan(
                        text: "Balance : ",
                        style: poppins(color: primaryColor_alpha_54,fontWeight: FontWeight.w500,fontSize: 14),
                        children: [
                          TextSpan(text: "${controller.dashboardController.currencyBalanceMap.containsKey(controller.selectedToCurrency.value.toCurrId??0)?
                          Utility.INSTANCE.formatedAmountReplaceLastZero(controller.dashboardController.currencyBalanceMap[controller.selectedToCurrency.value.toCurrId??0]!.balance??"0.0"):0} ${controller.selectedToCurrency.value.symbol??""}",
                              style: poppins(color: primaryColor_alpha_54,fontWeight: FontWeight.w700,fontSize: 14))
                        ]
                    ))
                  ],
                ),
              ),
              InkWell(
                  onTap: () async {
                    controller.onSubmit();
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 40),
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
                    ),
                    child: Text("Sell",
                        style: poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18)),
                  )),
            ],
          ),
        ):
        controller.swappingCurrencyList.isEmpty && controller.isApiCalled==false?
        const Center(
          child: LoadingIndicator(
            heading: "",
            text: "Getting Currency ...",
            textColor: Colors.black,
          ),
        ):
        const DataNotFoundView(text: "Currency is not available",)));
  }


  void showBottomSheet(String title, List<SwappingCurrencyListData> list,bool isFrom) {

    Get.bottomSheet(
        isScrollControlled: true,

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Padding(
                    padding: EdgeInsets.only(top: 5,bottom: 5),
                    child: Icon(Icons.cancel,
                        color: Colors.white, size: 35))),
            Flexible(
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 15, right: 15,top: 30,bottom: 15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text("$title!",
                        style: poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20)),
                    heightSpace_15,
                    Flexible(
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            var item = list[index];
                            return GestureDetector(
                              onTap: () {
                                Get.back();
                                if(isFrom==true){
                                  if(controller.selectedFromCurrency.value.fromCurrId!=item.fromCurrId){
                                  controller.setFromData(item);
                                  }
                                }else{
                                  if (controller.selectedToCurrency.value.toCurrId != item.toCurrId) {
                                    controller.setToData(item,true);
                                  }
                                }

                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: primaryColorMoreLight,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CachePlaceHolderImage(imageUrl: isFrom==true?item.fromImageUrl??"":item.toImageUrl??"",imgaeWidth: 40,imageHeight: 40, errorIconHeight: 40,errorColorBackground: Colors.transparent),
                                    widthSpace_7,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(item.symbol??"",
                                              style: poppins(color: primaryColor,fontWeight: FontWeight.w700,fontSize: 16)),
                                          Text(item.name??"",
                                              style: poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                    widthSpace_5,
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 14,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) { return heightSpace_10; },
                          itemCount: list.length

                      ),
                    )
                  ])),
            ),

          ],
        ));
  }
}
