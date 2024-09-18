import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer24Hours extends StatefulWidget {
  final Duration duration; // Static duration for the timer

  CountdownTimer24Hours({Key? key, required this.duration}) : super(key: key);

  @override
  State<CountdownTimer24Hours> createState() => _CountdownTimer24HoursState();
}

class _CountdownTimer24HoursState extends State<CountdownTimer24Hours> {
  Timer? _countdownTimer;
  late Duration _remainingDuration;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _remainingDuration = widget.duration;
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  // Start the countdown timer
  void _startTimer() {
    _countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => _updateTimer());
  }

  // Stop the countdown timer
  void _stopTimer() {
    _countdownTimer?.cancel();
  }

  // Pause the countdown timer
  void _pauseTimer() {
    setState(() {
      _isPaused = true;
    });
    _stopTimer();
  }

  // Resume the countdown timer
  void _resumeTimer() {
    if (_isPaused) {
      setState(() {
        _isPaused = false;
      });
      _startTimer();
    }
  }

  // Reset the countdown timer
  void _resetTimer() {
    _stopTimer();
    setState(() {
      _remainingDuration = widget.duration;
    });
    _startTimer();
  }

  // Update the remaining time for the countdown
  void _updateTimer() {
    if (_remainingDuration.inSeconds > 0) {
      setState(() {
        _remainingDuration -= Duration(seconds: 1);
      });
    } else {
      _stopTimer();
      // Timer reached 0. You can add a callback or action here.
    }
  }

  // Format duration in HH:MM:SS format
  String _formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Display countdown in HH:MM:SS format
        Text(
          _formatDuration(_remainingDuration),
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isPaused ? _resumeTimer : _pauseTimer,
              child: Text(_isPaused ? 'Resume' : 'Pause'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: _resetTimer,
              child: Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}
