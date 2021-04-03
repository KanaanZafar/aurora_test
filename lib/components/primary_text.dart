import 'package:flutter/material.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final double fontSize;

  PrimaryText({@required this.text, this.fontSize = 15.0});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: fontSize),
    );
  }
}
