import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingOverlay {

  static showLoader(BuildContext context) {
    Loader.show(context,progressIndicator:SpinKitThreeInOut(color: Colors.orange),
      overlayColor: Colors.black12);
  }

  static hideLoader(BuildContext context) {
    Loader.hide();
  }

}