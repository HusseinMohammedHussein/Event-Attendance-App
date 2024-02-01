import 'dart:developer';
import 'package:business_umbrella/network/event_api_service.dart';
import 'package:business_umbrella/pages/auth/new_password.dart';
import 'package:business_umbrella/utils/shared_prefrences.dart';
import 'package:business_umbrella/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  var isPhoneValied = false;
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
    await eventService.login(context, phoneController.text).then((value) {
      if (value.meta?.code == 200) {
        // todo: when response success show password input else show active account btn
        isPhoneValied = true;
        // todo: when set new password input redirect to login

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
          isPhoneValied = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("${value.meta?.message}")));
        });
        log("PromoterErrorResponse: ${value.meta?.message.toString()}");
      }
    });
  }

  loginBySharedPref(String phone) {
    log("LoginPhoneControl: ${phoneController.text}");
    log("LoginPhoneInput: $phone");
    log("LoginPassControl: ${passwordController.text}");

    // var phoneRes = eventService.loginPhoneBySharedPref(phone);
    var phoneRes = "01122334455";
    setState(() {
      if (phone == phoneRes) {
        isPhoneValied = true;
      } else {
        isPhoneValied = false;
      }
    });
  }

  checkPassword(String pass) {
    log("LoginPassInput: $pass");
    log("LoginPassword: ${passwordController.text}");
    var getPassword = PreferenceUtils.getString(Utils.CHECK_New_Password);
    log("LoginPasswordPreff: $getPassword");
    setState(() {
      log("getPassInput: $pass");
      if (pass.isNotEmpty) {
        // var passRes = eventService.loginPassBySharedPref(pass);
        var passRes = "1234";
        if (pass == passRes) {
          isPassValid = true;
        } else {
          isPassValid = false;
        }
      }
    });
  }

  String passwordValidate(input) {
    var response;
    var getPass = PreferenceUtils.getString(Utils.CHECK_New_Password);
    log("GetNewPassword: $getPass");
    log("LoginPassword: ${passwordController.text}");

    if (input != null && input != "" && input == getPass) {
      response = "";
    } else {
      response = "password is not valid!";
    }
    return response;
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
                      onInputChanged: (PhoneNumber value) {
                        log("PhoneNumber: ${value.isoCode}");
                      },
                      locale: 'SA',
                      countrySelectorScrollControlled: true,
                      // autoFocus: true,
                      keyboardType: TextInputType.phone,
                      initialValue: initCountryIsoCode,
                      validator: (val) =>
                          val!.isEmpty ? "Phone Can't Be Empty" : null,
                      textFieldController: phoneController,
                    ),
                  ),
                  isButtonClicked
                      ? isPhoneValied
                          ? Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[300]!))),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: authInputFormatting.copyWith(
                                    hintText: "Password",
                                    hintStyle:
                                        const TextStyle(color: Colors.black26)),
                                validator: (val) => passwordValidate(val),
                                controller: passwordController,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) =>
                                                const NewPassword()));
                                  });
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
                                    "Active Your Account",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                            )
                      : Container(),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: /*isButtonClicked
                      ? Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.green,
                          ),
                          child: spinKit)
                      : */

                      isPhoneValied
                          ? GestureDetector(
                              onTap: () {
                                // if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isButtonClicked = true;
                                    log("PhoneNum: ${phoneController.text}");
                                    log("IsPhoneValid: $isPhoneValied");
                                    log("IsPassValid: ${passwordController.text}");

                                    if (passwordController.text.isNotEmpty) {
                                      checkPassword(passwordController.text);

                                      if (isPassValid) {
                                        Fluttertoast.showToast(
                                            msg: "Login Success",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.green,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (c) => const PromoterHome()));
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Verify you account",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    }
                                  });
                                  // login(context);
                                // }
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
                            )
                          : GestureDetector(
                              onTap: () {
                                // if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isButtonClicked = true;
                                    log("PhoneNum: ${phoneController.text}");
                                    log("IsPhoneValid: $isPhoneValied");
                                    log("IsPassValid: ${passwordController.text}");

                                    if (phoneController.text.isNotEmpty) {
                                      loginBySharedPref(phoneController.text);
                                    }
                                  });
                                  // login(context);
                                // }
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
