import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:place_finder/models/register_response.dart';
import 'package:place_finder/services/urls.dart';
import 'package:place_finder/utils/defaultText.dart';

class RemoteService {
  static Future<RegisterResponse?> register(
      String name, String email, String password, context) async {
    try {
      var response = await http.post(registerUrl,
          body: {'name': name, 'email': email, 'password': password});
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                DefaultText(text: "Account Created Successfully! Login Now.")));
        Navigator.popAndPushNamed(context, '/login');
      } else {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (responseBody['email'] != null) {
          for (var element in responseBody['email']) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: DefaultText(text: "$element")));
          }
        } else if (responseBody['name'] != null) {
          for (var element in responseBody['name']) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: DefaultText(text: "$element")));
          }
        } else if (responseBody['password'] != null) {
          for (var element in responseBody['password']) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: DefaultText(text: "$element")));
          }
        }

        return registerResponseFromJson(response.body);
      }
    } catch (e) {}
  }
}
