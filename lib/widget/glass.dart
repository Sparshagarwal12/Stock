import 'dart:ui';

import 'package:flutter/material.dart';

Widget glass(height, width, child) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: Container(
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 7.0,
              sigmaY: 7.0,
            ),
            child: Container(width: width, height: height, child: Text(" ")),
          ),
          Opacity(
              opacity: 0.15,
              child: Image.asset(
                "assets/noise.png",
                fit: BoxFit.cover,
                width: width,
                height: height,
              )),
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 30,
                      offset: Offset(2, 2))
                ],
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    color: Colors.white.withOpacity(0.2), width: 1.0),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.1),
                    ],
                    stops: [
                      0.0,
                      1.0,
                    ])),
            child: child,
          ),
        ],
      ),
    ),
  );
}
