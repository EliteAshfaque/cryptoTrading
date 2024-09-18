import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../api/TypeActions.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/support/CompanyProfileData.dart';
import '../../api/model/support/Google2FAResponse.dart';
import '../../common/ConstantString.dart';
import '../../routes/AppRoutes.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import '../gAuthSetup/GoogleAuthApi.dart';
import 'SupportApi.dart';

class SupportSettingController extends GetxController {
  GetStorage storage = Get.find();
  SupportApi api = SupportApi();
  GoogleAuthApi apiGA = GoogleAuthApi();
  LoginResponse loginResponse = Get.find();
  var companyData = CompanyProfileData().obs;
  var is2FAEnable = false.obs;
  Rx<bool> isGoogle2FAEnable = Get.arguments;
  TextEditingController callMeMobController = TextEditingController();
  final callMeMobError = "".obs;

  @override
  void onInit() async {
    super.onInit();
    is2FAEnable.value = loginResponse.data!.isDoubleFactor ?? false;
    await getCompanyProfile();
  }

  Future<void> change2FA(bool is2FA, bool isDialogOpen, String otp,
      String refId, Function? callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator(
        '', 'Changing Double Factor Status ...',
        isCancelabel: false);
    await api.change2FA(storage, is2FA, otp, refId, loginResponse.data!,
        (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        if (response.isOTPRequired == true) {
          if (callBack != null) {
            callBack(response);
          }
        } else if (response.isOTPRequired == false &&
            (response.refID ?? "").isEmpty) {
          if (isDialogOpen == true) {
            Get.back();
          }
          Utility.INSTANCE.dialogIconOneButton(
              "check", "", response.msg ?? "Success", "Cancel");
          is2FAEnable.value = !is2FAEnable.value;
          loginResponse.data!.isDoubleFactor = is2FAEnable.value;
          Get.delete<LoginResponse>(force: true);
          Get.put(loginResponse, permanent: true);
          await storage.write(LOGIN_DATA, loginResponse.toJson());
        } else {
          if (isDialogOpen == true) {
            Get.back();
          }
          Utility.INSTANCE.dialogIconOneButton(
              "check", "", response.msg ?? "Success", "Cancel");
          is2FAEnable.value = !is2FAEnable.value;
          loginResponse.data!.isDoubleFactor = is2FAEnable.value;
          Get.delete<LoginResponse>(force: true);
          Get.put(loginResponse, permanent: true);
          await storage.write(LOGIN_DATA, loginResponse.toJson());
        }
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> sendOTPApi(bool isDialogOpen, Function? callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator(
        '', 'Changing GAuth Double Factor Status ...',
        isCancelabel: false);
    await apiGA.sendOTP(storage, loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        Google2FAResponse res = response;
        if ((res.referenceId ?? 0) > 0) {
          if (callBack != null) {
            callBack(res);
          }
        } else {
          if (isDialogOpen == true) {
            Get.back();
          }
          getGoogleAuthData(false, "", 0, (Google2FAResponse response) {
            Get.toNamed(AppRoutes.gAuthSetup,
                arguments: [isGoogle2FAEnable, response.obs]);
          });
        }
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> getGoogleAuthData(
      bool isDialogOpen, String otp, int refId, Function? callBack) async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting GAuth Data ...',
        isCancelabel: false);
    await apiGA.getGAuthData(storage, otp, refId, loginResponse.data!,
        (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();

      if (action == TypeActions.INSTANCE.SUCCESS) {
        if (isDialogOpen == true) {
          Get.back();
        }
        if (response.qrCodeSetupKey != null &&
            response.qrCodeSetupKey!.isNotEmpty &&
            response.qrCodeSetupImageUrl != null &&
            response.qrCodeSetupImageUrl!.isNotEmpty) {
          if (callBack != null) {
            callBack(response);
          }
        } else {
          Utility.INSTANCE.dialogIconOneButton(
              "error", "", "Setup data is not available", "Cancel");
        }
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> getCompanyProfile() async {
    await api.getCompanyDetails(storage, loginResponse.data!,
        (action, response) async {
      if (action == TypeActions.INSTANCE.SUCCESS) {
        companyData.value = response;
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  Future<void> callMeRqst() async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Sending Call Me Request ...', isCancelabel: false);
    await api.callMeRqst(storage,callMeMobController.text.trim(), loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        Utility.INSTANCE.dialogIconOneButton("check", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  List<String> stringToList(String first, String second) {
    if (first.isNotEmpty && second.isNotEmpty) {
      return "$first,$second".split(",");
    } else if (first.isNotEmpty) {
      return first.split(",");
    } else {
      return second.split(",");
    }
  }

  @override
  void dispose() {
    callMeMobController.dispose();
    super.dispose();
  }
}
