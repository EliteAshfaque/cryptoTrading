

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../utils/Utility.dart';
import '../../widgets/AppBarView.dart';


class QRScannerPage extends StatefulWidget {
  const QRScannerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {

  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var isPermissionAllowed = false.obs;
  var isFlashOn = false.obs;
  @override
  Widget build(BuildContext context) {

    return AppBarView(
        titleText: "Scanner",
        bodyWidget: Obx(() => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if(isPermissionAllowed.value==true)...[
              _buildQrView(context),
              Padding(
                padding: const EdgeInsets.all(20),
                child: IconButton(onPressed: () async{
                  await controller?.toggleFlash();
                  isFlashOn.value=!isFlashOn.value;
                }, icon:  Icon(  isFlashOn.value==true?Icons.flash_on:Icons.flash_off,color: Colors.white,)),
              ),
            ],


          ],
        )));
  }

  @override
  void initState()  {
    init();
    super.initState();
  }

  init() async {
    if(await Permission.camera.isGranted==false){
      await Permission.camera.request().then((value) {
        if(value.isDenied){
          Utility.INSTANCE.bottomSheetIconTwoButtonWithCallback("camera","Permission Required","Please Allow camera permission for your app. If you deny permissions will not be able to use functionality of this app.","Setting","Cancel",(value) async {
            if(value==1){
              openAppSettings();
            }
          });
        }
        else if(value.isPermanentlyDenied){
          Utility.INSTANCE.bottomSheetIconTwoButtonWithCallback("camera","Permission Required","Please Allow camera permission for your app. If you deny permissions will not be able to use functionality of this app.","Setting","Cancel",(value) async {
            if(value==1){
              openAppSettings();
            }
          });
        }else{
          init();
        }
      });
    }else{
      isPermissionAllowed.value=true;
    }
  }
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();

  }
  Widget _buildQrView(BuildContext context) {

      // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
      var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 250.0 : 400.0;
      // To ensure the Scanner view is properly sizes after rotation
      // we need to listen for Flutter SizeChanged notification and update controller
      return QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea),
        /*onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),*/
      );


  }

  void _onQRViewCreated(QRViewController controller) {

      this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if(scanData!=null) {
        controller?.dispose();
        Get.back(result: scanData!.code);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    /*log('${DateTime.now().toIso8601String()}_onPermissionSet $p');*/

    if (!p) {
      Utility.INSTANCE.bottomSheetIconTwoButtonWithCallback("camera","Permission Required","Please Allow camera permission for your app. If you deny permissions will not be able to use functionality of this app.","Setting","Cancel",(value) async {
        if(value==1){
          openAppSettings();
        }
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
