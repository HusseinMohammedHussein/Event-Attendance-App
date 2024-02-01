import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';

import '../pages/promoter/PromoterHome.dart';

class CustomWidgets {
  static void buildBottomSheet(
      BuildContext context, Barcode? qrResult, String responseMessage) {
    var getEventName, getGuestName, getGuestPhone;

    if (qrResult!.code != null) {
      log("getCode>>>>>${qrResult.code}");
      Map<dynamic, dynamic> getData = jsonDecode(qrResult.code!);
      getEventName =
          getData.containsKey("Event Name") ? getData["Event Name"] : "";
      getGuestPhone =
          getData.containsKey("Guest Phone") ? getData["Guest Phone"] : "";
      getGuestName =
          getData.containsKey("Guest Name") ? getData["Guest Name"] : "";
      log("getGuestPhone>>>>>$getGuestPhone");
      log("getGuestPhone: $getGuestPhone");
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
              const Text('Guest Info',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              const SizedBox(height: 50),
              Row(
                children: [
                  const Text('Event Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(getEventName),
                ],
              ),
              Divider(height: 20),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Guest Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(getGuestName),
                ],
              ),
              Divider(height: 20),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Guest Phone: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(getGuestPhone),
                ],
              ),
              Divider(height: 20),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (c) => PromoterHome()),
                      (route) => false);
                  buildToast(responseMessage, Colors.green);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static void showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      useRootNavigator: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void buildToast(String msg, Color bgColor) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget buildPhoneInput(PhoneNumber initCountryIsoCode,
      Function validation, TextEditingController textEditingController) {
    return InternationalPhoneNumberInput(
      onInputChanged: (value) {
        log("PhoneNumber: ${value.isoCode}");
      },
      locale: 'SA',
      countrySelectorScrollControlled: true,
      keyboardType: TextInputType.phone,
      initialValue: initCountryIsoCode,
      validator: validation(),
      textFieldController: textEditingController,
    );
  }

  static Widget buildTextFormField(
      TextInputType inputType,
      InputDecoration inputDecoration,
      Function validation,
      TextEditingController textEditingController) {
    return TextFormField(
      keyboardType: inputType,
      decoration: inputDecoration,
      validator: validation(),
      controller: textEditingController,
    );
  }

  static void buildShowToast(
      String msg, Color backgroundColor, Color textColor) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: textColor,
        fontSize: 16.0);
  }

  static Widget buildButton(Function onTapFun, String btnTitle) {
    return GestureDetector(
      onTap: onTapFun.call(),
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.green,
        ),
        child: Center(
          child: Text(
            btnTitle,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 17),
          ),
        ),
      ),
    );
  }
}
