import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:place_finder/utils/constants.dart';
import 'package:place_finder/utils/defaultButton.dart';
import 'package:place_finder/utils/defaultText.dart';
import 'package:place_finder/utils/defaultTextFormField.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({super.key});

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  final _form = GlobalKey<FormState>();

  late String? _lat;
  late String? _long;

  bool _obscureText = false;

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
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const SizedBox(width: 30.0),
                      DefaultText(
                        size: 25.0,
                        text: "Add Location",
                        color: Constants.primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DefaultButton(
                          onPressed: () {},
                          text: "Get Coordinates",
                          textSize: 18.0)
                    ],
                  ),
                  Form(
                    key: _form,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: DefaultText(size: 18.0, text: "Latitude"),
                          ),
                          const SizedBox(height: 10.0),
                          DefaultTextFormField(
                            obscureText: false,
                            maxLines: 1,
                            fontSize: 20.0,
                            icon: Icons.location_city,
                            keyboardInputType: TextInputType.text,
                            validator: Constants.validator,
                            onSaved: (value) {
                              _lat = value!;
                            },
                          ),
                          const SizedBox(height: 20.0),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: DefaultText(
                              size: 18.0,
                              text: "Longitude",
                              color: Constants.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          DefaultTextFormField(
                            obscureText: false,
                            maxLines: 1,
                            keyboardInputType: TextInputType.text,
                            fontSize: 20.0,
                            icon: Icons.email,
                            validator: Constants.validator,
                            onSaved: (value) {
                              _long = value!;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          SizedBox(
                            width: size.width,
                            child: DefaultButton(
                              onPressed: () {},
                              text: 'Add Location',
                              textSize: 20.0,
                            ),
                          ),
                        ],
                      ),
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
