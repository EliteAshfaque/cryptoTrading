import 'package:cryptox/api/user/userAdditionalDetails/userAdditionalDetails.dart';
import 'package:cryptox/common/apiCalls.dart';
import 'package:cryptox/constant/constant.dart';
import 'package:cryptox/util/SharedPref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class OpenOtherApp {

  static createUrl(BuildContext context) async {
    UserDetailsStruct? details = await apiCalls.getDetailsOfUserDirect(context);
    if(details == null) {
      return "";
    }
    Map getSavedDetails = await getUserDetailsFromSF();
    String str = "indxseller://open?referralId=1&referralName=Admin&" + 'userId=${getSavedDetails[email]}&' +
        'name=${getSavedDetails[name]}&' + 'mobile=${getSavedDetails[phone]}&' +
        'email=${getSavedDetails[email]}&' + 'address=${details.address!.trim()}&' +
        'pincode=${details.postalCode}';
    if (kDebugMode) {print(str);}
    return str;
  }

  static createList(BuildContext context) async {
    UserDetailsStruct? details = await apiCalls.getDetailsOfUserDirect(context);
    if(details == null) {
      return [];
    }
    Map getSavedDetails = await getUserDetailsFromSF();
    var list = ["1","Admin",getSavedDetails[email], getSavedDetails[name], getSavedDetails[phone], getSavedDetails[email], details.address!.trim(), details.postalCode];
    return list;
  }

}
