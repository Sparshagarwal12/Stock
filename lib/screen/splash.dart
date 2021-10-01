import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messstock/screen/home.dart';

import 'auth/login.dart';

class SplashScrn extends StatefulWidget {
  @override
  _SplashScrnState createState() => _SplashScrnState();
}

dynamic token;

class _SplashScrnState extends State<SplashScrn> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => check());
  }

  FirebaseAuth? auth = FirebaseAuth.instance;

  void check() {
    if (auth!.currentUser != null) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => HomeScreen()));
    } else {
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => LoginScreen(
                    isOTP: false,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("MITRC MESS"),
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
