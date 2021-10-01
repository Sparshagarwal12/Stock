import 'package:flutter/material.dart';
import 'package:messstock/config/variable.dart';

Widget textField(context) {
  return Padding(
    padding: EdgeInsets.only(left: 20, right: 20),
    child: Container(
      height: getHeight(context) * 0.07,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        maxLength: 10,
        keyboardType: TextInputType.phone,
        controller: phone,
        decoration: InputDecoration(
          hintText: "Enter Phone Number",
          border: InputBorder.none,
          counterText: "",
          contentPadding: EdgeInsets.only(left: 10, top: 10),
        ),
      ),
    ),
  );
}
