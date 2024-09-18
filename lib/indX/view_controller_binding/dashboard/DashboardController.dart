import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../api/TypeActions.dart';
import '../../api/model/balance/AllowedWithdrawalType.dart';
import '../../api/model/balance/BalanceData.dart';
import '../../api/model/balance/BalanceResponse.dart';
import '../../api/model/currencyList/AllowTransferMapping.dart';
import '../../api/model/currencyList/CurrencyBalanceData.dart';
import '../../api/model/currencyList/LiveRateData.dart';
import '../../api/model/currencyList/LiveRateResponse.dart';
import '../../api/model/dashboardData/DashboardData.dart';
import '../../api/model/dashboardData/StakeBalanceResponse.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../routes/AppRoutes.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import 'DashboardApi.dart';

class DashboardController extends GetxController {



   GetStorage storage = Get.find();
   DashboardApi api =DashboardApi();
   LoginResponse loginResponse =Get.find();
   var currencyLiveRateMap = <String, LiveRateResponse>{}.obs;
   var currencyBalanceMap = <int, CurrencyBalanceData>{}.obs;
   var walletDepositCurrencyMappingMap = <int, List<LiveRateData>>{};
   var currencyBalanceLoadedId ="".obs;
   var balanceResponse =BalanceResponse().obs;
   var isBinaryOn=1.obs;
   var defaultCurrencySymbol="".obs;
   var defaultCurrencyId=0.obs;
   var userTopupType=0.obs;
   var userTopupBy=0.obs;
   var dashboardDownlineData =DashboardData().obs;
  var stakeBalanceResponse =StakeBalanceResponse().obs;
    var allCryptoList=<LiveRateData>[].obs;
   var displayBalCryptoList=<LiveRateData>[].obs;
   var liveRateCryptoList=<LiveRateData>[].obs;
   var isBalCryptoApi=false;

  var screenWidth=MediaQuery.of(Get.context!).size.width;
  @override
  void onInit() async {
    super.onInit();


    await dashboardData(false);
    await balance(false);
    await currencyList(false,null);


  }

