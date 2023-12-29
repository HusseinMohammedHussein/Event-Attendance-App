import 'dart:io';

import 'package:business_umbrella/pages/promoter/PromoterHome.dart';
import 'package:business_umbrella/widgets/custom_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PromoterScanQR extends StatefulWidget {
  const PromoterScanQR({super.key});

  @override
  State<PromoterScanQR> createState() => _PromoterScanQRState();
}

class _PromoterScanQRState extends State<PromoterScanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;


  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }
@override
  void dispose() {
    super.dispose();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? customButton(context)
                  : Text('Scan a code'),
/*              Text(
                  'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')*/
            ),
          )
        ],
      ),
    );
  }
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  Widget customButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
          side: const BorderSide(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c) => const PromoterHome()), (route) => false);
        CustomWidgets.buildBottomSheet(context, result!);
      },
      child: const Text("Continue",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
