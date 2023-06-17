import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:place_finder/models/login_response.dart';
import 'package:place_finder/models/register_response.dart';
import 'package:place_finder/models/user_response.dart';
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: DefaultText(text: "An error occured: $e")));
    }
    return null;
  }

  static Future<LoginResponse?> login(
      String username, String password, context) async {
    try {
      Response response = await http.post(loginUrl, body: {
        'username': username,
        'password': password,
      });

      var data = jsonDecode(response.body);
      print("object: okay");
      if (data != null) {
        if (data["key"] != null) {
          // get user details
          UserDetailsResponse? _userDetails =
              await RemoteService.userResponse(data['key'], context);
          if (_userDetails != null) {
            if (_userDetails.isStaff) {
              Navigator.popAndPushNamed(context, '/adHomePage');
            } else {
              Navigator.popAndPushNamed(context, '/homePage');
            }
          }
        }
        if (data["non_field_errors"] != null) {
          for (var element in data["non_field_errors"]) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: DefaultText(text: "$element")));
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: DefaultText(text: "An error occured: $e")));
    }

    return null;
  }

  static Future<UserDetailsResponse?> userResponse(
      String token, context) async {
    try {
      var response =
          await http.get(userUrl, headers: {"Authorization": "Token $token"});
      if (response.statusCode == 200) {
        return userDetailsResponseFromJson(response.body);
      } else {
        throw Exception('Failed to get user details');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: DefaultText(text: "An error occured: $e")));
    }

    return null;
  }
}
