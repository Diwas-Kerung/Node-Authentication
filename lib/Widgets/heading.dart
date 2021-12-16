import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyHeading extends StatelessWidget {
  String text;
   MyHeading({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text, 
      style:const TextStyle(
        fontSize: 30, 
        fontWeight: FontWeight.bold),
      ),
    );
  }
}
