import 'package:flutter/material.dart';

class AddWeightScreenStyles {
  inputFieldStyle({String labelText}) {
    return InputDecoration(
      labelText: labelText,
      hintStyle: TextStyle(
        color: Colors.grey[600],
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[300], width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[600], width: 0.0),
      ),
    );
  }
}
