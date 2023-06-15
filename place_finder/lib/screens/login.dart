import 'package:flutter/material.dart';

import 'package:place_finder/utils/constants.dart';
import 'package:place_finder/utils/defaultButton.dart';
import 'package:place_finder/utils/defaultText.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form = GlobalKey<FormState>();
  late String _username;
  late String _password;
  bool _obscureText = false;

  _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  _login() {
    var isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();

    Navigator.popAndPushNamed(context, '/homePage');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("assets/images/logo.png", width: 200, height: 200),
                Form(
                  key: _form,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: DefaultText(
                          size: 20.0,
                          text: "Email",
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        style: const TextStyle(fontSize: 22.0),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username is required";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value!;
                        },
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: const UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.person),
                          prefixIconColor: Constants.primaryColor,
                          // hintText: "Username",
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: DefaultText(
                          size: 20.0,
                          text: "Password",
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        obscureText: !_obscureText,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          enabledBorder: const UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.lock),
                          prefixIconColor: Constants.primaryColor,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                _toggle();
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility)),
                          // hintText: "Password",
                        ),
                        style: const TextStyle(
                          fontSize: 22.0,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const DefaultText(
                              text: 'Forgot Password?',
                              size: 20,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: size.width,
                        child: DefaultButton(
                          onPressed: () {
                            _login();
                          },
                          text: 'Login',
                          textSize: 22.0,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const DefaultText(
                            size: 18.0,
                            text: "Don't have an account? ",
                            weight: FontWeight.normal,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: DefaultText(
                                size: 18.0,
                                color: Constants.primaryColor,
                                text: "Register Now",
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
