import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

double getHeight(context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(context) {
  return MediaQuery.of(context).size.width;
}

TextEditingController phone = TextEditingController();
final TextEditingController pinPutController = TextEditingController();
final FocusNode pinPutFocusNode = FocusNode();

BoxDecoration get pinPutDecoration {
  return BoxDecoration(
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(5.0),
  );
}
