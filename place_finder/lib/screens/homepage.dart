import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:place_finder/services/remote_service.dart';
import 'package:place_finder/utils/constants.dart';
import 'package:place_finder/utils/defaultButton.dart';
import 'package:place_finder/utils/defaultText.dart';
import 'package:place_finder/utils/defaultTextFormField.dart';
import 'package:place_finder/utils/mapbox_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = -1;
  late String destLat;
  late String destLng;

  _getRoute(double destinationLat, double destinationLng) async {
    LatLng sourceLatLng = Constants.getSourceDestLatLng('source');
    LatLng destinationLatLng = Constants.getSourceDestLatLng('destination',
        destinationLat: destinationLat, destinationLng: destinationLng);
    Map? modifiedResponse = await getDirectionsAPIResponse(
        sourceLatLng, destinationLatLng, context);

    print("object: $destinationLat");
    print("object: $destinationLng");
    // Navigator.popAndPushNamed(context, '/map',
    //     arguments: {'modifiedResponse': modifiedResponse});
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
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultText(
                        text: "Available Locations",
                        size: 25.0,
                        weight: FontWeight.bold,
                        color: Constants.altColor,
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false);
                          },
                          icon: Icon(
                            Icons.power_settings_new,
                            color: Constants.altColor,
                            size: 30.0,
                          ))
                    ],
                  ),
                  Divider(
                    color: Constants.primaryColor,
                    thickness: 2.0,
                  ),
                  const SizedBox(height: 30.0),
                  const DefaultTextFormField(
                    obscureText: false,
                    maxLines: 1,
                    fontSize: 20.0,
                    icon: Icons.search,
                    hintText: "Search",
                    label: "Search",
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    width: size.width,
                    height: size.height / 1.5,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: FutureBuilder(
                      future: RemoteService.locationResponse(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isEmpty) {
                          DefaultText(
                            text: "No Locations",
                            color: Constants.primaryColor,
                          );
                        }
                        if (snapshot.hasData) {
                          var data = snapshot.data;
                          return ListView.builder(
                              itemCount: data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 5.0, left: 10.0, right: 10.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    color: Colors.white,
                                  ),
                                  child: ChoiceChip(
                                    label: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      width: size.width,
                                      child: DefaultText(
                                        align: TextAlign.center,
                                        text: snapshot.data![index]!.name,
                                        size: 22.0,
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    backgroundColor: Colors.white,
                                    selected: _selectedIndex == index,
                                    selectedColor: Constants.primaryColor,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        if (selected) {
                                          _selectedIndex = index;
                                          destLat =
                                              snapshot.data![index]!.latitude;
                                          destLng =
                                              snapshot.data![index]!.longitude;

                                          print(destLat);
                                          print(destLng);
                                        }
                                      });
                                    },
                                  ),
                                );
                              });
                        }

                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                      width: size.width,
                      child: DefaultButton(
                          onPressed: () {
                            print("selected index: $_selectedIndex");
                            print("Lat: $destLat\nLng: $destLng");
                            _getRoute(
                                double.parse(destLat), double.parse(destLng));
                            // Navigator.pushNamed(context, '/map');
                          },
                          text: "Route",
                          textSize: 25))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
