import 'dart:async';
import 'package:flutter/material.dart';

import '../constant/constant.dart';

class CountDownTimer extends StatefulWidget {

  final Duration duration;
  final Function onClick;
  final bool? showMyWidget;
  final Function? showMyFunc;
  CountDownTimer({Key? key, required this.duration, required this.onClick,
    this.showMyWidget = false, this.showMyFunc}) : super(key: key);

  @override
  State<CountDownTimer> createState() => CountdownTimerNew();
}

class CountdownTimerNew extends State<CountDownTimer> {


  Timer? countdownTimer;
  Duration? myDuration;
  bool showResend = false;
  bool showTimer = true;

  @override
  void initState() {
    print("COUNTDOWN");
    super.initState();
    myDuration = widget.duration;
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    this.stopTimer();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    countdownTimer!.cancel();
  }

  void resetTimer() {
    if(mounted) {
      stopTimer();
      setState(() => myDuration = widget.duration);
    }
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    if(mounted) {
      setState(() {
        final seconds = myDuration!.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer!.cancel();
          if(widget.showMyFunc == null) {
            changeResendState();
          }else {
            widget.showMyFunc!();
          }
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return widget.showMyWidget! ? Text(
      '${myDuration!.inSeconds}',
      style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 40),
    ) : showResend ? InkWell(
      onTap: () {
        widget.onClick();
      },
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: (width - fixPadding * 14.0) / 2,
        padding: EdgeInsets.symmetric(vertical: fixPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: primaryColor,
        ),
        child: Text(
          'Resend OTP',
          style: white14MediumTextStyle,
        ),
      ),
    ) : Text(
      '${myDuration!.inSeconds}',
      style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
          fontSize: 40),
    );
  }

  changeResendState() {
    setState(() {
      showResend = !showResend;
    });
    print("RESEND $showResend");
  }

  changeShowTimerState() {
    setState(() {
      showTimer = !showTimer;
    });
  }

}