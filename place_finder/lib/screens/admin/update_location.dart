// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:place_finder/models/location_creation_response.dart';
import 'package:place_finder/services/remote_service.dart';
import 'package:place_finder/utils/constants.dart';
import 'package:place_finder/utils/defaultButton.dart';
import 'package:place_finder/utils/defaultText.dart';
import 'package:place_finder/utils/defaultTextFormField.dart';

class UpdateLocation extends StatefulWidget {
  final arguments;
  const UpdateLocation(Object? this.arguments, {super.key});

  @override
  State<UpdateLocation> createState() => _UpdateLocationState();
}

class _UpdateLocationState extends State<UpdateLocation> {
  final _form = GlobalKey<FormState>();

  String? _name;
  String? _lat;
  String? _lng;

  TextEditingController name = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();

  @override
  void initState() {
    name.text = widget.arguments['name'];
    latitude.text = widget.arguments['latitude'];
    longitude.text = widget.arguments['longitude'];
  }

  _updateLocation(
      String id, String? name, String? latitude, String? longitude) async {
    var isValid = _form.currentState!.validate();
    if (!isValid) return;

    _form.currentState!.save();

    await RemoteService.updateLocation(context, id, name, latitude, longitude);

    await Constants.dialogBox(context, "Location Updated", Colors.white,
        Constants.primaryColor, Icons.check_circle_outline,
        buttonText: "Okay", buttonAction: () => Navigator.pop(context));
    Navigator.pop(context);
  }

  getCurrentLocation() async {
    Location _location = Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    // Get the current location
    LocationData _locationData = await _location.getLocation();

    setState(() {
      latitude.text = _locationData.latitude.toString();
      longitude.text = _locationData.longitude.toString();
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
                        text: "Update Location",
                        color: Constants.primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DefaultButton(
                          onPressed: () {
                            getCurrentLocation();
                          },
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
                            child: DefaultText(size: 18.0, text: "Name"),
                          ),
                          const SizedBox(height: 10.0),
                          DefaultTextFormField(
                            text: name,
                            obscureText: false,
                            maxLines: 1,
                            fontSize: 20.0,
                            icon: Icons.location_on,
                            keyboardInputType: TextInputType.text,
                            validator: Constants.validator,
                            onSaved: (value) {
                              _name = value!;
                            },
                          ),
                          const SizedBox(height: 20.0),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: DefaultText(size: 18.0, text: "Latitude"),
                          ),
                          const SizedBox(height: 10.0),
                          DefaultTextFormField(
                            text: latitude,
                            obscureText: false,
                            maxLines: 1,
                            fontSize: 20.0,
                            icon: Icons.location_on,
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
                            text: longitude,
                            obscureText: false,
                            maxLines: 1,
                            keyboardInputType: TextInputType.text,
                            fontSize: 20.0,
                            icon: Icons.location_on,
                            validator: Constants.validator,
                            onSaved: (value) {
                              _lng = value!;
                            },
                          ),
                          const SizedBox(height: 30.0),
                          SizedBox(
                            width: size.width,
                            child: DefaultButton(
                              onPressed: () {
                                _updateLocation(widget.arguments['id'],
                                    name.text, latitude.text, longitude.text);
                              },
                              text: 'Update Location',
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
