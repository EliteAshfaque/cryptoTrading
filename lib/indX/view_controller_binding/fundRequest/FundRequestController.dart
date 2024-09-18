import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../api/TypeActions.dart';
import '../../api/model/balance/BalanceData.dart';
import '../../api/model/fundRequest/Bank.dart';
import '../../api/model/fundRequest/FundRequestRequest.dart';
import '../../api/model/fundRequest/PaymentMode.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../common/ConstantString.dart';
import '../../utils/DialogBuilder.dart';
import '../../utils/Utility.dart';
import '../dashboard/DashboardController.dart';
import 'FundRequestApi.dart';

class FundRequestController extends GetxController {
  var walletError = "".obs;
  var rqstToError = "".obs;
  var bankError = "".obs;
  var acNumError = "".obs;
  var acNameError = "".obs;

  /*var branchNameError="".obs;*/
  /* var ifscError="".obs;*/
  var modeError = "".obs;
  var amountError = "".obs;
  var acHolderNameError = "".obs;
  var txnIdError = "".obs;
  var chequeNoError = "".obs;
  var cardNoError = "".obs;
  var branchError = "".obs;
  var upiError = "".obs;
  var mobileError = "".obs;

  final TextEditingController walletController = TextEditingController();
  final TextEditingController rqstToController = TextEditingController();
  final TextEditingController bankController = TextEditingController();
  final TextEditingController acNumController = TextEditingController();
  final TextEditingController acNameController = TextEditingController();

  /* final TextEditingController branchNameController = TextEditingController();*/
  /*final TextEditingController ifscController = TextEditingController();*/
  final TextEditingController modeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController acHolderNameController = TextEditingController();
  final TextEditingController txnIdController = TextEditingController();
  final TextEditingController chequeNoController = TextEditingController();
  final TextEditingController cardNoController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController upiController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  FundRequestApi api = FundRequestApi();

  LoginResponse loginResponse = Get.find();
  DashboardController dashboardController = Get.find();
  List<BalanceData> balanceWithFundProcessList = <BalanceData>[];
  Rx<BalanceData> selectedWallet = Get.arguments;
  var bankModeList = <Bank>[].obs;
  var selectedBank = Bank().obs;
  var selectedMode = PaymentMode().obs;
  final ImagePicker picker = ImagePicker();
  var selectedImage = File("").obs;
  PackageInfo packageInfo = Get.find();

