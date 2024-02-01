import 'package:business_umbrella/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OurGoals extends StatefulWidget {
  const OurGoals({super.key});

  @override
  State<OurGoals> createState() => _OurGoalsState();
}

class _OurGoalsState extends State<OurGoals> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              Utils.OUR_GOALS_TITLE,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(Utils.OUR_GOALS,
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
