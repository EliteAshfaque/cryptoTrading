import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

void showToast(String msg, {ToastGravity? gravity, Toast? toast, bool? isSuccess}) {
  // Set background color based on success or failure, black by default
  Color backgroundColor;
  if (isSuccess == true) {
    backgroundColor = Colors.green; // Green for success
  } else if (isSuccess == false) {
    backgroundColor = Colors.red; // Red for failure
  } else {
    backgroundColor = Colors.black; // Default black when no condition passed
  }

  Get.snackbar(
    '', // Title can be empty if not needed
    msg,
    snackPosition: gravity == ToastGravity.BOTTOM
        ? SnackPosition.BOTTOM
        : SnackPosition.TOP,
    duration: toast == Toast.LENGTH_SHORT
        ? Duration(seconds: 2)
        : Duration(seconds: 4),
    backgroundColor: backgroundColor,
    colorText: Colors.white, // Set text color to white for contrast
    borderRadius: 8, // Optional: Add rounded corners
    margin: EdgeInsets.all(10), // Optional: Add margin around snackbar
    padding: EdgeInsets.symmetric(
        horizontal: 16, vertical: 10), // Optional: Add padding inside snackbar
  );
}
