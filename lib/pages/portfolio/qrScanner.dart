import 'dart:io';
import 'package:cryptox/constant/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QrScanner extends StatefulWidget {
  Function func;

  QrScanner({Key? key, required this.func}) : super(key: key);

  @override
  _QrScanner createState() => _QrScanner();
}

class _QrScanner extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  double zoomLevel = 1.0;
  TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: GestureDetector(
              onScaleUpdate: (ScaleUpdateDetails details) {
                setState(() {
                  zoomLevel = details.scale;
                  _transformationController.value = Matrix4.identity()
                    ..scale(zoomLevel);
                });
              },
              child: InteractiveViewer(
                transformationController: _transformationController,
                child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                        borderColor: Colors.red,
                        borderRadius: 10,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: scanArea)),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                height20Space,
                (result != null)
                    ? Text('Data: ${result!.code}')
                    : Text('Scan destination address only.'),
                height5Space,
                InkWell(
                  onTap: () => Navigator.pop(context),
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
                      'Cancel',
                      style: white14MediumTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    if (kDebugMode) {
      print("mnonn " + controller.toString());
    }
    bool scanned = false;
    this.controller = controller;
    if (Platform.isAndroid) {
      this.controller!.resumeCamera();
    }
    controller.scannedDataStream.listen((scanData) {
      if (kDebugMode) {
        print("SCAN DATA " + scanData.code!);
      }
      widget.func(scanData);
      if (!scanned) {
        scanned = true;
        Navigator.pop(context);
      }
      // setState(() {
      //   result = scanData;
      // });
    });
  }
}
