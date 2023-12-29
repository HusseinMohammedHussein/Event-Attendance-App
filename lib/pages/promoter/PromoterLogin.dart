import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PromoterLogin extends StatefulWidget {
  const PromoterLogin({super.key});

  @override
  State<PromoterLogin> createState() => _PromoterLoginState();
}

class _PromoterLoginState extends State<PromoterLogin> {
  late Size size;

  // Platform.localeName.split('_').last +966

  var phoneNum = "0500804349";
  PhoneNumber? number;

  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var authInputFormatting = const InputDecoration(
    fillColor: Colors.white,
    filled: true,
    border: InputBorder.none,
  );

  // String? phoneNum;

  @override
  void initState() {
    super.initState();
    initPhoneNum();
  }
  initPhoneNum() async {
    // number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNum);
    number = PhoneNumber(isoCode: Platform.localeName.split('_').last);
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
                        log("PhoneNumber: ${value.phoneNumber}");
                      },
                      countrySelectorScrollControlled: false,
                      autoFocus: true,
                      keyboardType: TextInputType.phone,
                      initialValue: number,
                      textFieldController: phoneController,
                    ), /*TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration:
                          authInputFormatting.copyWith(hintText: "Phone", hintStyle: const TextStyle(color: Colors.black26)),
                          validator: (val) =>
                          val!.isEmpty ? "Phone Can't Be Empty" : null,
                          onChanged: (val) {
                            phoneNum = val;
                          },
                        ),*/
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
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, '/home');
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
