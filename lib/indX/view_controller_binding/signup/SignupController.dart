import 'dart:async';
import 'dart:io';

import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/TypeActions.dart';
import '../../api/model/signup/RoleRequest.dart';
import '../../api/model/signup/RoleResponse.dart';
import '../../api/model/signup/SignupRequest.dart';
import '../../api/model/signup/UserCreateSignup.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import 'SignupApi.dart';

class SignupController extends GetxController {
  var referralError="".obs;
  var nameError="".obs;
  var mobileError="".obs;
  var emailError="".obs;
  var addressError="".obs;
  var pincodeError="".obs;

  var reffralCode="".obs;

  var leg ="L".obs;
  var inputReferrralId ="";
  final TextEditingController referralController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  SignupApi api = SignupApi();
  PackageInfo packageInfo = Get.find();
  GetStorage storage = Get.find();
  var roleResponse = RoleResponse().obs;
  bool isFromLogin = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    if (storage.hasData(IS_REFFER_USED)==false || storage.hasData(IS_REFFER_USED)==true && storage.read(IS_REFFER_USED) == false) {
      initReferrerDetails();
    }

    /*"signature Y39c3xxl+MY"*/
  }

  Future<void> initReferrerDetails() async {
    if (Platform.isAndroid) {
      try {
        ReferrerDetails referrerDetails =
        await AndroidPlayInstallReferrer.installReferrer;
        String referrerUrl = referrerDetails.toString();
        if (referrerUrl != null &&
            referrerUrl.isNotEmpty & !referrerUrl.contains("utm") &&
            !referrerUrl.contains("google") &&
            !referrerUrl.contains("chrome")) {
          reffralCode.value = referrerUrl;
          referralController.text = referrerUrl;
        }
      } catch (e) {
        //e.printError();
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!Get.context!.mounted) return;
    } /*else if (Platform.isIOS) {
      ClipboardData? cdata = await Clipboard.getData(Clipboard.kTextPlain);
      String? referrerUrl = cdata!.text;
      if (referrerUrl != null &&
          referrerUrl.isNotEmpty & referrerUrl.contains("WF") &&
          !referrerUrl.contains("utm") &&
          !referrerUrl.contains("google") &&
          !referrerUrl.contains("chrome")) {
        reffralCode.value = referrerUrl;
        referralController.text = referrerUrl;
      }
    }*/

    /*initDynamicLinks();*/
  }

  /*void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      print("1--- "+deepLink.queryParameters["referrar"].toString());
      Utility.INSTANCE.showSnackbar("Notice","1--- "+deepLink.queryParameters["referrar"].toString());


    }else{
      print("2--- "+deepLink.toString());
      Utility.INSTANCE.showSnackbar("Notice","2--- "+deepLink.toString());
    }

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

    /*if(referralController.text.trim().isEmpty){
      referralError.value="Enter referral id.";
      return;
    }else if(roleResponse.value.childRoles==null){
      referralError.value="Enter valid referral id.";
      return;
    }else*/ if(nameController.text.trim().isEmpty){
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
    String reffralStr =referralController.text.isNotEmpty?(referralController.text.trim().isNumericOnly ? referralController.text.trim() : referralController.text.trim().replaceAll(RegExp("[^0-9]"), "")):"1";
    await api.signup( SignupRequest(isSeller: true,referalID: reffralStr , referalIDstr: referralController.text.isNotEmpty? referralController.text.trim():"1", legs: leg.value, domain: DOMAIN,
        appid: APP_ID, imei: DEVICE_ID, regKey: "", version: packageInfo.version, serialNo: DEVICE_ID, userCreate: UserCreateSignup(isSeller: true,pincode: pincodeController.text.trim(),
            mobileNo: mobileController.text.trim(),name: nameController.text.trim(),address: addressController.text.trim(), countryCode: "+91",
            emailID: emailController.text.trim(),legs: leg.value,outletName: nameController.text.trim(), referalID:reffralStr ,
            referalIDstr: referralController.text.isNotEmpty? referralController.text.trim():"1",
            roleID: (roleResponse.value.childRoles!=null && roleResponse.value.childRoles!.isNotEmpty)?roleResponse.value.childRoles![0].id??0:3)), (action, response) async {
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
         await storage.write(IS_REFFER_USED, true);
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