  @override
  void onInit() {
    balanceWithFundProcessList = dashboardController.balanceResponse.value.balanceData!.where((item) => item.inFundProcess == true).toList();
    walletController.text = selectedWallet.value.walletType ?? "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getBankAndMode();
    });
    super.onInit();
  }

  Future<void> getBankAndMode() async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Getting Bank & Payment Mode ...',isCancelabel: false);
    await api.getBankAndMode(packageInfo, loginResponse.data!, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        bankModeList.value = response;
        if (bankModeList.isNotEmpty) {
          setBank(bankModeList[0]);
        }
      } else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error", "", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton(
            "wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }
    });
  }

  setBank(Bank item) {
    selectedBank.value = item;
    bankController.text = item.bankName ?? "";
    acNumController.text = item.accountNo ?? "";
    acNameController.text = item.accountHolder ?? "";
    /*branchNameController.text=item.branchName??"";
    ifscController.text=item.ifscCode??"";*/
    if (item.mode != null && item.mode!.isNotEmpty) {
      setMode(item.mode![0]);
    }
  }

  setMode(PaymentMode item) {
    selectedMode.value = item;
    modeController.text = item.mode ?? "";
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await picker.pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      selectedImage.value = imageTemp;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> submit() async {
    walletError.value = "";
    rqstToError.value = "";
    bankError.value = "";
    acNumError.value = "";
    acNameError.value = "";
    /*branchNameError.value="";
     ifscError.value="";*/
    modeError.value = "";
    amountError.value = "";
    acHolderNameError.value = "";
    txnIdError.value = "";
    chequeNoError.value = "";
    cardNoError.value = "";
    branchError.value = "";
    upiError.value = "";
    mobileError.value = "";

    if (walletController.text.trim().isEmpty) {
      walletError.value = "Select Wallet";
      return;
    } else if (bankController.text.trim().isEmpty) {
      bankError.value = "Select Bank";
      return;
    } else if (modeController.text.trim().isEmpty) {
      modeError.value = "Select Payment Mode";
      return;
    } else if (amountController.text.trim().isEmpty) {
      amountError.value = "Enter Amount";
      return;
    } else if (selectedMode.value.isAccountHolderRequired == true && acHolderNameController.text.trim().isEmpty) {
      acHolderNameError.value = "Enter Account Holder Name";
      return;
    } else if ((selectedMode.value.isTransactionIdAuto ?? false) == false && txnIdController.text.trim().isEmpty) {
      txnIdError.value = "Enter Transaction Id";
      return;
    } else if (selectedMode.value.isChequeNoRequired == true && chequeNoController.text.trim().isEmpty) {
      chequeNoError.value = "Enter Cheque Number";
      return;
    } else if (selectedMode.value.isCardNumberRequired == true && (cardNoController.text.trim().isEmpty || cardNoController.text.trim().length != 16)) {
      cardNoError.value = "Enter Valid 16 Digit Card Number";
      return;
    } else if (selectedMode.value.isBranchRequired == true && branchController.text.trim().isEmpty) {
      branchError.value = "Enter Branch Name";
      return;
    } else if (selectedMode.value.isUPIID == true && (upiController.text.trim().isEmpty || !upiController.text.trim().contains("@"))) {
      upiError.value = "Enter Valid UPI Id";
      return;
    } else if (selectedMode.value.isMobileNoRequired == true && (mobileController.text.trim().isEmpty || mobileController.text.trim().length != 10)) {
      mobileError.value = "Enter Valid 10 Digit Mobile Number";
      return;
    }

    await submitRequest();
  }

  Future<void> submitRequest() async {
    DialogBuilder.INSTANCE.showLoadingIndicator('', 'Requesting For Fund ...', isCancelabel: false);
    var request = FundRequestRequest(
        "0",
        upiController.text.trim(),
        "",
        selectedBank.value.id ?? 0,
        amountController.text.trim(),
        txnIdController.text.trim(),
        mobileController.text.trim(),
        chequeNoController.text.trim(),
        cardNoController.text.trim(),
        acHolderNameController.text.trim(),
        acNumController.text.trim(),
        selectedImage.value.path.isNotEmpty ? 1 : 0,
        selectedMode.value.modeID ?? 0,
        selectedWallet.value.id ?? 0,
        loginResponse.data!.loginTypeID ?? 0,
        loginResponse.data!.userID ?? 0,
        loginResponse.data!.session ?? "",
        loginResponse.data!.sessionID ?? 0,
        APP_ID,
        DEVICE_ID,
        "",
        packageInfo.version,
        DEVICE_ID);
    await api.submitFundRequest(selectedImage.value.path.isNotEmpty ? selectedImage.value : null, request, (action, response) async {
      DialogBuilder.INSTANCE.hideOpenDialog();
      if (action == TypeActions.INSTANCE.SUCCESS) {
        Utility.INSTANCE.dialogIconOneButtonBackScreen("check", "", response, "Ok");
        await dashboardController.balance(true);
        await dashboardController.currencyList(true, null);
        dashboardController.isBalCryptoApi = true;
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
    rqstToController.dispose();
    acNumController.dispose();
    acNameController.dispose();
    /* branchNameController.dispose();
    ifscController.dispose();*/
    modeController.dispose();
    amountController.dispose();
    acHolderNameController.dispose();
    txnIdController.dispose();
    chequeNoController.dispose();
    cardNoController.dispose();
    bankController.dispose();
    walletController.dispose();
    branchController.dispose();
    upiController.dispose();
    mobileController.dispose();
    super.dispose();
  }
}
