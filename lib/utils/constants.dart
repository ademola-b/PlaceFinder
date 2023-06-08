import 'package:flutter/material.dart';

class Constants {
  static final Color primaryColor = Color(0xFF2296f3);
  static final Color backgroundColor = Color(0xFFc5e5FF);
  static final Color altColor = Color.fromARGB(255, 199, 35, 90);

  static String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This Field is required";
    }
    return null;
  }
}
