import 'dart:async';


import 'package:get/get.dart';

import '../../api/TypeActions.dart';
import '../../api/model/login/LoginResponse.dart';
import '../../api/model/support/ReferralContentResponse.dart';
import '../../common/ConstantString.dart';
import '../../utils/Utility.dart';
import 'InviteReferralApi.dart';

class InviteReferralController extends GetxController {

  InviteReferralApi api = InviteReferralApi();
  LoginResponse loginResponse =Get.find();
  var referralData= ReferralContentResponse().obs;
  var isApiCalled=false.obs;
  String content1="Invite your friends and earn bonus points";
  String content2="Be A Superhero & Help Your Friends To Start  A Safe & Secure Business";
  String shareMsg="";
  String shareLink="";

  @override
  void onInit() async{
    super.onInit();
    shareMsg="$content1\n$content2";
    shareLink="$INVITE_URL${loginResponse.data!.userID??0}";
    if(loginResponse.isReferral==true) {
      await getReferralContent();
    }else{
      isApiCalled.value=true;
    }

  }

  Future<void> getReferralContent() async {

    await api.getReferalContent( loginResponse.data!, (action, response) async {
      isApiCalled.value=true;
      if (action == TypeActions.INSTANCE.SUCCESS) {
        referralData.value =response;
        if( (response.refferalContent??"").isNotEmpty){
          shareMsg=response.refferalContent??"";
        }
        if( (response.refferalLink??"").isNotEmpty && (response.refferalLink??"").isURL){
          shareLink=response.refferalLink??"";
        }
      }else if (action == TypeActions.INSTANCE.ERROR) {
        Utility.INSTANCE.dialogIconOneButton("error","", response, "Cancel");
      } else if (action == TypeActions.INSTANCE.NETWROK_ERROR) {
        Utility.INSTANCE.dialogIconOneButton("wifi_error", "Network Error", "No Internet Connection", "Cancel");
      }

    });
  }

  List <String> stringToList(String first, String second) {
    if(first.isNotEmpty && second.isNotEmpty) {
      return "$first,$second".split(",");
    } else if(first.isNotEmpty) {
      return first.split(",");
    }
    else {
      return second.split(",");
    }
  }





}