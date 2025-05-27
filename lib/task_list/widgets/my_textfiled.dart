import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final controller;
  dynamic contentPanding;
  final String labelText;

  MyTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    this.contentPanding,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.text,
      controller: controller,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent),
        ),
        contentPadding: contentPanding,
        border: OutlineInputBorder(),
        hoverColor: Colors.deepPurple,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey[700]),
      ),
    );
  }
}
