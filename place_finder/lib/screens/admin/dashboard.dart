import 'package:flutter/material.dart';
import 'package:place_finder/main.dart';
import 'package:place_finder/services/remote_service.dart';
import 'package:place_finder/utils/constants.dart';
import 'package:place_finder/utils/defaultButton.dart';
import 'package:place_finder/utils/defaultText.dart';
import 'package:place_finder/utils/defaultTextFormField.dart';
import 'package:http/http.dart' as http;

class AdHomePage extends StatefulWidget {
  const AdHomePage({super.key});

  @override
  State<AdHomePage> createState() => _AdHomePageState();
}

class _AdHomePageState extends State<AdHomePage> {
  _deleteLocation(String id) async {
    await RemoteService.deleteLocation(context, id);
    await RemoteService.locationResponse(context);

    Navigator.pop(context);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            DefaultText(text: "Location successfully deleted!", size: 18.0)));
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
                            sharedPreferences.clear();
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
                  SizedBox(
                    height: size.height,
                    child: FutureBuilder(
                      future: RemoteService.locationResponse(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isEmpty) {
                          return DefaultText(
                            text: "No Location",
                            size: 25.0,
                            color: Constants.altColor,
                          );
                        } else if (snapshot.hasData) {
                          var data = snapshot.data;
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  color: Colors.white,
                                ),
                                child: ListTile(
                                  onTap: () {},
                                  title: DefaultText(
                                    size: 18,
                                    text: snapshot.data![index]!.name,
                                    color: Constants.primaryColor,
                                    weight: FontWeight.w500,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/updateLocation',
                                                arguments: {
                                                  'id': snapshot
                                                      .data![index]!.locationId,
                                                  'name': snapshot
                                                      .data![index]!.name,
                                                  'latitude': snapshot
                                                      .data![index]!.latitude,
                                                  'longitude': snapshot
                                                      .data![index]!.longitude
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.amber,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            Constants.dialogBox(
                                                context,
                                                "Are you sure you want to delete ${snapshot.data![index]!.name} location?",
                                                Colors.white,
                                                Constants.altColor,
                                                Icons.info_outline,
                                                buttonText: "Delete",
                                                buttonAction: () async {
                                              _deleteLocation(snapshot
                                                  .data![index]!.locationId);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Constants.altColor,
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.altColor,
          onPressed: () {
            Navigator.pushNamed(context, '/addLocation');
          },
          child: const DefaultText(text: "+", size: 30.0),
        ),
      ),
    );
  }
}
