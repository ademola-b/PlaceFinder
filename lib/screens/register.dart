import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:place_finder/utils/constants.dart';
import 'package:place_finder/utils/defaultButton.dart';
import 'package:place_finder/utils/defaultText.dart';
import 'package:place_finder/utils/defaultTextFormField.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _form = GlobalKey<FormState>();

  late String? _name;
  late String? _email;
  late String? _password;
  late String? _confirmPassword;
  bool _obscureText = false;

  _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: Container(
          color: Constants.backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DefaultText(
                    size: 30.0,
                    text: "Registration",
                    color: Constants.primaryColor,
                  ),
                  const SizedBox(height: 30.0),
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: DefaultText(size: 18.0, text: "Name"),
                        ),
                        const SizedBox(height: 10.0),
                        DefaultTextFormField(
                          obscureText: false,
                          maxLines: 1,
                          fontSize: 20.0,
                          icon: Icons.person,
                          keyboardInputType: TextInputType.name,
                          validator: Constants.validator,
                          onSaved: (value) {
                            _name = value!;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: DefaultText(
                            size: 18.0,
                            text: "Email",
                            color: Constants.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        DefaultTextFormField(
                          obscureText: false,
                          maxLines: 1,
                          keyboardInputType: TextInputType.emailAddress,
                          fontSize: 20.0,
                          icon: Icons.email,
                          validator: Constants.validator,
                          onSaved: (value) {
                            _email = value!;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: DefaultText(size: 18.0, text: "Password"),
                        ),
                        const SizedBox(height: 10.0),
                        DefaultTextFormField(
                          fontSize: 20.0,
                          icon: Icons.password,
                          validator: Constants.validator,
                          keyboardInputType: TextInputType.visiblePassword,
                          obscureText: !_obscureText,
                          maxLines: 1,
                          suffixIcon: GestureDetector(
                            onTap: _toggle,
                            child: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child:
                              DefaultText(size: 18.0, text: "Confirm Password"),
                        ),
                        const SizedBox(height: 10.0),
                        DefaultTextFormField(
                          fontSize: 20.0,
                          icon: Icons.password,
                          validator: Constants.validator,
                          keyboardInputType: TextInputType.visiblePassword,
                          obscureText: !_obscureText,
                          maxLines: 1,
                          suffixIcon: GestureDetector(
                            onTap: _toggle,
                            child: Icon(_obscureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          onSaved: (value) {
                            _confirmPassword = value!;
                          },
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: size.width,
                          child: DefaultButton(
                            onPressed: () {},
                            text: 'Register',
                            textSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const DefaultText(
                              size: 18.0,
                              text: "Already have an account? ",
                              weight: FontWeight.normal,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: DefaultText(
                                size: 18.0,
                                color: Constants.primaryColor,
                                text: "Login",
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
