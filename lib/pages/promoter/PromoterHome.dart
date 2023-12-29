import 'package:business_umbrella/pages/our_goals.dart';
import 'package:business_umbrella/pages/our_message.dart';
import 'package:business_umbrella/widgets/custom_widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:business_umbrella/pages/promoter/PromoterScanQR.dart';
import 'package:flutter/material.dart';

class PromoterHome extends StatefulWidget {

  const PromoterHome({super.key});

  @override
  State<PromoterHome> createState() => _PromoterHomeState();
}

class _PromoterHomeState extends State<PromoterHome> {
  late Size size;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  Map _status = {
    'index': null,
    'action': null,
  };

  var authInputFormatting = const InputDecoration(
    fillColor: Colors.white,
    filled: true,
    border: InputBorder.none,
  );

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () async {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        const Text(
          'INTERNATIONAL E-COMMERCE EXPO',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _cards() {
    return Column(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: ListTile(
            title: const Text("Update Name"),
            trailing: const Icon(Icons.edit),
            subtitle: _status['index'] == 0
                ? Text(
                    _status['status'],
                    style: TextStyle(
                        color: _status['error'] ? Colors.red : Colors.green),
                  )
                : const Text("Update Your Display Name"),
            onTap: () {
              setState(() {
                _status = {
                  'index': null,
                  'action': 0,
                };
              });
            },
          ),
        ),
        // _status['action'] == 0 ? changeNameForm() : Container(),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: ListTile(
            title: const Text("Update Email"),
            trailing: const Icon(Icons.email),
            subtitle: _status['index'] == 1
                ? Text(
                    _status['status'],
                    style: TextStyle(
                        color: _status['error'] ? Colors.red : Colors.green),
                  )
                : const Text("Update Your Current Email"),
            onTap: () {},
          ),
        ),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: ListTile(
            title: const Text("Update Password"),
            trailing: const Icon(Icons.lock_outline),
            subtitle: _status['index'] == 2
                ? Text(
                    _status['status'],
                    style: TextStyle(
                        color: _status['error'] ? Colors.red : Colors.green),
                  )
                : const Text("Update Your Password"),
            onTap: () {
              setState(() {
                _status = {
                  'index': null,
                  'action': 2,
                };
              });
            },
          ),
        ),
        // _status['action'] == 0 ? changePasswordForm() : Container(),
      ],
    );
  }

  Widget _scanQrButton() {
    return Column(
      children: [
        const Text(
          'Scan Now',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Please Scan a visitor QR',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black38, fontSize: 15),
        ),
        Container(
          width: size.width * 0.44,
          height: size.height * 0.19,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0)
              ],
              gradient: LinearGradient(
                  begin: Alignment(0.5, 0),
                  end: Alignment(0.5, 1.907269636960704),
                  colors: [Colors.green, Colors.greenAccent])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/pay_now_qr_code.png',
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Scan QR Code',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ],
    );
  }

  Widget changeNameForm() {
    String firstName;
    String lastName;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 45, 0, 5),
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
                            bottom: BorderSide(color: Colors.grey[200]!))),
                    child: TextFormField(
                      decoration:
                          authInputFormatting.copyWith(hintText: "First Name"),
                      validator: (val) =>
                          val!.isEmpty ? "First Name Can't Be Empty" : null,
                      onChanged: (val) {
                        firstName = val;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!))),
                    child: TextFormField(
                      decoration:
                          authInputFormatting.copyWith(hintText: "Last Name"),
                      validator: (val) =>
                          val!.isEmpty ? "Last Name Can't Be Empty" : null,
                      onChanged: (val) {
                        lastName = val;
                      },
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
                  child: GestureDetector(
                    onTap: () async {},
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.cyan,
                      ),
                      child: const Center(
                        child: Text(
                          "Update",
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
                      setState(() {
                        _status = {
                          'index': null,
                          'action': null,
                        };
                      });
                    },
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.cyan[200],
                      ),
                      child: const Center(
                        child: Text(
                          "Cancel",
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

  Widget changePasswordForm() {
    String newPass;
    String oldPass;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 45, 0, 5),
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
                            bottom: BorderSide(color: Colors.grey[200]!))),
                    child: TextFormField(
                      decoration: authInputFormatting.copyWith(
                          hintText: "Old Password"),
                      // validator: User().validateRegisterPass,
                      obscureText: true,
                      onChanged: (val) {
                        oldPass = val;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!))),
                    child: TextFormField(
                      decoration: authInputFormatting.copyWith(
                          hintText: "New Password"),
                      // validator: User().validateRegisterPass,
                      obscureText: true,
                      onChanged: (val) {
                        newPass = val;
                      },
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
                  child: GestureDetector(
                    onTap: () async {},
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.cyan,
                      ),
                      child: const Center(
                        child: Text(
                          "Update",
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
                      setState(() {
                        _status = {
                          'index': null,
                          'action': null,
                        };
                      });
                    },
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.cyan[200],
                      ),
                      child: const Center(
                        child: Text(
                          "Cancel",
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

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.green,
      drawer: _buildDrawer(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, size.height * 0.07, 25, 0),
            child: _appBar(),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, size.height * 0.04, 0, 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: SingleChildScrollView(
                physics:  const PageScrollPhysics(),
                child: Column(
                  children: [
                  const SizedBox(
                    height: 20,
                  ),
                    _cards(),
                    const SizedBox(
                      height: 60,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const PromoterScanQR()));
                      },
                      child: _scanQrButton(),
                    ),
                    SizedBox(
                      height: 0,
                    ),
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(top: size.height * 0.1),
                          child: const Text(
                            'Powered by Business Umbrella',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black38, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.black),
                child: DrawerHeader(
                  padding: const EdgeInsets.all(0),
                  child: Image.asset("lib/assets/IEC.png",
                      width: 400, height: 400, alignment: Alignment.center),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Row(
                        children: <Widget>[
                          Icon(Icons.home, color: Colors.green, size: 20),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Home',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black38, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c) => OurMessage()));
                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset("lib/assets/messages.png",
                              color: Colors.green, width: 20, height: 20),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Our Message',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black38, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (c) => OurGoals()));
                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset("lib/assets/goal.png",
                              color: Colors.green, width: 20, height: 20),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Our Goals',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black38, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/prologin');
                      },
                      child: Row(
                        children: <Widget>[
                          Image.asset("lib/assets/logout.png",
                              color: Colors.green, width: 20, height: 20),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Logout',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black38, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(top: size.height * 0.3),
                      child: const Text(
                        'Powered by Business Umbrella',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black38, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
