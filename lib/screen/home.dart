import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messstock/screen/input_stock.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  (CupertinoPageRoute(builder: (context) => InputStock())));
            },
            child: Center(
              child: Container(
                height: 100,
                width: 180,
                decoration: BoxDecoration(color: Colors.pink),
                child: Center(child: Text("Input Stock")),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
