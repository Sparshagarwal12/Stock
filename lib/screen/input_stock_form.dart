import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messstock/config/variable.dart';
import 'package:messstock/widget/dropdown.dart';

class InputStockForm extends StatefulWidget {
  const InputStockForm({Key? key}) : super(key: key);

  @override
  _InputStockFormState createState() => _InputStockFormState();
}

class _InputStockFormState extends State<InputStockForm> {
  String _selectCategory = 'Please Select category';
  String _selectSubCategory = 'Please Select sub category';
  String _selectUnit = 'Please Select unit';
  late DateTime _selectedDate = DateTime.now();

  //Method for showing the date picker
  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("categories").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<String> categoryList = [];
            Map<String, dynamic> subCategory = {};
            // List<List<dynamic>> subCategory = [];
            // {
            //   "map";[
            //     "c"
            //   ]
            // }
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              categoryList.add(snapshot.data!.docs[i].get("category"));
              // subCategory.add(snapshot.data!.docs[i].get("subCategories"));
              subCategory.putIfAbsent(categoryList[i].toString(),
                  () => snapshot.data!.docs[i].get("subCategories"));
            }
            log(subCategory.toString());
            return Container(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Item Category"),
                      DropdownButton<String>(
                          underline: SizedBox(),
                          items: categoryList.map((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(growable: false),
                          hint: Text(_selectCategory),
                          onChanged: (newVal) {
                            print(newVal);
                            _selectCategory = newVal.toString();
                            setState(() {});
                          }),
                      // dropdown(categoryList, context, _selectCategory,
                      //     getHeight(context) * 0.06, getWidth(context) * 0.6)
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Item SubCategory"),
                      DropdownButton(
                          underline: SizedBox(),
                          items: subCategory["Dal"].map((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(val),
                            );
                          }).toList(growable: false),
                          hint: Text(_selectSubCategory),
                          onChanged: (newVal) {
                            print(newVal);
                            _selectSubCategory = newVal.toString();
                            setState(() {});
                          }),
                      // dropdown(
                      //     subCategoryList[_selectCategory],
                      //     context,
                      //     _selectSubCategory,
                      //     getHeight(context) * 0.1,
                      //     getWidth(context) * 0.6)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Enter Price"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 180,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(hintText: "Enter Quantity"),
                        ),
                      ),
                      // dropdown(
                      //     ['Please choose a location', 'A', 'B', 'C', 'D'],
                      //     context,
                      //     _selectUnit,
                      //     getHeight(context) * 0.1,
                      //     getWidth(context) * 0.5)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      _pickDateDialog();
                    },
                    child: Container(
                      color: Colors.pink,
                      child: Text("Date $_selectedDate"),
                    ),
                  )
                ],
              ),
            ));
          }),
    );
  }
}
