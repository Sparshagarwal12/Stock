import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:messstock/screen/auth/login.dart';
import 'package:messstock/screen/auth/otpScreen.dart';
import 'package:messstock/screen/home.dart';

FirebaseAuth auth = FirebaseAuth.instance;
var forceResendToken;

class Firebase {
  static void phoneAuth(phone, isResend, context) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+91' + phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          log(value.toString());
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => HomeScreen()),
              (route) => false);
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        Navigator.pop(context);
        log(e.code.toString());
        if (e.code == 'invalid-phone-number') {
          Fluttertoast.showToast(
              msg: "The provided phone number is not valid.");
        } else {
          log(e.code.toString());

          Fluttertoast.showToast(msg: e.code.toString());
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        forceResendToken = resendToken;
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => LoginScreen(
                      isOTP: true,
                      code: resendToken,
                      verificationId: verificationId,
                      number: phone,
                    )));
      },
      forceResendingToken: isResend ? forceResendToken : null,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
