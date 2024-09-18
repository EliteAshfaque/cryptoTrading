import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/TypeActions.dart';
import '../../api/model/AppSessionBasicRequest.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/swap/SwappingCurrencyListData.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import '../dashboard/DashboardController.dart';
import 'SwapApi.dart';

class SwapController extends GetxController {

  var amountError="".obs;

  Timer? timer;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController convertAmountController = TextEditingController();
  SwapApi api = SwapApi();
  PackageInfo packageInfo = Get.find();
  LoginResponse loginResponse =Get.find();
  var swappingCurrencyList=<SwappingCurrencyListData>[].obs;
  var selectedFromCurrency=SwappingCurrencyListData().obs;
  var selectedToCurrency=SwappingCurrencyListData().obs;
  var conversionRate=0.0.obs;
  var isApiCalled=false.obs;
  DashboardController dashboardController =Get.find();
  var isLoaderShow=false.obs;
  bool isScreenOpen=true;


  @override
  void onInit() async {

    await getSwappingCurrencyList();
    super.onInit();
  }

  Future<void> getSwappingCurrencyList() async {

    await api.getSwappingCurrencyList(AppSessionBasicRequest(appSession: BasicRequest(loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID,isSeller: true)), (action, response) async {
      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        swappingCurrencyList.value =response;
        setFromData(swappingCurrencyList[0]);
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  setFromData(SwappingCurrencyListData item) async {
    selectedFromCurrency.value=item;
    isLoaderShow.value=true;
    conversionRate.value=0.0;
    await dashboardController.getCryptoBalanceApi(item.fromCurrId??0,false, false);
    if(item.toCurrency!=null && item.toCurrency!.isNotEmpty) {
      setToData(item.toCurrency![0],false);

    }
  }

  setToData(SwappingCurrencyListData item,bool isFromClick) async {
    selectedToCurrency.value = item;
    if(isFromClick==true){
      isLoaderShow.value=true;
      conversionRate.value=0.0;
    }
   /* conversionRate.value=item.rate??0.0;*/
    if(amountController.text.trim().isNotEmpty) {
      double convertAmount = (double.tryParse(amountController.text.trim()) ?? 0.0) * conversionRate.value;
      convertAmountController.text = Utility.INSTANCE.formatedAmountReplaceLastZero(convertAmount.toString());
    }
    await dashboardController.getCryptoBalanceApi(item.toCurrId??0,false, false);
    await getSwappingCurrencyConversion(selectedFromCurrency.value.fromCurrId??0,item.toCurrId??0);
  }

  Future<void> getSwappingCurrencyConversion(int fromCurrId,int toCurrId) async {

    await api.getSwappingCurrencyConversion(AppSessionBasicRequest(request: jsonDecode('{"FromCurrId":$fromCurrId,"ToCurrId":$toCurrId}'),appSession: BasicRequest(loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID,isSeller: true)), (action, response) async {
      isLoaderShow.value=false;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        conversionRate.value=response.rate??0.0;
        if(amountController.text.trim().isNotEmpty) {
          double convertAmount = (double.tryParse(amountController.text.trim()) ?? 0.0) * conversionRate.value;
          convertAmountController.text = Utility.INSTANCE.formatedAmountReplaceLastZero(convertAmount.toString());
        }
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

      if(timer!=null){
        timer!.cancel();
      }
      if(isScreenOpen==true){
      timer = Timer(const Duration(seconds: 10), () async {
        await getSwappingCurrencyConversion(selectedFromCurrency.value.fromCurrId??0,selectedToCurrency.value.toCurrId??0);
        },
      );
      }
    });
  }




  onSubmit(){
    double inputAmount = double.tryParse(amountController.text.trim())??0.0;

    if (amountController.text.trim().isEmpty) {
    amountError.value="Please enter amount";
    return;
    } else if (inputAmount > 0 && dashboardController.currencyBalanceMap.containsKey(selectedFromCurrency.value.fromCurrId??0) &&
        (double.tryParse(dashboardController.currencyBalanceMap[selectedFromCurrency.value.fromCurrId??0]!.balance??"0.0")??0.0) < inputAmount) {
      amountError.value="You have insufficient balance";
    return;

    } /*else if ((selectedFromCurrency.value.fromTechnologyId??0) == 1 && (selectedFromCurrency.value.symbol??"")=="BNB" &&
    (inputAmount + 0.003) > ((SwappingNetworkingActivity) getActivity()).balanceBNB) {
    amountError.value="you have insufficient balance, you need 0.003 BNB as a gas Fee";
    return;
    } else if ((selectedFromCurrency.value.fromTechnologyId??0) == 1 && (selectedFromCurrency.value.symbol??"")!="BNB" &&
    ((SwappingNetworkingActivity) getActivity()).balanceBNB < 0.003) {
    amountError.value="you have insufficient BNB balance, you need 0.003 BNB as a gas Fee";

    return;
    } else if ((selectedFromCurrency.value.fromTechnologyId??0) == 2 && (selectedFromCurrency.value.symbol??"")=="TRX" &&
    (inputAmount + 10) > ((SwappingNetworkingActivity) getActivity()).balanceTRX) {
    amountError.value="you have insufficient balance, you need 10 TRX as a gas Fee";

    return;
    } else if ((selectedFromCurrency.value.fromTechnologyId??0) == 2 && (selectedFromCurrency.value.symbol??"")!="TRX" &&
    ((SwappingNetworkingActivity) getActivity()).balanceTRX < 10) {
    amountError.value="you have insufficient TRX balance, you need 10 TRX as a gas Fee";

    return;
    }*/

    submitBuySell();
  }

  Future<void> submitBuySell() async {

    DialogBuilder.INSTANCE.showLoadingIndicator("", "Processing...",isCancelabel: false);
    await api.submitBuySell(AppSessionBasicRequest(request: jsonDecode('{"isSeller":true,"TransAmount":${amountController.text.trim()},"FromCurrId":${selectedFromCurrency.value.fromCurrId??0},"ToCurrId":${selectedToCurrency.value.toCurrId??0}}'),
        appSession: BasicRequest(loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
        APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID,isSeller: true)), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      isLoaderShow.value=false;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        Utility.INSTANCE.dialogIconOneButton("check", "", response.msg??"Success", "Cancel");
        amountController.text = "";
        convertAmountController.text = "";
        await dashboardController.getCryptoBalanceApi(selectedFromCurrency.value.fromCurrId??0,false, false);
        await dashboardController.getCryptoBalanceApi(selectedToCurrency.value.toCurrId??0,false, false);
        /*await dashboardController.currencyList(false, null);
        await dashboardController.balance(true);
        dashboardController.isBalCryptoApi=true;*/

      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

      if(timer!=null){
        timer!.cancel();
      }
      if(isScreenOpen==true){
        timer = Timer(const Duration(seconds: 10), () async {
          await getSwappingCurrencyConversion(selectedFromCurrency.value.fromCurrId??0,selectedToCurrency.value.toCurrId??0);
        },
        );
      }
    });
  }


  @override
  void onClose() {
    if(timer!=null){
      timer!.cancel();
    }
    isScreenOpen=false;
    super.onClose();
  }

  @override
  void dispose() {
    amountController.dispose();
    convertAmountController.dispose();
    if(timer!=null){
      timer!.cancel();
    }
    isScreenOpen=false;
    super.dispose();
  }


}
