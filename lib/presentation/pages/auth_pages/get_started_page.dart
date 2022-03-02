import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_flutter_app/data/routes/route.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/crypto2.png",
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.55,
          ),
          Flexible(
              child: Container(
            alignment: Alignment.center,
            child: Text(
              "Track your Crypto Currency portfolio in real-time",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 35),
              textAlign: TextAlign.center,
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                child: OutlinedButton.icon(
                  label: Text(
                    "Get Started",
                    style: TextStyle(color: Colors.blue),
                  ),
                  icon: Icon(Icons.arrow_forward_rounded),
                  onPressed: () =>
                      {Navigator.pushNamed(context, Routes.dashboard)},
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 1, color: Colors.blue)),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
              ),
              SizedBox(
                height: 100,
              ),
            ],
          )
        ],
      ),
    ));
  }
}
