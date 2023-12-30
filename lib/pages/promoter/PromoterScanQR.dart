import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:business_umbrella/models/response/meta.dart';
import 'package:business_umbrella/network/event_api_service.dart';
import 'package:business_umbrella/pages/promoter/PromoterHome.dart';
import 'package:business_umbrella/utils/Utils.dart';
import 'package:business_umbrella/utils/shared_prefrences.dart';
import 'package:business_umbrella/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/meta_result.dart';

class PromoterScanQR extends StatefulWidget {
  const PromoterScanQR({super.key});

  @override
  State<PromoterScanQR> createState() => _PromoterScanQRState();
}

class _PromoterScanQRState extends State<PromoterScanQR> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  var eventService = EventApiService();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Future<MetaResponse> userAttendCalling(context, proToken, getGuestPhone) async {
    return await eventService.userAttend(context, proToken, getGuestPhone);
  }

  sendUserAttend(context) {
    Map<dynamic, dynamic> getData = jsonDecode(result!.code!);
    var getGuestPhone =
        getData.containsKey("Guest Phone") ? getData["Guest Phone"] : "";
    var proToken = PreferenceUtils.getString(Utils.PROMOTOER_TOKIN_KEY);
    userAttendCalling(context, proToken, getGuestPhone).then((value) {
    log("GuestAttendAuthRequest: $proToken");
      setState(() {
        if (value.meta?.code == 200) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (c) => PromoterHome()),
              (route) => false);
          CustomWidgets.buildBottomSheet(context, result!, value.meta!.message!);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            // behavior: SnackBarBehavior.floating,
            content: Text(value.meta!.message!),
            duration: const Duration(milliseconds: 5000),
            action: SnackBarAction(
              label: "Dismiss",
              onPressed: () {},
            ),
          ));
        }
      });
      log("GuestAttendResponseMessage: ${value.meta?.message}");
    });
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
        CustomWidgets.showLoaderDialog(context);
        sendUserAttend(context);
      },
      child: const Text("Continue",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}
