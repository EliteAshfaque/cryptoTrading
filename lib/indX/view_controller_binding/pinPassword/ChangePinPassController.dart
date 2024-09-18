import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/TypeActions.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import 'ChangePinPassApi.dart';


 class ChangePinPassController extends GetxController {


   TextEditingController passwordController =TextEditingController(text: "");
   final passError="".obs;
   var passVisibility=true.obs;

   TextEditingController passwordOldController =TextEditingController(text: "");
   final passOldError="".obs;
   var passOldVisibility=true.obs;

   TextEditingController passwordNewController =TextEditingController(text: "");
   final passNewError="".obs;
   var passNewVisibility=true.obs;

   TextEditingController passwordConfController =TextEditingController(text: "");
   final passConfError="".obs;
   var passConfVisibility=true.obs;

  final pinControllers = <TextEditingController?>[].obs;
  final confPinControllers = <TextEditingController?>[].obs;

  final pinError="".obs;
  final pinValue="".obs;

  final confPinError="".obs;
  final confPinValue="".obs;

  ChangePinPassApi api = ChangePinPassApi();
   LoginResponse loginResponse =Get.find();


  Future<void> changePinPass( bool isPin ,Function? callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', isPin==true?'Changing PIN Password...':'Changing Password...',isCancelabel: false);
    await api.changePinPass( isPin,
        isPin==true?passwordController.text.trim():passwordOldController.text.trim(),
        isPin==true?pinValue.value:passwordNewController.text.trim(),
        isPin==true?confPinValue.value:passwordConfController.text.trim(),
        loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        passwordController.text="";
        passwordOldController.text="";
        passwordNewController.text="";
        passwordConfController.text="";
        if(callBack!=null){
          callBack();
        }
        Get.back();
        Utility.INSTANCE.dialogIconOneButton("check","", response, "Cancel");

      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }









  @override
  void dispose() {



    passwordController.dispose();
    passwordOldController.dispose();
    passwordNewController.dispose();
    passwordConfController.dispose();

    for(var item in pinControllers){
      item!.dispose();
    }
    pinControllers.clear();

    for(var item in confPinControllers){
      item!.dispose();
    }
    confPinControllers.clear();


    super.dispose();
  }



}