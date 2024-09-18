import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../api/TypeActions.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/userDetails/EditUser.dart';
import '../../api/model/userDetails/UserDetail.dart';
import '../../api/model/userDetails/UserDetailResponse.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import 'ProfileApi.dart';
import 'ProfileController.dart';

class UpdateProfileController extends GetxController {

  var nameError="".obs;
  var mobileError="".obs;
  var altMobileError="".obs;
  var emailError="".obs;
  var dobError="".obs;
  var addressError="".obs;
  var landmarkError="".obs;
  var pincodeError="".obs;
  var aadharError="".obs;
  var panError="".obs;
  var bankError="".obs;
  var branchError="".obs;
  var ifscError="".obs;
  var acNumError="".obs;
  var acNameError="".obs;
  GetStorage storage = Get.find();


  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController altMobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController ifscController = TextEditingController();
  final TextEditingController acNumController = TextEditingController();
  final TextEditingController acNameController = TextEditingController();
  ProfileApi api = ProfileApi();
  var userDetailResponse=UserDetailResponse().obs;

  LoginResponse loginResponse =Get.find();

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

  Future<void> getUserDetails() async {

    await api.getProfile(storage, loginResponse.data!, (action, response) async {

      if (action == TypeActions.INSTANCE.SUCCESS) {
        userDetailResponse.value =response;
        UserDetail details= response.userInfo!;
          nameController.text = (details.name??"").trim();
          mobileController.text = (details.mobileNo??"").trim();
          altMobileController.text = (details.alternateMobile??"").trim();
          emailController.text = (details.emailID??"").trim();
          dobController.text = (details.dob??"").trim();
          addressController.text = (details.address??"").trim();
          landmarkController.text = (details.landmark??"").trim();
          pincodeController.text = (details.pincode??"").trim();
          aadharController.text = (details.aadhar??"").trim();
          panController.text = (details.pan??"").trim();
          bankController.text = (details.bankName??"").trim();
          branchController.text = (details.branchName??"").trim();
          ifscController.text = (details.ifsc??"").trim();
          acNumController.text = (details.accountNumber??"").trim();
          acNameController.text = (details.accountName??"").trim();

        if(details.isDoubleFactor!=loginResponse.data!.isDoubleFactor){
          loginResponse.data!.isDoubleFactor = details.isDoubleFactor;
          Get.delete<LoginResponse>(force: true);
          Get.put(loginResponse,permanent: true);
          await storage.write(LOGIN_DATA, loginResponse.toJson());
        }

      }else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  Future<void> updateSubmit() async {
     nameError.value="";
     mobileError.value="";
     altMobileError.value="";
     emailError.value="";
     dobError.value="";
     addressError.value="";
     landmarkError.value="";
     pincodeError.value="";
     aadharError.value="";
     panError.value="";
     bankError.value="";
     branchError.value="";
     ifscError.value="";
     acNumError.value="";
     acNameError.value="";

    if(nameController.text.trim().isEmpty){
      nameError.value="Enter full name.";
      return;
    }else if(mobileController.text.trim().isEmpty || mobileController.text.trim().length!=10){
      mobileError.value="Enter valid 10 digit mobile number.";
      return;
    }else if(altMobileController.text.trim().isEmpty || altMobileController.text.trim().length!=10){
      altMobileError.value="Enter valid 10 digit mobile number.";
      return;
    }else if(emailController.text.trim().isEmpty || !emailController.text.trim().isEmail){
      emailError.value="Enter valid email id.";
      return;
    }else if(dobController.text.trim().isEmpty){
      dobError.value="Select date of birth.";
      return;
    }else if(addressController.text.trim().isEmpty){
      addressError.value="Enter full address.";
      return;
    }else if(landmarkController.text.trim().isEmpty){
      landmarkError.value="Enter nearest landmark.";
      return;
    }else if(pincodeController.text.trim().isEmpty || pincodeController.text.trim().length!=6){
      pincodeError.value="Enter valid 6 digit pincode.";
      return;
    }/*else if(aadharController.text.trim().isEmpty || aadharController.text.trim().length!=12){
      aadharError.value="Enter valid 12 digit aadhar number.";
      return;
    } else if(panController.text.trim().isEmpty || panController.text.trim().length!=10){
      panError.value="Enter valid pan number.";
      return;
    }else if(bankController.text.trim().isEmpty){
      bankError.value="Select bank.";
      return;
    }else if(branchController.text.trim().isEmpty){
      branchError.value="Enter branch.";
      return;
    }else if(ifscController.text.trim().isEmpty){
      ifscError.value="Enter IFSC Code.";
      return;
    }else if(acNumController.text.trim().isEmpty){
      acNumError.value="Enter Account Number.";
      return;
    }else if(acNameController.text.trim().isEmpty){
      acNameError.value="Enter Account Name.";
      return;
    }*/

    await updateUserDetails(EditUser(
        aadhar: aadharController.text.trim(),
        pan: panController.text.trim(),
        address: addressController.text.trim(),
        mobileNo: mobileController.text.trim(),
        alternateMobile: altMobileController.text.trim(),
        name: nameController.text.trim(),
        outletName: nameController.text.trim(),
        emailID: emailController.text.trim(),
        pincode: pincodeController.text.trim(),
        dob: dobController.text.trim(),
        landmark: landmarkController.text.trim(),
        bankName: bankController.text.trim(),
        ifsc: ifscController.text.trim(),
        accountNumber: acNumController.text.trim(),
        accountName: acNameController.text.trim(),
        branchName: branchController.text.trim(),
        isGSTApplicable: userDetailResponse.value.userInfo != null
            ? userDetailResponse.value.userInfo!.isGSTApplicable ?? false
            : false,
        isTDSApplicable: userDetailResponse.value.userInfo != null
            ? userDetailResponse.value.userInfo!.isTDSApplicable ?? false
            : false,
        isCCFGstApplicable: userDetailResponse.value.userInfo != null
            ? userDetailResponse.value.userInfo!.isCCFGstApplicable ?? false
            : false,
        userID: userDetailResponse.value.userInfo != null
            ? userDetailResponse.value.userInfo!.userID ??
                loginResponse.data!.userID
            : 0,
        profilePic: userDetailResponse.value.userInfo != null
            ? userDetailResponse.value.userInfo!.profilePic ?? ""
            : "",
        commRate: userDetailResponse.value.userInfo != null
            ? userDetailResponse.value.userInfo!.commRate ?? 0
            : 0,
        gstin: userDetailResponse.value.userInfo != null
            ? userDetailResponse.value.userInfo!.gstin ?? ""
            : "",
        shopType: userDetailResponse.value.userInfo != null
            ? userDetailResponse.value.userInfo!.shopType ?? ""
            : "",
        locationType: userDetailResponse.value.userInfo != null
            ? userDetailResponse.value.userInfo!.locationType ?? ""
            : "",
        qualification: userDetailResponse.value.userInfo != null
            ? userDetailResponse.value.userInfo!.qualification ?? ""
            : "",
        poupulation: userDetailResponse.value.userInfo != null
            ? userDetailResponse.value.userInfo!.poupulation ?? ""
            : ""));
  }

  Future<void> updateUserDetails(EditUser editUser) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Updating Profile ...', isCancelabel: false);
    await api.updateProfile(storage, editUser,loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        userDetailResponse.value.userInfo!.name=editUser.name;
        userDetailResponse.value.userInfo!.outletName=editUser.outletName;
        userDetailResponse.value.userInfo!.mobileNo=editUser.mobileNo;
        userDetailResponse.value.userInfo!.alternateMobile=editUser.alternateMobile;
        userDetailResponse.value.userInfo!.emailID=editUser.emailID;
        userDetailResponse.value.userInfo!.dob=editUser.dob;
        userDetailResponse.value.userInfo!.address=editUser.address;
        userDetailResponse.value.userInfo!.landmark=editUser.landmark;
        userDetailResponse.value.userInfo!.pincode=editUser.pincode;
        userDetailResponse.value.userInfo!.aadhar=editUser.aadhar;
        userDetailResponse.value.userInfo!.pan=editUser.pan;
        userDetailResponse.value.userInfo!.bankName=editUser.bankName;
        userDetailResponse.value.userInfo!.branchName=editUser.branchName;
        userDetailResponse.value.userInfo!.ifsc=editUser.ifsc;
        userDetailResponse.value.userInfo!.accountNumber=editUser.accountNumber;
        userDetailResponse.value.userInfo!.accountName=editUser.accountName;
        api.updateStoredProfile(storage, userDetailResponse.value);
        ProfileController controller=Get.find();
        controller.userDetailResponse.value=userDetailResponse.value;

        loginResponse.data!.name=editUser.name;
        loginResponse.data!.emailID=editUser.emailID;
        loginResponse.data!.pincode=editUser.pincode;
        loginResponse.data!.mobileNo=editUser.mobileNo;
        api.updateLoginData(storage,loginResponse);


        Utility.INSTANCE.dialogIconOneButton("check","", response, "Cancel");
      }else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }
 /* void signup(BuildContext context,Function callBack) {
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
    await api.signup( SignupRequest(referalID: reffralStr , referalIDstr: referralController.text.trim(), legs: leg.value, domain: DOMAIN,
        appid: APP_ID, imei: DEVICE_ID, regKey: "", version: packageInfo.version, serialNo: DEVICE_ID, userCreate: UserCreateSignup(pincode: pincodeController.text.trim(),
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
  }*/

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    altMobileController.dispose();
    emailController.dispose();
    dobController.dispose();
    addressController.dispose();
    landmarkController.dispose();
    pincodeController.dispose();
    aadharController.dispose();
    panController.dispose();
    bankController.dispose();
    branchController.dispose();
    ifscController.dispose();
    acNumController.dispose();
    acNameController.dispose();
    super.dispose();
  }


}
