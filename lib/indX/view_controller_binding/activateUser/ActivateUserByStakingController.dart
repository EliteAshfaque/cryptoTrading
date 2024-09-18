import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/TypeActions.dart';
import '../../api/model/AppSessionBasicRequest.dart';
import '../../api/model/BasicRequest.dart';
import '../../api/model/activateUser/ActivateUserRequest.dart';
import '../../api/model/activateUser/PackageList.dart';
import '../../api/model/activateUser/TopupDataByUserId.dart';
import '../../api/model/activateUser/TopupDataByUserIdResponse.dart';
import '../../api/model/activateUser/WalletTypeList.dart';
import '../../api/model/currencyList/LiveRateData.dart';
import '../../api/model/currencyList/LiveRateResponse.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import '../dashboard/DashboardController.dart';
import 'ActivateUserApi.dart';

class ActivateUserByStakingController extends GetxController {
  var userIdError="".obs;
  var typeError="".obs;
  var packageError="".obs;
  var walletError="".obs;
  var amountError="".obs;
  var convertAmountError="".obs;

  var leg ="L".obs;
  var inputReferrralId ="";
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController packageController = TextEditingController();
  final TextEditingController walletController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController convertAmountController = TextEditingController();
  ActivateUserApi api = ActivateUserApi();
  PackageInfo packageInfo = Get.find();

  var topupDataByUserIdResponse = TopupDataByUserIdResponse().obs;
  LoginResponse loginResponse =Get.find();

  DashboardController dashboardController =Get.find();

  var typeList = <TopupDataByUserId>[].obs;
  var packageList = <PackageList>[].obs;
  var walletList = <WalletTypeList>[].obs;
  var selectedType= TopupDataByUserId().obs ;
  var selectedPackage= PackageList().obs ;
  var selectedWallet= WalletTypeList().obs ;
  var currencyList = <LiveRateData>[].obs;
  var selectedCurrency =LiveRateData().obs;
  var liveRateResponse =LiveRateResponse().obs;
  var convertedAmount=0.0.obs;
  var inputAmount=0.0.obs;
  var isAmountFocused=false.obs;
  var isConvertAmountFocused=false.obs;

  Map<int, List<LiveRateData>> buisnessCurrencyMap = HashMap();


  @override
  void onInit() async {
    if(dashboardController.userTopupType.value==1){
      userIdController.text="${loginResponse.data!.prefix??''}${loginResponse.data!.userID??0}";
      await getUserData(userIdController.text.trim(),false);
    }
    super.onInit();
  }

