
import 'dart:async';
import 'package:get/get.dart';
import '../../api/TypeActions.dart';
import '../../api/model/currencyList/LiveRateData.dart';
import '../../api/model/depositQr/GetTechnologyQrResponse.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../utils/Utility.dart';
import '../dashboard/DashboardController.dart';
import 'DepositQrApi.dart';

class DepositQrController extends GetxController {

  DepositQrApi api = DepositQrApi();
  LoginResponse loginResponse =Get.find();
  LiveRateData currencyItem = Get.arguments[0];
  bool isFromWallet=Get.arguments[1];
  DashboardController dashboardController =Get.find();
  var technologyQrResponse =GetTechnologyQrResponse().obs;
  var cryptoBalanceList=<LiveRateData>[].obs;
  bool isScreenOpen=true;
  Timer? timer;


  @override
  void onInit() async {
    super.onInit();
    getCryptoList();
    genrateQr(currencyItem,false);
  }

  void getCryptoList(){
    if (dashboardController.allCryptoList .isNotEmpty) {
      cryptoBalanceList.clear();
      for (var item in dashboardController.allCryptoList) {
        if (item.id == (isFromWallet==true?currencyItem.currencyId:currencyItem.id)) {
          cryptoBalanceList.add(item);
        } else if (item.isCoin == true && item.technologyId == currencyItem.technologyId /*&& (item.isBalanceFromDB==false|| item.id == (isFromWallet==true?currencyItem.currencyId:currencyItem.id))*/) {
          cryptoBalanceList.add(item);
        }
      }

    }else{
      dashboardController.currencyList(false,(){
        if (dashboardController.allCryptoList .isNotEmpty) {
          cryptoBalanceList.clear();
          for (var item in dashboardController.allCryptoList) {
            if (item.id == (isFromWallet==true?currencyItem.currencyId:currencyItem.id)) {
              cryptoBalanceList.add(item);
            } else if (item.isCoin == true && item.technologyId == currencyItem.technologyId /*&& (item.isBalanceFromDB==false|| item.id == (isFromWallet==true?currencyItem.currencyId:currencyItem.id))*/) {
              cryptoBalanceList.add(item);
            }
          }

        }
      });
    }
  }

 Future<void> genrateQr( LiveRateData item,bool isFromClick) async {

    await api.genrateQr(isFromClick,isFromWallet,item,loginResponse.data!, (action, response,{bool? isFromApi = false}) async {

      if (action == TypeActions.INSTANCE.SUCCESS) {
        technologyQrResponse.value=response;
        if(currencyItem.isAutoDeposit==true /*technologyQrResponse.value.isAutoDeposit==true*/ && isFromApi==true){

          if(timer!=null){
            timer!.cancel();
          }
          if (isScreenOpen == true) {
            timer = Timer(const Duration(seconds: 10), () async {
              await  checkBalanceAutoDeposit((isFromWallet==true?(item.currencyId??0):(item.id??0)));
            },
            );
           /* await Future.delayed(const Duration(seconds: 10), () async {
              await  checkBalanceAutoDeposit((isFromWallet==true?(item.currencyId??0):(item.id??0)));
            });*/
          }
        }
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> checkBalanceAutoDeposit( int id) async {

    await api.checkBalanceAutoDeposit(id,loginResponse.data!, (action, response) async {

      if (action == TypeActions.INSTANCE.SUCCESS) {
        Utility.INSTANCE.dialogIconOneButton("check", "", response.msg??"Deposit is successfully completed", "Cancel");

        // if(currencyItem.isAutoDeposit==true/*technologyQrResponse.value.isAutoDeposit==true*/ ){
        //   await dashboardController.balance(true);
        // }
        // await dashboardController.currencyList(true, null);
        /*for(var item in cryptoBalanceList) {
          await dashboardController.getCryptoBalanceApi(item.id??0,true, false);
        }*/
        await dashboardController.currencyList(true,(){
          getCryptoList();
        });
        await dashboardController.balance(true);
        dashboardController.isBalCryptoApi=true;

      } else if (action == TypeActions.INSTANCE.ERROR) {
       // Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
        if(timer!=null){
          timer!.cancel();
        }
        if (isScreenOpen == true) {
          timer = Timer(const Duration(seconds: 10), () async {
            await checkBalanceAutoDeposit(id);
          },
          );
          /* await Future.delayed(const Duration(seconds: 10), () async {
              await checkBalanceAutoDeposit(id);
            });*/
        }
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        //Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
        if(timer!=null){
          timer!.cancel();
        }
        if (isScreenOpen == true) {
          timer = Timer(const Duration(seconds: 10), () async {
            await checkBalanceAutoDeposit(id);
          },
          );
          /* await Future.delayed(const Duration(seconds: 10), () async {
              await checkBalanceAutoDeposit(id);
            });*/
        }
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
    if(timer!=null){
      timer!.cancel();
    }
    isScreenOpen=false;
    super.dispose();
  }
}
