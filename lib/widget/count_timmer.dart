import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final Duration totalDuration;
  final Duration initialTime;

  CountdownTimer({required this.totalDuration, required this.initialTime});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration remainingTime;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remainingTime = widget.totalDuration - widget.initialTime;
    startTimer();
  }

  void startTimer() {
    timer?.cancel(); // Cancel any existing timer
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime.inSeconds > 0) {
          remainingTime -= Duration(seconds: 1);
        } else {
          timer.cancel(); // Stop the timer when it reaches 0
        }
      });
    });
  }

  @override
  void didUpdateWidget(covariant CountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.totalDuration != oldWidget.totalDuration ||
        widget.initialTime != oldWidget.initialTime) {
      remainingTime = widget.totalDuration - widget.initialTime;
      startTimer();
    }
  }

  @override
  void dispose() {
    timer?.cancel(); // Cancel timer on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "Time Remaining Before Expiration: ${formatDuration(remainingTime)}",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
}
