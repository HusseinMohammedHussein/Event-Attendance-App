import 'dart:developer';
import 'dart:io';
import 'package:business_umbrella/network/event_api_service.dart';
import 'package:business_umbrella/utils/shared_prefrences.dart';
import 'package:business_umbrella/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'PromoterHome.dart';

class PromoterLogin extends StatefulWidget {
  const PromoterLogin({super.key});

  @override
  State<PromoterLogin> createState() => _PromoterLoginState();
}

class _PromoterLoginState extends State<PromoterLogin> {
  late Size size;
  var eventService = EventApiService();
  bool isButtonClicked = false;

  // Platform.localeName.split('_').last +966
  PhoneNumber? initCountryIsoCode;

  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var authInputFormatting = const InputDecoration(
    fillColor: Colors.white,
    filled: true,
    border: InputBorder.none,
  );

  @override
  void initState() {
    super.initState();
    initPhoneNum();
  }

  initPhoneNum() async {
    // initCountryIsoCode = PhoneNumber(
    //     isoCode: Platform.localHostname.split('_').last, dialCode: '+966');
    initCountryIsoCode = PhoneNumber(isoCode: 'SA');
  }

  login(context) async {
    log("LoginPhone: ${phoneController.text}");
    await eventService.login(context, phoneController.text).then((value) {
      if (value.meta?.code == 200) {
        PreferenceUtils.setString(Utils.PROMOTOER_TOKIN_KEY,
            "Bearer ${value.data!.accessToken!.accessToken!}");
        PreferenceUtils.setBool(Utils.IS_PROMOTOER_LOGIN, true);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${value.meta?.message}")));
        log("PromoterToken: ${value.data?.accessToken?.accessToken.toString()}");
        setState(() {
          isButtonClicked = false;
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (c) => const PromoterHome()),
              (route) => false);
        });
      } else {
        setState(() {
          isButtonClicked = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${value.meta?.message}")));
        });
        log("PromoterErrorResponse: ${value.meta?.message.toString()}");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: size.height * 0.09),
      color: Colors.green,
      child: Column(
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(top: size.height * 0.03),
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Center(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    changeNameForm(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ))),
          ),
        ],
      ),
    ));
  }

  final spinKit = const SpinKitPouringHourGlassRefined(
    color: Colors.white,
    size: 50.0,
  );

  Widget changeNameForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 60, 0, 5),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(51, 204, 255, 0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]!))),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber value) {
                        log("PhoneNumber: ${value.isoCode}");
                      },
                      locale: 'SAU',
                      countrySelectorScrollControlled: true,
                      // autoFocus: true,
                      keyboardType: TextInputType.phone,
                      initialValue: initCountryIsoCode,
                      validator: (val) =>
                          val!.isEmpty ? "Phone Can't Be Empty" : null,
                      textFieldController: phoneController,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: isButtonClicked
                      ? Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.green,
                          ),
                          child: spinKit)
                      : GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isButtonClicked = true;
                              });
                              login(context);
                              log("PhoneNum: ${phoneController.text}");
                            }
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green,
                            ),
                            child: const Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
