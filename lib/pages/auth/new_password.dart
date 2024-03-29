import 'dart:developer';
import 'package:business_umbrella/network/event_api_service.dart';
import 'package:business_umbrella/pages/promoter/PromoterLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  late Size size;
  var eventService = EventApiService();
  var passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isButtonClicked = false;

  final spinKit = const SpinKitPouringHourGlassRefined(
    color: Colors.white,
    size: 50.0,
  );

  var authInputFormatting = const InputDecoration(
    fillColor: Colors.white,
    filled: true,
    border: InputBorder.none,
  );

  newPasswordService() {
    log("new_password: ${passwordController.text}");
    var response = eventService.setNewPassword(passwordController.text);
    isButtonClicked = true;
    Future.delayed(const Duration(milliseconds: 2000)).then((value) {
      log("DurationFinish: $value");
      log("Response: $response");
      setState(() {
        if (response) {
          isButtonClicked = false;
          Fluttertoast.showToast(
              msg: "Set New Password Success",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const PromoterLogin()));
        } else {
          isButtonClicked = false;
          Fluttertoast.showToast(
              msg: "Set Correct Password",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    log("isBtnClicked: $isButtonClicked");
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
                'New Password',
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
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[300]!))),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: passwordController,
                        decoration: authInputFormatting.copyWith(
                            hintText: "New Password",
                            hintStyle: const TextStyle(color: Colors.black26)),
                        validator: (val) =>
                            val!.isEmpty ? "password Can't Be Empty" : null,
                      ),
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
                              newPasswordService();
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
