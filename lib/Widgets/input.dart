import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyInput extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  bool secret = false;
   MyInput({ Key? key, 
   required this.controller, 
   required this.hintText, 
   required this.secret }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: TextField(
        obscureText: secret,
        controller: controller,
        decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        ),
      ),
    );
  }
}