import 'dart:async';

import 'package:cryptox/api/funds/allCoinsFund/allCoinsFund.dart';
import 'package:cryptox/api/funds/generateUserAddress/generateUserAddress.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/Enums.dart';
import 'package:cryptox/util/ToastUtil.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../api/funds/allCoinsFund/networkDetails.dart';
import '../../common/apiCalls.dart';

class DepositCrypto extends StatefulWidget {

  final FundsStruct coin;

  const DepositCrypto({Key? key, required this.coin}) : super(key: key);

  @override
  _DepositCrypto createState() => _DepositCrypto();
}

class _DepositCrypto extends State<DepositCrypto> {

  bool addressLoading = true;
  TextEditingController addressController = TextEditingController();
  UserAddressStruct? userAddress;
  late StreamSubscription userDepositAddressSubscription;
  Timer? apiTimer;
  bool copyFlag = false;
  NetworkDetails selectedNetworkDetails=NetworkDetails();
  // late StreamSubscription depositCryptoSubscription;

  @override
  void initState() {
    super.initState();
    if(widget.coin.networkDetails!=null && widget.coin.networkDetails!.isNotEmpty){
      setState(() {
        selectedNetworkDetails=widget.coin.networkDetails![0];
      });

    }


    userDepositAddressSubscription = apiCalls.userDepositAddress$.listen((value) {
      if (kDebugMode){print("VALUE ON CRYPTO DEPOSIT PAGE "+ value.toString());}
      if(value is String) {
        Navigator.pop(context);
        return;
      }
      if(value is UserAddressStruct) {
        setState(() {
          userAddress = value;
          addressController.text = value.address!;
          addressLoading = false;
        });
      }
    });
    apiTimer = new Timer.periodic(new Duration(milliseconds: 10000), (timer) {
      if(userAddress != null) {
        Object obj = {
          "contractAddress": selectedNetworkDetails.contractAddress,
          "symbol": widget.coin.symbol,
          "walletAddress": userAddress!.address,
          "type": TransactionTypeLedger.CREDITED.name,
          "transferType": TransactionType.Deposit.name,
        };
        apiCalls.depositCryptoAtAddress(selectedNetworkDetails.uniqueId??"", obj,context);
      }
    });
    // depositCryptoSubscription = apiCalls.depositCrypto$.listen((value) {
    //   if(value is String) {
    //     if(value.isEmpty) {
    //       return;
    //     }
    //   }
    // });
  }

  @override
  void dispose() {
    userDepositAddressSubscription.cancel();
    // depositCryptoSubscription.cancel();
    if(apiTimer != null) {
      apiTimer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: addressLoading ? Center(child: Text("Loading...")) : Padding(
          padding: EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                height20Space,
                Text(widget.coin.symbol!.replaceFirst("INR", ""),style: black16MediumTextStyle),
                height20Space,
                if(userAddress != null)
                  QrImageView(
                    data: userAddress!.address ?? "",
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                heightSpace,
                if(widget.coin.networkDetails!=null && widget.coin.networkDetails!.length>1)...[

                  DropdownButtonFormField2<NetworkDetails>(
                    isExpanded: true,
                    style: black16RegularTextStyle,
                    value: selectedNetworkDetails,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 18,horizontal: 12),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: greyColor, width: 0.7),
                      ),
                      labelText: "Network",
                      labelStyle: black16RegularTextStyle,
                    ),
                    items: widget.coin.networkDetails!.map((item) => DropdownMenuItem<NetworkDetails>(
                      value: item,
                      child: Text(
                        item.symbol??"",
                        style: black16RegularTextStyle,
                      ),
                    )).toList(),
                    validator: (value) {
                      if(value==null) {
                        return "Fill Me";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      selectedNetworkDetails = value!;
                      apiCalls.getUserAddress(selectedNetworkDetails.uniqueId??"",widget.coin.symbol??"", context);
                    },
                    buttonStyleData: const ButtonStyleData(
                        width: 0
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 24,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),

                    ),
                  ),
                  height20Space
                ],
                TextFormField(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: addressController.text)).then((value) {
                      showToast("Copied address on clipboard.", gravity: ToastGravity.BOTTOM,
                          toast: Toast.LENGTH_LONG);
                      setState(() {
                        copyFlag = true;
                      });
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text('Copied address on clipboard.'),
                      // ));
                    });
                  },
                  controller: addressController,
                  style: black16RegularTextStyle,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: black16RegularTextStyle,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: greyColor, width: 0.7),
                    ),
                    suffixIcon: Container(
                      margin: EdgeInsets.only(left: 5,right: 5.0),
                      width: 70,
                      decoration: BoxDecoration(
                        color: copyFlag ? Colors.blueAccent : primaryColor,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                          child: Text(copyFlag ? "Copied" : "Copy", style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                      ),
                    ),
                  ),
                ),
                height20Space,
                Text("Disclaimer", style: TextStyle(color: Colors.red,fontSize: 16, fontWeight: FontWeight.w700)),
                height5Space,
                Row(
                  children: [
                    Flexible(
                      child: Text("* Send only using the (${selectedNetworkDetails.symbol}) network."
                          "\n* Using any other network will result in loss of funds.",
                          style: TextStyle(color: Colors.black54,fontSize: 16)),
                    ),
                  ],
                ),
                height5Space,
                Row(
                  children: [
                    Flexible(
                      child: Text("* Deposit only ${widget.coin.symbol!.replaceFirst("INR", "").toUpperCase()} to this deposit address."
                          "\n* Depositing any other asset will result in a loss of funds.",
                          style: TextStyle(color: Colors.black54,fontSize: 16)),
                    ),
                  ],
                ),
                height20Space
              ],
            ),
          ),
        )
      );
  }

}