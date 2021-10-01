import 'package:flutter/material.dart';
import 'package:messstock/config/variable.dart';

dynamic loader(context) {
  return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: getHeight(context) * 0.055,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
          ),
        );
      });
}
