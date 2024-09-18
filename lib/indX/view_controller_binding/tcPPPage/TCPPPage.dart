import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../themes/ThemeColor.dart';
import '../../widgets/AppBarView.dart';
import '../../widgets/DataNotFoundView.dart';
import '../../widgets/LoadingIndicator.dart';
import 'TCPPController.dart';

class TCPPPage extends StatelessWidget {

  TCPPController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBarView(
        titleText: controller.title,
        isImageTitle: false,
        bodyWidget:  Container(
          alignment: Alignment.center,
          child: Obx(() =>controller.isError.value?
          const DataNotFoundView(text: "Data is not available, try after some time"):
          controller.isDataLoaded.value?WebViewWidget(controller:controller.webViewController):LoadingIndicator(
              heading: '',
              text: 'Getting ${controller.title} ...',
              textColor: Colors.black,
          loadingColor: primaryColor)),
        ),
      ),
    );
  }


}
