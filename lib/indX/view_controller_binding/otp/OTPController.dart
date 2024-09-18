import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


 class OTPController extends GetxController {


   final otpControllers = <TextEditingController?>[].obs;
   final otpError="".obs;
   final otpValue="".obs;

   Timer? countdownTimer;
   Rx<Duration> myDuration =  const Duration(seconds: 60).obs;
   var isOTPTimerStart = false.obs;












   String second(){
     String strDigits(int n) => n.toString().padLeft(2, '0');
     var seconds = strDigits(myDuration.value.inSeconds.remainder(60));
     if (seconds == "-1" || seconds=="00") {
       seconds = "60";
     }
     return seconds;
   }
   void resetTimer() {

     myDuration.value = const Duration(seconds: 60);
     stopTimer();
   }

   void stopTimer() {

     if (countdownTimer != null) {
       countdownTimer!.cancel();
     }
     isOTPTimerStart.value = false;
   }
   void startTimer() {

     countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
     isOTPTimerStart.value = true;
   }
   void setCountDown() {
     const reduceSecondsBy = 1;

     var seconds = myDuration.value.inSeconds - reduceSecondsBy;

     if (seconds <= 0) {
       resetTimer();
     } else {
       myDuration.value = Duration(seconds: seconds);
     }

   }
@override
  void onClose() {
  if (countdownTimer != null) {
    countdownTimer!.cancel();
  }
    super.onClose();
  }
   @override
   void dispose() {

     for(var item in otpControllers){
       item!.dispose();
     }
     otpControllers.clear();

     if (countdownTimer != null) {
       countdownTimer!.cancel();
     }
     super.dispose();
   }

   void disposeOtpDialog() {

     otpError.value="";
     otpValue.value="";
     if (countdownTimer != null && countdownTimer!.isActive) {
       resetTimer();
     }
   }


}