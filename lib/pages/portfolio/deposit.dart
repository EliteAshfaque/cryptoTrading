import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cryptox/api/bank/adminBanks/adminBanks.dart';
import 'package:cryptox/api/upload/fileUpload.dart';
import 'package:cryptox/api/wallet/userWallet/userWallets.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:cryptox/util/loader.dart';
import 'package:cryptox/widget/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletons/skeletons.dart';

import '../../api/request/createRequest/createRequest.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {

  final amountController = TextEditingController();
  final utrController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<AdminBanksStruct> banks = [];
  Wallet? inrWallet;
  List<String> paymentTypes = ["NEFT","IMPS","UPI"];
  final GlobalKey<FormState> _requestFormKey = GlobalKey<FormState>();
  String paymentTypesVal = "NEFT";
  String docId = "";
  bool isLoading = true;
  bool isBankSelected = false;
  bool docUploaded = false;
  late AdminBanksStruct selectedBank;
  late StreamSubscription adminBankSubscription;
  late StreamSubscription inrRequestSubscription;
  late StreamSubscription uploadDocSubscription;
  late StreamSubscription getEntrySubscription;


  @override
  void initState() {
    super.initState();
    adminBankSubscription = apiCalls.adminBanks$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if(value is String) {
        return;
      }
      if(value is List<AdminBanksStruct>) {
        setState(() {
          banks = value;
          isLoading = false;
        });
      }
    });
    adminBankSubscription = apiCalls.adminBanks$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if(value is String) {
        return;
      }
      if(value is List<AdminBanksStruct>) {
        setState(() {
          banks = value;
          isLoading = false;
        });
      }
    });

    inrRequestSubscription = apiCalls.inrRequest$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if(value is String) {
        return;
      }
      if(value is FiatRequestStruct) {
        showToast("Request Successfully Placed.", gravity: ToastGravity.BOTTOM, toast: Toast.LENGTH_LONG);
        Navigator.pop(context);
      }
    });
    uploadDocSubscription = apiCalls.uploadDoc$.listen((value) {
      LoadingOverlay.hideLoader(context);
      if(value is String) {
        Navigator.pop(context);
        return;
      }
      if(value is DocumentsStruct) {
        Navigator.pop(context);
        setState(() {
          docId = value.uniqueId ?? "";
          docUploaded = true;
        });
      }
    });
    apiCalls.getDepositBankAdmin(context);
    apiCalls.getUniqueCode(context, paymentTypesVal);
  }


  @override
  void dispose() {
    super.dispose();
    adminBankSubscription.cancel();
    inrRequestSubscription.cancel();
    uploadDocSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: Com.barGradient(),
            )
        ),
        titleSpacing: 0.0,
        title: Text(
          'Inr Deposit',
          style: white16SemiBoldTextStyle,
        ),
      ),
      body: !isBankSelected ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height20Space,
          Container(
              margin: EdgeInsets.only(left: 12.0),
              child: Text("Select Bank")
          ),
          height5Space,
          Expanded(child: bankList())
        ],
      ) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            height20Space,
            Text("Selected Bank: ${selectedBank.bankName}"),
            height20Space,
            Text(
              double.parse(inrWallet!.balance!).toStringAsFixed(3),
              style: black18BoldTextStyle,
            ),
            height5Space,
            Text(
              'Current Balance',
              style: black12RegularTextStyle,
            ),
            SizedBox(height: fixPadding * 3.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
              child: Theme(
                  data: ThemeData(
                    primaryColor: primaryColor,
                    textSelectionTheme: TextSelectionThemeData(
                      cursorColor: primaryColor,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Payment Type: "),
                      DropdownButton(
                        items: paymentTypes.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        value: paymentTypesVal,
                        onChanged: (String? newValue) {
                          setState(() {
                            paymentTypesVal = newValue!;

                          });
                        },
                      ),
                    ],
                  )
              ),
            ),
            height20Space,
            Form(
              key: _requestFormKey,
              child: Column(
                children: [
                  Theme(
                    data: ThemeData(
                      primaryColor: greyColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                      child: TextFormField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        style: black16RegularTextStyle,
                        validator: (val) {
                          if(val!.isEmpty) {
                            return "Fill Me";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          labelStyle: black16RegularTextStyle,
                          suffix: Text('\₹', style: black16RegularTextStyle),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Amount Textfield End
                  height20Space,
                  Theme(
                    data: ThemeData(
                      primaryColor: greyColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
                      child: TextFormField(
                        controller: utrController,
                        keyboardType: TextInputType.number,
                        style: black16RegularTextStyle,
                        validator: (val) {
                          if(val!.isEmpty) {
                            return "Fill Me";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Utr',
                          labelStyle: black16RegularTextStyle,
                          suffixIcon: docUploaded ? Text("") : Container(
                            margin: EdgeInsets.only(left: 16.0),
                            width: 70,
                            decoration: BoxDecoration(
                                color: primaryColor
                            ),
                            child: GestureDetector(
                              onTap: () {
                                selectOptionBottomSheet(DocumentsType.transferProof);
                              },
                              child: Center(
                                  child: Text("Upload", style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center)
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor, width: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            height20Space,
            // Deposit Button Start
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.circular(5.0),
                child: InkWell(
                  onTap: () {
                    if(!_requestFormKey.currentState!.validate()) {
                      return;
                    }
                    if(docId.isEmpty) {
                      showToast("Upload document.", gravity: ToastGravity.BOTTOM,
                          toast: Toast.LENGTH_LONG);
                      return;
                    }
                    if(inrWallet == null) {
                      showToast("Failed to get inr wallet.", gravity: ToastGravity.BOTTOM,
                          toast: Toast.LENGTH_LONG);
                      return;
                    }
                    Object obj = {
                      "walletId": inrWallet!.uniqueId,
                      "amount" : amountController.text,
                      "bankId" : selectedBank.id,
                      "paymentMode" : paymentTypesVal,
                      "utrNo" : utrController.text,
                      "docId" : docId
                    };
                    LoadingOverlay.showLoader(context);
                    apiCalls.submitInrRequest(obj, context);
                  },
                  borderRadius: BorderRadius.circular(5.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(fixPadding * 0.7),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: primaryColor,
                    ),
                    child: Text(
                      'Deposit'.toUpperCase(),
                      style: white16MediumTextStyle,
                    ),
                  ),
                ),
              ),
            ),
            // Deposit Button End
            height5Space,
            Text(
              'Processing time upto 15 minutes',
              style: black14MediumTextStyle,
            ),
            height20Space,
            depositGuide(),
            height20Space,
            depositNote(),
            heightSpace
          ],
        ),
      ),
    );
  }

  depositGuide() {
    return Container(
      margin: EdgeInsets.only(left: 16.0,right: 16.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 1.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height20Space,
          Text("You will be displayed with the Admin's account holder's name, account number, bank and branch "
              "names, and the bank branch's IFSC code.\n\nBefore completing the transaction, get the reference "
              "code and enter it in the 'Add remarks' section. You will receive the 'Transaction ID' "
              "once you have completed the payment process after a successful deposit.\n\nFill out the form "
              "with the deposit amount, deposit type, transaction ID, and proof to upload. After that, "
              "click the 'Submit button. \n\nAfter admin verification, the funds will be deposited "
              "into your 1fx wallet.\n\nYou will receive an email after the funds have been "
              "successfully transferred to your wallet.",
            style: black14RegularTextStyle,
          ),
          height20Space
        ],
      ),
    );
  }

  depositNote() {
    return Container(
      margin: EdgeInsets.only(left: 16.0,right: 16.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 1.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height20Space,
          Text(
            'Notes:',
            style: black16SemiBoldTextStyle,
          ),
          heightSpace,
          Text("1. While depositing do not mention any crypto related sentences or words in"
              " Narration / Remarks\n\n2. Deposit bank details may change for each and every request.\n\n"
              "3. Transfer to any other bank will not be credited.\n\n4. Transfer only from your registered "
              "bank account in 1fx.",
            style: black14RegularTextStyle,
          ),
          height20Space
        ],
      ),
    );
  }

  Widget bankList() {
    return isLoading ? SkeletonListView() : ListView.builder(
        shrinkWrap: true,
        itemCount: banks.length,
        itemBuilder: (BuildContext context, int index) {
          AdminBanksStruct item = banks[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedBank = item;
                isBankSelected = true;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 115.0,
                decoration: BoxDecoration(
                  color: Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      color: blackColor.withOpacity(0.05),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item.bankName!}',
                          style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w600)),
                      heightSpace,
                      Text("Acc No: ${item.accNumber}",style: TextStyle(color: Color(0xff959595),
                          fontWeight: FontWeight.w600, fontSize: 11.0
                      )),
                      height5Space,
                      Text("Ifsc: "+item.ifsc!, style: TextStyle(color: Color(0xff959595),
                          fontWeight: FontWeight.w600, fontSize: 11.0
                      )),
                      height5Space,
                      Text("Name: "+item.accHolderName!, style: TextStyle(color: Color(0xff959595),
                          fontWeight: FontWeight.w600, fontSize: 11.0
                      )),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  amountSuggestionItem(amount) {
    return InkWell(
      onTap: () {
        setState(() {
          amountController.text = '$amount';
        });
      },
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        padding: EdgeInsets.all(fixPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: greyColor.withOpacity(0.2),
        ),
        child: Text(
          '\$$amount',
          style: black14RegularTextStyle,
        ),
      ),
    );
  }

  selectOptionBottomSheet(DocumentsType type) {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: whiteColor,
            child: Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    padding: EdgeInsets.all(fixPadding),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Choose Option',
                            textAlign: TextAlign.center,
                            style: black18BoldTextStyle,
                          ),
                        ),
                        heightSpace,
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: fixPadding),
                          width: width,
                          height: 1.0,
                          color: greyColor.withOpacity(0.5),
                        ),
                        InkWell(
                          onTap: () async {
                            final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                            if(image != null){
                              var li = image.path.split("/");
                              print(li[li.length-1]);
                              await uploadFile(File(image.path),type);
                            }
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.photo_album,
                                  color: Colors.black.withOpacity(0.7),
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Upload from Gallery',
                                  style: black14MediumTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Future uploadFile(File file,DocumentsType type) async {
    print("===================================================");
    try {
      if (kDebugMode){print(file.uri.toString());}
      List<int> fileInByte = file.readAsBytesSync();
      String fileInBase64 = base64Encode(fileInByte);
      if (kDebugMode){print(fileInBase64.toString());}
      Map<String,dynamic> map = new Map();
      // Object obj = {
      map['image'] = file;
      map['data'] = fileInBase64.toString();
      map['type'] = type.name;
      // };
      LoadingOverlay.showLoader(context);
      apiCalls.uploadUserDocs(map, context);
    } catch (e) {
      print("IMAGE NOT UPLOADED");
    }
  }

}
