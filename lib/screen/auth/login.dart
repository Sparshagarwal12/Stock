import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:messstock/config/firebase.dart';
import 'package:messstock/config/variable.dart';
import 'package:messstock/screen/home.dart';
import 'package:messstock/widget/button.dart';
import 'package:messstock/widget/glass.dart';
import 'package:messstock/widget/loader.dart';
import 'package:messstock/widget/textField.dart';
import 'package:pinput/pin_put/pin_put.dart';

class LoginScreen extends StatefulWidget {
  bool isOTP;
  dynamic code;
  dynamic verificationId;
  dynamic number;
  LoginScreen(
      {Key? key,
      required this.isOTP,
      this.code,
      this.verificationId,
      this.number})
      : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget widget2() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: PinPut(
        eachFieldHeight: 50.0,
        eachFieldWidth: 50.0,
        fieldsCount: 6,
        textStyle: TextStyle(fontSize: 30, color: Colors.white),
        onSubmit: (String pin) async {
          loader(context);
          log(pin);
          if (widget.code != null) {
            final PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: widget.verificationId.toString(), smsCode: pin);
            UserCredential userCredential = await FirebaseAuth.instance
                .signInWithCredential(credential)
                .whenComplete(() async {
              log(credential.toString());
              phone.clear();
              pin = "";
              setState(() {});
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            });

            Fluttertoast.showToast(msg: "Logged ");
          } else {
            Fluttertoast.showToast(msg: "Please Fill the OTP");
          }
        },
        focusNode: pinPutFocusNode,
        controller: pinPutController,
        submittedFieldDecoration: pinPutDecoration.copyWith(
          borderRadius: BorderRadius.circular(5.0),
        ),
        selectedFieldDecoration: pinPutDecoration,
        followingFieldDecoration: pinPutDecoration.copyWith(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String buttonText = widget.isOTP ? "Confirm" : "Login";

    return Scaffold(
      body: Container(
        height: getHeight(context),
        width: getWidth(context),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpeg'),
                fit: BoxFit.cover)),
        child: Center(
            child: glass(
                getHeight(context) * 0.4,
                getWidth(context) / 1.2,
                Column(
                  children: [
                    SizedBox(
                      height: getHeight(context) * 0.15,
                    ),
                    // textField(context),
                    widget.isOTP ? widget2() : textField(context),
                    SizedBox(
                      height: getHeight(context) * 0.05,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (phone.text.length == 10) {
                            loader(context);
                            Firebase.phoneAuth(phone.text, false, context);
                          } else
                            Fluttertoast.showToast(
                                msg: "Please Enter Correct Number");
                        },
                        child: button(context, buttonText)),
                    SizedBox(
                      height: getHeight(context) * 0.02,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Don't have Account? ",
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: getHeight(context) * 0.02),
                    //     ),
                    //     Text(
                    //       "Register",
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           decoration: TextDecoration.underline,
                    //           fontSize: getHeight(context) * 0.02),
                    //     )
                    //   ],
                    // )
                  ],
                ))),
      ),
    );
  }
}
