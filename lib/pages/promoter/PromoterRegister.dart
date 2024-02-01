import 'dart:developer';
import 'package:business_umbrella/models/request/promoter_register.dart';
import 'package:business_umbrella/network/event_api_service.dart';
import 'package:business_umbrella/pages/auth/new_password.dart';
import 'package:business_umbrella/pages/promoter/PromoterLogin.dart';
import 'package:business_umbrella/utils/shared_prefrences.dart';
import 'package:business_umbrella/utils/utils.dart';
import 'package:business_umbrella/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'PromoterHome.dart';

class PromoterRegister extends StatefulWidget {
  const PromoterRegister({super.key});

  @override
  State<PromoterRegister> createState() => _PromoterRegisterState();
}

class _PromoterRegisterState extends State<PromoterRegister> {
  late Size size;
  var eventService = EventApiService();
  bool isButtonClicked = false;
  var buttonClickedCount = 0;
  var isPhoneValied = false;
  bool isPassValid = false;

  // Platform.localeName.split('_').last +966
  PhoneNumber? initCountryIsoCode;

  final _formKey = GlobalKey<FormState>();
  var nameCont = TextEditingController();
  var emailCont = TextEditingController();
  var phoneCont = TextEditingController();
  var passwordCont = TextEditingController();
  var addressCont = TextEditingController();

  var authInputFormatting = const InputDecoration(
    fillColor: Colors.white,
    filled: true,
    border: InputBorder.none,
  );

  nameValidation() => (val) => val!.isEmpty ? "Name Can't Be Empty" : null;

  emailValidation() => (val) => val!.isEmpty ? "Email Can't Be Empty" : null;

  phoneValidation() => (val) => val!.isEmpty ? "Phone Can't Be Empty" : null;

  passwordValidation() => (val) => val!.isEmpty ? "Password Can't Be Empty" : null;

  addressValidation() =>
      (val) => val!.isEmpty ? "Address Can't Be Empty" : null;

  @override
  void initState() {
    super.initState();
    initPhoneNum();
  }

  initPhoneNum() async {
    initCountryIsoCode = PhoneNumber(isoCode: 'SA');
  }

  register(context) async {
    RegisterRequest promoterRegister = RegisterRequest(
      name: nameCont.text,
      email: emailCont.text,
      address: addressCont.text,
      password: passwordCont.text,
      phone: phoneCont.text,
    );
    await eventService.register(context, promoterRegister).then((value) {
      if (value.code == 200) {
        setState(() {
          isButtonClicked = false;
          CustomWidgets.buildToast("${value.message}", Colors.green);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (c) => const PromoterLogin()),
              (route) => false);
        });
      } else {
        setState(() {
          isButtonClicked = false;
          isPhoneValied = false;
          CustomWidgets.buildToast("${value.message}", Colors.red);
        });
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
                'Register',
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
                    child: SingleChildScrollView(
                  child: registerFormData(),
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

  Function get onActiveAccountTapFun => () {
        if (_formKey.currentState!.validate()) {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (c) => const NewPassword()));
          });
        }
      };

  Widget registerFormData() {
    log("AfterBtnClicked:  $isButtonClicked");
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
                    child: TextFormField(
                      decoration: authInputFormatting.copyWith(
                          hintText: "Name",
                          hintStyle: const TextStyle(color: Colors.black26)),
                      validator: nameValidation(),
                      controller: nameCont,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]!))),
                    child: TextFormField(
                      decoration: authInputFormatting.copyWith(
                          hintText: "Email",
                          hintStyle: const TextStyle(color: Colors.black26)),
                      validator: emailValidation(),
                      controller: emailCont,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]!))),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber value) {
                        log("PhoneNumber: ${value.isoCode}");
                      },
                      locale: 'SA',
                      countrySelectorScrollControlled: true,
                      // autoFocus: true,
                      keyboardType: TextInputType.phone,
                      initialValue: initCountryIsoCode,
                      validator: phoneValidation(),
                      textFieldController: phoneCont,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]!))),
                    child: TextFormField(
                      decoration: authInputFormatting.copyWith(
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.black26)),
                      validator: passwordValidation(),
                      controller: passwordCont,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]!))),
                    child: TextFormField(
                      decoration: authInputFormatting.copyWith(
                          hintText: "Address",
                          hintStyle: const TextStyle(color: Colors.black26)),
                      validator: addressValidation(),
                      controller: addressCont,
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
                    child: Column(
                  children: [
                    isButtonClicked
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

                                register(context);
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
                                  "Continue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => PromoterLogin()));
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
                            "Already have account?",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
