import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    //required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.grey,
          width: 2,
        )),
       // hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color.fromARGB(100, 14, 13, 13),
        ),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.blueGrey,
              )
            : null);
  }
}
