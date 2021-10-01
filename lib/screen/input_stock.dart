import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messstock/screen/input_stock_form.dart';

class InputStock extends StatefulWidget {
  const InputStock({Key? key}) : super(key: key);

  @override
  _InputStockState createState() => _InputStockState();
}

class _InputStockState extends State<InputStock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => InputStockForm()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("mess")
              .doc("input")
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container(
              child: Column(
                children: [],
              ),
            );
          }),
    );
  }
}
