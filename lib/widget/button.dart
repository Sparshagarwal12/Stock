import 'package:flutter/material.dart';
import 'package:messstock/config/variable.dart';

Widget button(context, text) {
  return Padding(
    padding: EdgeInsets.only(
        left: getWidth(context) * 0.12, right: getWidth(context) * 0.12),
    child: Container(
      height: 45,
      width: getWidth(context),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.white, width: 2)),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            fontSize: getHeight(context) * 0.025,
            color: Colors.white,
            fontWeight: FontWeight.w600),
      )),
    ),
  );
}
