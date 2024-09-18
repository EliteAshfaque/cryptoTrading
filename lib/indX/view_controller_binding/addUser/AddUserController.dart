import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/TypeActions.dart';
import '../../api/model/signup/RoleRequest.dart';
import '../../api/model/signup/RoleResponse.dart';
import '../../api/model/signup/SignupRequest.dart';
import '../../api/model/signup/UserCreateSignup.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import 'AddUserApi.dart';

class AddUserController extends GetxController {
  var referralError="".obs;
  var nameError="".obs;
  var mobileError="".obs;
  var emailError="".obs;
  var addressError="".obs;
  var pincodeError="".obs;

  var leg ="L".obs;
  var inputReferrralId ="";
  final TextEditingController referralController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  AddUserApi api = AddUserApi();
  PackageInfo packageInfo = Get.find();

  var roleResponse = RoleResponse().obs;

  /*@override
  void onInit() {
    super.onInit();
  }*/

  Future<void> role(context, String reffralId) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Referral Details ...', isCancelabel: false);
    await api.role(RoleRequest(isSeller: true,referralID: reffralId.isEmpty?"1":reffralId, domain: DOMAIN, appid: APP_ID, imei: DEVICE_ID, regKey: "",
            version: packageInfo.version, serialNo: DEVICE_ID), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        inputReferrralId=reffralId.isEmpty?"1":reffralId;
        leg.value=response.legs??"L";
        roleResponse.value=response;
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }
  void signup(BuildContext context,Function callBack) {
    referralError.value="";
    nameError.value="";
    mobileError.value="";
    emailError.value="";
    addressError.value="";
    pincodeError.value="";

    if(referralController.text.trim().isEmpty){
      referralError.value="Enter referral id.";
      return;
    }else if(roleResponse.value.childRoles==null){
      referralError.value="Enter valid referral id.";
      return;
    }else if(nameController.text.trim().isEmpty){
      nameError.value="Enter full name.";
      return;
    }else if(mobileController.text.trim().isEmpty || mobileController.text.trim().length!=10){
      mobileError.value="Enter 10 digit mobile number.";
      return;
    }else if(emailController.text.trim().isEmpty || !emailController.text.trim().isEmail){
      emailError.value="Enter valid email id.";
      return;
    }else if(addressController.text.trim().isEmpty){
      addressError.value="Enter full address.";
      return;
    }else if(pincodeController.text.trim().isEmpty || pincodeController.text.trim().length!=6){
      pincodeError.value="Enter valid 6 digit pincode.";
      return;
    }
    register(context,callBack);
  }


  Future<void> register(context, Function callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Registering ...', isCancelabel: false);
    String reffralStr =referralController.text.trim().isNumericOnly ? referralController.text.trim() : referralController.text.trim().replaceAll(RegExp("[^0-9]"), "");
    await api.signup( SignupRequest(isSeller: true,referalID: reffralStr , referalIDstr: referralController.text.trim(), legs: leg.value, domain: DOMAIN,
        appid: APP_ID, imei: DEVICE_ID, regKey: "", version: packageInfo.version, serialNo: DEVICE_ID, userCreate: UserCreateSignup(isSeller: true,pincode: pincodeController.text.trim(),
            mobileNo: mobileController.text.trim(),name: nameController.text.trim(),address: addressController.text.trim(), countryCode: "+91",
            emailID: emailController.text.trim(),legs: leg.value,outletName: nameController.text.trim(), referalID:reffralStr ,
            referalIDstr: referralController.text.trim(),roleID: roleResponse.value.childRoles![0].id??0)), (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {

         referralError.value="";
         nameError.value="";
         mobileError.value="";
         emailError.value="";
         addressError.value="";
         pincodeError.value="";
         leg.value ="L";
         inputReferrralId ="";
         referralController.text="" ;
         nameController.text="" ;
         mobileController.text="" ;
         emailController.text="" ;
         addressController.text="";
         pincodeController.text="" ;
         roleResponse.value = RoleResponse();
         if(callBack!=null){
           callBack(response);
         }else{
           Utility.INSTANCE.dialogIconOneButton("check", "", response.msg??"Successfully Registered", "Cancel");
         }

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
    referralController.dispose();
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    super.dispose();
  }


}
