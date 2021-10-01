import 'package:flutter/material.dart';

Widget dropdown(list, context, selectedLocation, height, width) {
  return StatefulBuilder(builder: (context, StateSetter setState) {
    return Container(
      width: width,
      child: DropdownButton<String>(
          underline: SizedBox(),
          items: list.map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val),
            );
          }).toList(growable: false),
          hint: Text(selectedLocation),
          onChanged: (newVal) {
            print(newVal);
            selectedLocation = newVal.toString();
            setState(() {});
          }),
    );
  });
}
