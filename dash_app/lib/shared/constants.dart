import 'package:dashapp/shared/Colors.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    //hintText: 'Password',
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.buttonColor, width: 2)));

// const addFloatingActionNew = FloatingActionButton(
//   //onPressed: () {},
//   backgroundColor: MyColors.lightBlue,
//   //Colors.blue[400],
//   child: Icon(
//     Icons.add,
//     size: 50,
//   ),
// );