  Future<void> getUserData( String userId,bool isFromClick) async {
    if(isFromClick){
      DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Details ...', isCancelabel: false);
    }else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Details ...', isCancelabel: false);
      });
    }

    await api.getDetails(AppSessionBasicRequest(
        request: jsonDecode('{"strUserID":"$userId","stakeType":0,"BussinessEventID":1}'),
        appSession: BasicRequest(loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
            APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        topupDataByUserIdResponse.value =response;

        if(response.data!=null && response.data!.isNotEmpty) {
          typeList.value=response.data!;
          setTypeData( typeList[0],false);
        }
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  void setTypeData(TopupDataByUserId item, bool isFromClick){
    selectedType.value=item;
    typeController.text=item.name??"";

    if(item.packageList!=null && item.packageList!.isNotEmpty) {
      packageList.value = item.packageList ?? <PackageList>[];
      setPackage(packageList[0]);
    }
    if(item.walletTypeList!=null && item.walletTypeList!.isNotEmpty) {
      walletList.value = item.walletTypeList ?? <WalletTypeList>[];
      setWallet(walletList[0]);
    }

    if(buisnessCurrencyMap.isNotEmpty && buisnessCurrencyMap.containsKey(item.oid??0)){
      currencyList.value = buisnessCurrencyMap[item.oid??0]??<LiveRateData>[];
      setBusinessCurrency(currencyList[0]);
    }else{
      getBusinessCurrencyInUse(item.oid??0,isFromClick);
    }

  }

  void setPackage(PackageList item){
    selectedPackage.value = item;
    packageController.text = item.packageName ?? "";
    if (item.isRangePackageCost==false) {
      convertedAmount.value = (item.packageCost??0) / (liveRateResponse.value.liveRate??0);
      if (convertedAmount.value.isNaN || convertedAmount.value.isInfinite) {
        convertAmountController.text="";
      } else {
        convertAmountController.text=Utility.INSTANCE.formatedAmountNinePlace(convertedAmount.value);
      }
    }
  }

  void setWallet(WalletTypeList item){
    selectedWallet.value = item;
    walletController.text = item.name ?? "";
  }

  Future<void> getBusinessCurrencyInUse( int oId,bool isFromClick) async {
    if(isFromClick){
      DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Currency ...', isCancelabel: false);
    }

    await api.getBusinessCurrencyInUse(AppSessionBasicRequest(
        request: oId,
        appSession: BasicRequest(loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
            APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        buisnessCurrencyMap[oId]=response;
        currencyList.value = response;
        setBusinessCurrency(response[0]);

      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  void setBusinessCurrency(LiveRateData item){
    liveRateResponse.value=LiveRateResponse();
    selectedCurrency.value=item;

    if(item.displayConversionCurrId!=selectedPackage.value.defaultCurrencyId) {
      if (dashboardController.currencyLiveRateMap.isNotEmpty && dashboardController.currencyLiveRateMap.containsKey("${item.displayConversionCurrId ?? 0}-${selectedPackage.value.defaultCurrencyId ?? 0}")) {
        liveRateResponse.value = dashboardController.currencyLiveRateMap["${item.displayConversionCurrId ?? 0}-${selectedPackage.value.defaultCurrencyId ?? 0}"] ?? LiveRateResponse();
        setLiveRateData();
      }
      getLiveRate(item.displayConversionCurrId ?? 0, selectedPackage.value.defaultCurrencyId ?? 0);
    }
  }

Future<void> getLiveRate( int fromCurrId,int toCurrId) async {


    await dashboardController.api.getLiveRate(fromCurrId, toCurrId,loginResponse.data!, (action, response) async {
      if (action == TypeActions.INSTANCE.SUCCESS) {
        liveRateResponse.value=response;
        dashboardController.currencyLiveRateMap["$fromCurrId-$toCurrId"]=response;
        setLiveRateData();
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  void setLiveRateData(){
    if (selectedPackage.value.isRangePackageCost==false) {
      convertedAmount.value = (selectedPackage.value.packageCost??0) / (liveRateResponse.value.liveRate??0);
      if (convertedAmount.value.isNaN || convertedAmount.value.isInfinite) {
        convertAmountController.text="";
      } else {
        convertAmountController.text=Utility.INSTANCE.formatedAmountNinePlace(convertedAmount.value);
      }
    } else {
      if (amountController.text.trim().isNotEmpty) {
        convertedAmount.value = double.parse(amountController.text.trim()) / (liveRateResponse.value.liveRate??0);
        if (convertedAmount.value.isNaN || convertedAmount.value.isInfinite) {
          convertAmountController.text = "";
        } else {
          convertAmountController.text = Utility.INSTANCE.formatedAmountNinePlace(convertedAmount.value);
        }
      }
    }
  }


  void submitDetail(Function callback) async {
    userIdError.value = "";
    typeError.value = "";
    packageError.value = "";
    walletError.value = "";
    amountError.value = "";
    convertAmountError.value = "";

    if ((topupDataByUserIdResponse.value.userID ?? 0) == 0) {
      userIdError.value = "Please Enter Valid User id";
      return;
    } else if ((selectedType.value.oid ?? 0) == 0) {
      typeError.value = "Please Select Type";
      return;
    } else if ((selectedPackage.value.packageId ?? 0) == 0) {
      packageError.value = "Please Select Package";
      return;
    } else if (selectedPackage.value.isRangePackageCost == true && amountController.text.trim().isEmpty) {
      amountError.value = "Please Enter Amount";
      return;
    } else if (selectedPackage.value.isRangePackageCost == true &&
        (double.parse(amountController.text.trim()) > (selectedPackage.value.rangePackageCost ?? 0) ||
            double.parse(amountController.text.trim()) < (selectedPackage.value.packageCost ?? 0))) {
      amountError.value = "Amount should be between  ${Utility.INSTANCE.formatedAmountWithOutRupees(selectedPackage.value.packageCost ?? 0.0)}  to  ${Utility.INSTANCE.formatedAmountWithOutRupees(selectedPackage.value.rangePackageCost ?? 0.0)}";
      return;
    } else if (convertAmountController.text.trim().isEmpty) {
      convertAmountError.value = "Please Enter Convert Amount";
      return;
    } else if (dashboardController.currencyBalanceMap.isNotEmpty && dashboardController.currencyBalanceMap.containsKey(selectedCurrency.value.displayConversionCurrId)) {
      if (double.parse(dashboardController.currencyBalanceMap[selectedCurrency.value.displayConversionCurrId ?? 0]!.balance ?? "0") < convertedAmount.value) {
        convertAmountError.value = "you have insufficient balance";
        return;
      }
    }

    await activateUserApi(callback);
  }

  Future<void> activateUserApi(Function callback) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Activating Member ...', isCancelabel: false);
    await api.activateUser(AppSessionBasicRequest(
        request: ActivateUserRequest(0, topupDataByUserIdResponse.value.userId??userIdController.text.trim(),
            selectedPackage.value.packageId??0, selectedType.value.oid??0, "",
            selectedPackage.value.isRangePackageCost==true?amountController.text.trim():"${selectedPackage.value.packageCost}",
            selectedCurrency.value.currencyId??0),
        appSession: BasicRequest(loginResponse.data!.loginTypeID, loginResponse.data!.userID, loginResponse.data!.session, loginResponse.data!.sessionID,
            APP_ID, DEVICE_ID, "", packageInfo.version, DEVICE_ID)), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        if(callback!=null){
          callback(response);
        }
        await dashboardController.balance(true);
        await dashboardController.currencyList(true, null);
        dashboardController.isBalCryptoApi=true;
        // for(var item in dashboardController.displayBalCryptoList) {
        //   await dashboardController.getCryptoBalanceApi(item.id??0,true, false);
        // }

        /*dashboardController.getCryptoBalanceApi(selectedCurrency.value.displayConversionCurrId ?? 0,false);*/


      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }


  @override
  void dispose() {
    userIdController.dispose();
    typeController.dispose();
    packageController.dispose();
    walletController.dispose();
    amountController.dispose();
    convertAmountController.dispose();
    super.dispose();
  }


}
