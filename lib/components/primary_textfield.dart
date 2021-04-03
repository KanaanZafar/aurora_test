import 'package:flutter/material.dart';

class PrimaryTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool obscureText;
  final Function validator;

  PrimaryTextField(
      {@required this.textEditingController,
      @required this.hintText,
      this.obscureText = false,
      this.validator});

  @override
  _PrimaryTextFieldState createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Colors.white));

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        hintText: widget.hintText,
        border: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        errorBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        focusedErrorBorder: outlineInputBorder,
        errorStyle: TextStyle(color: Colors.white),
      ),
      obscureText: widget.obscureText,
      validator: widget.validator,
    );
  }
}
