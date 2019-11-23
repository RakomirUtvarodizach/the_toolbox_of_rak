import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlue[200])),
    hintText: 'Doe',
    labelText: 'Last Name',
    labelStyle: TextStyle(color: Colors.black54),
    errorMaxLines: 2,
    errorStyle: TextStyle(fontSize: 16.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)));

var containerWhiteBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
          color: Colors.black12, offset: Offset(0.0, 15.0), blurRadius: 15.0),
      BoxShadow(
          color: Colors.black12, offset: Offset(0.0, -10.0), blurRadius: 10.0)
    ]);
