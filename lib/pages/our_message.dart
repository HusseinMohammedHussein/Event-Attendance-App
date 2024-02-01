import 'package:business_umbrella/utils/utils.dart';
import 'package:flutter/material.dart';

class OurMessage extends StatefulWidget {
  const OurMessage({super.key});

  @override
  State<OurMessage> createState() => _OurMessageState();
}

class _OurMessageState extends State<OurMessage> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(Utils.OUR_MESSAGE_TITLE,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            centerTitle: true),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(Utils.OUR_MESSAGE,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
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
