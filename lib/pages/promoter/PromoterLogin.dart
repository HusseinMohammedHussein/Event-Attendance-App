import 'dart:developer';
import 'package:business_umbrella/models/request/promoter_login.dart';
import 'package:business_umbrella/network/event_api_service.dart';
import 'package:business_umbrella/pages/promoter/PromoterRegister.dart';
import 'package:business_umbrella/utils/shared_prefrences.dart';
import 'package:business_umbrella/utils/utils.dart';
import 'package:business_umbrella/widgets/custom_widgets.dart';
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
  var buttonClickedCount = 0;

  // var isPhoneValied = false;
  bool isPassValid = false;

  // Platform.localeName.split('_').last +966
  PhoneNumber? initCountryIsoCode;

  final _formKey = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

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
    initCountryIsoCode = PhoneNumber(isoCode: 'SA');
  }

  login(context) async {
    LoginRequest loginRequest = LoginRequest(
      phone: phoneController.text,
      password: passwordController.text,
    );
    await eventService.login(context, loginRequest).then((value) {
      if (value.meta?.code == 200) {
        setState(() {
          PreferenceUtils.setString(Utils.PROMOTOER_TOKIN_KEY,
              "Bearer ${value.accessToken?.accessToken!}");
          PreferenceUtils.setBool(Utils.IS_PROMOTOER_LOGIN,
              value.accessToken?.accessToken != null ? true : false);
          CustomWidgets.buildToast("${value.meta?.message}", Colors.green);
          log("PromoterToken: ${value. // LoginData
              accessToken?. // AccessToken
              accessToken. // Token
              toString()}");

          isButtonClicked = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (c) => const PromoterHome()),
            (route) => false);
      } else if(value.meta?.code == 400){
        CustomWidgets.buildToast("Account is not Active", Colors.red);
        log("PromoterErrorResponse: ${value.meta?.message.toString()}");
      } else {
        setState(() {
          isButtonClicked = false;
          CustomWidgets.buildToast("Invalid Inputs!", Colors.red);
        });
        log("PromoterErrorResponse: ${value.meta?.message.toString()}");
      }
    });
  }

  passwordValidation() =>
      (val) => val!.isEmpty ? "Password Can't Be Empty" : null;

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
                    child: InternationalPhoneNumberInput(
                      inputDecoration: authInputFormatting.copyWith(
                          hintText: "Phone Number",
                          hintStyle: const TextStyle(color: Colors.black26)),
                      onInputChanged: (PhoneNumber value) {
                        log("PhoneNumber: ${value.isoCode}");
                      },
                      locale: 'SA',
                      keyboardType: TextInputType.phone,
                      initialValue: initCountryIsoCode,
                      validator: (val) =>
                          val!.isEmpty ? "Phone Can't Be Empty" : null,
                      textFieldController: phoneController,
                      hintText: "Phone Number",
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[300]!))),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: authInputFormatting.copyWith(
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.black26)),
                      validator: passwordValidation(),
                      controller: passwordController,
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
                                log("PhoneNum: ${phoneController.text}");
                                log("IsPassValid: ${passwordController.text}");
                              });
                              login(context);
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
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => const PromoterRegister()));
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
                          "Register",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