  Future<void> onRefresh() async{
    /* walletDepositCurrencyMappingMap.clear();*/
    await dashboardData(true);

    await balance(true);
    if(balanceResponse.value.isStake==true) {
      await stakeBalance(true);
    }
    await currencyList(true,null);
  }
   Future<void> emailVerify() async {

     DialogBuilder.INSTANCE.showLoadingIndicator('', 'Verifying Email id ...',isCancelabel: false);
     await api.emailVerify( loginResponse.data!, (action, response) async {
       DialogBuilder.INSTANCE.hideOpenDialog();
       if (action == TypeActions.INSTANCE.SUCCESS) {
         Utility.INSTANCE.dialogIconOneButton("check","", response, "Cancel");
       }else if (action == TypeActions.INSTANCE.ERROR) {
         Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
       } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
         Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
       }

     });
   }

   Future<void> balance(bool isFromRefresh) async {

     await api.balance(isFromRefresh, loginResponse.data!,screenWidth, (action, response) async {

       if (action == TypeActions.INSTANCE.SUCCESS) {
         balanceResponse.value =response;
         isBinaryOn.value=response.isBinaryon??1;
         defaultCurrencySymbol.value= response.defaultCurrencySymbol??"\u20B9";
         defaultCurrencyId.value= response.defaultCurrencyId??0;
         userTopupType.value= response.userTopupType??0;
         userTopupBy.value= response.userTopupBy??0;
         if(isFromRefresh==false && balanceResponse.value.isStake==true) {
           await stakeBalance(true);
         }
       }else if (action == TypeActions.INSTANCE.ERROR) {
         Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
       } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
         Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
       }

     });
   }

   Future<void> dashboardData(bool isFromRefresh) async {

     await api.dashboardData( isFromRefresh, loginResponse.data!, (action, response) async {

       if (action == TypeActions.INSTANCE.SUCCESS) {
         dashboardDownlineData.value =response;
       }else if (action == TypeActions.INSTANCE.ERROR) {
         Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
       } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
         Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
       }

     });
   }

   Future<void> stakeBalance(bool isFromRefresh) async {

     await api.stakeBalance( isFromRefresh, loginResponse.data!, (action, response) async {

       if (action == TypeActions.INSTANCE.SUCCESS) {
         stakeBalanceResponse.value =response;
       }else if (action == TypeActions.INSTANCE.ERROR) {
         //Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
       } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        // Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
       }

     });
   }

   Future<void> currencyList(bool isFromRefresh,Function? callback) async {

     await api.currencyList(isFromRefresh, loginResponse.data!, (action, response) async {

       if (action == TypeActions.INSTANCE.SUCCESS) {
         if(isFromRefresh==true){
           currencyBalanceMap.clear();
           currencyLiveRateMap.clear();
           currencyBalanceLoadedId.value="";
         }
         allCryptoList.value=response;
         displayBalCryptoList.value=  response.where((item) => item.isDisplayBalance  == true).toList();
         liveRateCryptoList.value=  response.where((item) => item.isDisplayLiveRate  == true).toList();

         if(callback!=null){
           callback();
         }
       }else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
       } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
         Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
       }

     });
   }



  Future<void> getCryptoBalanceApi(int id,bool isFromBCBal,bool isFromDashboard) async {

    if(!currencyBalanceMap.containsKey(id) && isFromDashboard==true){
      currencyBalanceMap[id]= CurrencyBalanceData(balance: "0",balanceInUSDT: 0);
    }
    await api.getCryptoBalance( loginResponse.data!,id,isFromBCBal, (action, response) async {
      /*int loadId=id;
      if(response is CurrencyBalanceData){
        loadId=(response.requestedCurrID??0)>0?response.requestedCurrID??id:id;
      }*/
      if(isFromDashboard==true /*&& !currencyBalanceLoadedId.value.contains("_$id")*/) {
        currencyBalanceLoadedId.value = "${currencyBalanceLoadedId.value}_$id";
      }
      if (action == TypeActions.INSTANCE.SUCCESS) {
        currencyBalanceMap[(response.requestedCurrID??0)>0?response.requestedCurrID??id:id]= response;
      }else if (action == TypeActions.INSTANCE.ERROR) {
        //Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        //Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });

  }

  Future<void> getLiveRate( int fromCurrId,int toCurrId) async {

    if(!currencyLiveRateMap.containsKey("$fromCurrId-$toCurrId")){
      currencyLiveRateMap["$fromCurrId-$toCurrId"]=LiveRateResponse(liveRate: 0);
    }
    await api.getLiveRate( fromCurrId, toCurrId,loginResponse.data!, (action, response) async {
      if (action == TypeActions.INSTANCE.SUCCESS) {
        currencyLiveRateMap["$fromCurrId-$toCurrId"]=response;
      } else if (action == TypeActions.INSTANCE.ERROR) {
        //Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
       // Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }


  void withdrawalWallet(BalanceData item, Function? callBack){
    if (item.allowedWithdrawalType != null && item.allowedWithdrawalType!.isNotEmpty) {
      if (item.allowedWithdrawalType!.length > 1) {
        if(callBack!=null){
          callBack();
        }

      } else {
        openWalletWithdrawal(item.allowedWithdrawalType![0], item);

      }
    } else {
      Get.toNamed(AppRoutes.walletToWalletTransfer,arguments: item)!.then((value){
        if(isBalCryptoApi==false){
          balance(true);
          currencyList(true, null);
        }else{
          isBalCryptoApi=false;
        }

      });
      /*startActivity(new Intent(this, WalletToWalletTransferNetworkingActivity.class)
          .putExtra("BalanceData", balanceCheckResponse)
          .putExtra("WalletTransferType", item.getWalletTransferType())
          .putExtra("FromWalletId", item.getId())
          .putParcelableArrayListExtra("WalletList", item.getAllowedWallet())
          .addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP));*/
    }
  }

   void openWalletWithdrawal(AllowedWithdrawalType withdrawalType, BalanceData mBalanceData) {
    if (withdrawalType.serviceId == 2) {
      Utility.INSTANCE.showSnackbar("Coming Soon", "No implemented");
      /*openDMT();*/
    } else if (withdrawalType.serviceId == 42) {
      Get.toNamed(AppRoutes.bankAccounts,arguments: [mBalanceData,withdrawalType])!.then((value){
        if(isBalCryptoApi==false){
          balance(true);
          currencyList(true, null);
        }else{
          isBalCryptoApi=false;
        }
      });
      /*startActivity(new Intent(this, BankTransferNetworkingActivity.class)
          .putExtra("BalanceData", balanceCheckResponse)
          .putExtra("FromWalletId", mBalanceData.getId())
          .putExtra("OpTypeId", operator.getServiceId())
          .putExtra("FromWallet", mBalanceData.getWalletType())
          .addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP));*/
    } else if (withdrawalType.serviceId == 62) {
      Utility.INSTANCE.showSnackbar("Coming Soon", "No implemented");
      /*startActivity(new Intent(this, UPIListActivity.class)
          .putExtra("BalanceData", balanceCheckResponse)
          .addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP));*/
    } else if (withdrawalType.serviceId == 76) {
      Get.toNamed(AppRoutes.walletToBlockChainTransfer,arguments: mBalanceData)!.then((value){
        if(isBalCryptoApi==false){
          balance(true);
          currencyList(true, null);
        }else{
          isBalCryptoApi=false;
        }
      });
      /*startActivity(new Intent(this, WalletBlockChainTransferNetworkingActivity.class)
          .putExtra("BalanceData", balanceCheckResponse)
          .putExtra("FromWalletId", mBalanceData.getId())
          .putExtra("FromWallet", mBalanceData.getWalletType())
          .putExtra("CurrencySymbolId", mBalanceData.getWalletCurrencyID())
          .putExtra("CurrencySymbol", mBalanceData.getWalletCurrencySymbol())
          .putParcelableArrayListExtra("WalletToCryptoList", mBalanceData.getAllowedWalletToCripto())
          .addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP));*/
    } else {
      Get.toNamed(AppRoutes.walletToWalletTransfer,arguments: mBalanceData)!.then((value){
        if(isBalCryptoApi==false){
          balance(true);
          currencyList(true, null);
        }else{
          isBalCryptoApi=false;
        }
      });
      /*startActivity(new Intent(this, WalletToWalletTransferNetworkingActivity.class)
          .putExtra("BalanceData", balanceCheckResponse)
          .putExtra("WalletTransferType", mBalanceData.getWalletTransferType())
          .putExtra("FromWalletId", mBalanceData.getId())
          .putParcelableArrayListExtra("WalletList", mBalanceData.getAllowedWallet())
          .addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP));*/
    }
  }

   void withdrawalCrypto(LiveRateData item, Function? callBack) {


    if (item.allowedTransferMappings != null && item.allowedTransferMappings!.isNotEmpty) {
      if (item.allowedTransferMappings!.length > 1) {
        if(callBack!=null){
          callBack();
        }
      } else {
        openCryptoTransfer(item.allowedTransferMappings![0], item);
      }
    } else {
      Get.toNamed(AppRoutes.cryptoTransfer,arguments: item)!.then((value){
        if(isBalCryptoApi==false){
          balance(true);
          currencyList(true, null);
        }else{
          isBalCryptoApi=false;
        }
      });
      /*startActivity(new Intent(this, CryptoTransferNetworkingActivity.class)
          .putExtra("TechnologyId", item.getTechnologyId())
          .putExtra("Coin", item.getCurrencyName())
          .putExtra("CurrencyId", item.getId())
          .putExtra("isBalanceFromDB", item.isBalanceFromDB())
          .putExtra("isGoogle2FAEnable", balanceCheckResponse.isGoogle2FAEnable())
          .putExtra("isGoogle2FARegister", balanceCheckResponse.isGoogle2FARegister())
          .putParcelableArrayListExtra("CoinList", cryptoBalanceList));*/
    }

  }


   void openCryptoTransfer(AllowTransferMapping allowTransferMapping, LiveRateData item) {

    if (allowTransferMapping.serviceId == 76) {
      Get.toNamed(AppRoutes.cryptoTransfer,arguments: item)!.then((value) {
        if(isBalCryptoApi==false){
          balance(true);
          currencyList(true, null);
        }else{
          isBalCryptoApi=false;
        }
      });
     /* startActivity(new Intent(this, CryptoTransferNetworkingActivity.class)
          .putExtra("TechnologyId", item.getTechnologyId())
          .putExtra("Coin", item.getCurrencyName())
          .putExtra("CurrencyId", item.getId())
          .putExtra("isBalanceFromDB", item.isBalanceFromDB())
          .putExtra("isGoogle2FAEnable", balanceCheckResponse.isGoogle2FAEnable())
          .putExtra("isGoogle2FARegister", balanceCheckResponse.isGoogle2FARegister())
          .putParcelableArrayListExtra("CoinList", cryptoBalanceList));*/
    } else {
      Utility.INSTANCE.showSnackbar("Coming Soon", "No implemented");
      /*startActivity(new Intent(this, CryptoWalletTransferNetworkingActivity.class)
          .putExtra("TechnologyId", item.getTechnologyId())
          .putExtra("Coin", item.getCurrencyName())
          .putExtra("CoinSymbol", item.getCurrecySymbol())
          .putExtra("isBalanceFromDB", item.isBalanceFromDB())
          .putExtra("isGoogle2FAEnable", balanceCheckResponse.isGoogle2FAEnable())
          .putExtra("isGoogle2FARegister", balanceCheckResponse.isGoogle2FARegister())
          .putExtra("CoinSymbolId", item.getId())
          .putParcelableArrayListExtra("CurrencyToWallet", item.getCurrencyToWalletTransferMappings())
          .putParcelableArrayListExtra("CoinList", cryptoBalanceList));*/
    }
  }


  Future<void> getWalletDepositCurrencyMapping( int id, Function? callback) async {
    if(walletDepositCurrencyMappingMap.containsKey(id)){
      if(callback!=null){
        callback(walletDepositCurrencyMappingMap[id]);
      }
    }else {
      DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Deposit Mapping ...', isCancelabel: false);
      await api.getWalletDepositCurrencyMapping(id, loginResponse.data!, (action, response) async {
        DialogBuilder.INSTANCE.hideOpenDialog();
        if (action == TypeActions.INSTANCE.SUCCESS) {
          walletDepositCurrencyMappingMap[id] = response;
          if (callback != null) {
            callback(response);
          }
        } else if (action == TypeActions.INSTANCE.ERROR) {
          Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
        } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
          Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
        }
      });
    }
  }

  void openDeposit(BalanceData balanceData,LiveRateData item,bool isFromWallet) {
    if((item.currencySymbol??"").toLowerCase()=="inr"){
      Get.toNamed(AppRoutes.fundRequest,arguments:balanceData.obs)!.then((value) {
        /*if(value==123){
          balance(true);
          }*/
        if(isBalCryptoApi==false){
          balance(true);
          currencyList(true, null);
        }else{
          isBalCryptoApi=false;
        }
      });
    }else{
      Get.toNamed(AppRoutes.depositQR,arguments: [item,isFromWallet])!.then((value) {
        if(isBalCryptoApi==false){
          balance(true);
          currencyList(true, null);
        }else{
          isBalCryptoApi=false;
        }
      });
    }
  }







  stakeNow(Function? callBack) {
   /* stakeType -> 1=> Wallet
    stakeType-> 2=>Crypto*/
    if((stakeBalanceResponse.value.stakeType??"").contains(",")){
      var list =(stakeBalanceResponse.value.stakeType??"").split(",");
      if(callBack!=null){
        callBack(list);
      }

    }else{
      Get.toNamed(AppRoutes.stakeNowByPackage,arguments: (stakeBalanceResponse.value.stakeType??"0"))!.then((value){
        if(isBalCryptoApi==false){
          balance(true);
          currencyList(true, null);
        }else{
          isBalCryptoApi=false;
        }
      });
    }

  }

  void activateUser() {
    if(userTopupBy==1){
      Utility.INSTANCE.showSnackbar("Coming soon", "No implemented");
    }else if(userTopupBy==1){

      Utility.INSTANCE.showSnackbar("Coming soon", "No implemented");
    }else{
      Get.toNamed(AppRoutes.activateUserByStaking)!.then((value){
        if(isBalCryptoApi==false){
          balance(true);
          currencyList(true, null);
        }else{
          isBalCryptoApi=false;
        }
      });
    }
  }

}