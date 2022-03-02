import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter_app/data/routes/route.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/bottom_tab.dart';
import 'package:simple_flutter_app/presentation/pages/main_pages/dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: Text(
                "LOGIN",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              decoration: BoxDecoration(color: Colors.white),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
              child: Column(
            children: [
              SizedBox(
                child: TextField(
                  decoration: InputDecoration(hintText: "email"),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                child: TextField(
                  decoration: InputDecoration(hintText: "password"),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ],
          )),
          SizedBox(
            child: ElevatedButton(
              onPressed: () => {Navigator.pushNamed(context, Routes.dashboard)},
              child: Text("Login"),
            ),
            width: MediaQuery.of(context).size.width * 0.9,
          )
        ],
      ),
    );
  }
}
