import 'dart:convert';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';

class CustomWidgets {
  static void buildBottomSheet(BuildContext context, Barcode? qrResult) {
    final size = MediaQuery.of(context).size;
    var getEventName, getGuestName, getGuestPhone;

    if (qrResult!.code != null) {
      print("getCode>>>>>${qrResult.code}");
      Map<dynamic, dynamic> getData = jsonDecode(qrResult.code!);
      getEventName = getData.containsKey("Event Name") ? getData["Event Name"] : "";
      getGuestPhone = getData.containsKey("Guest Phone") ? getData["Guest Phone"] : "";
      getGuestName = getData.containsKey("Guest Name") ? getData["Guest Name"] : "";
      print("getGuestPhone>>>>>$getGuestPhone");
    }

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text('Guest Info',  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 50),
              Row(
                children: [
                  const Text('Event Name: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(getEventName),
                ],
              ),
              Divider(height: 20),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Guest Name: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(getGuestName),
                ],
              ),
              Divider(height: 20),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Guest Phone: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(getGuestPhone),
                ],
              ),
              Divider(height: 20),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Continue', style: TextStyle(color: Colors.white),),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
