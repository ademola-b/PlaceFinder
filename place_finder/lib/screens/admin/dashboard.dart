import 'package:flutter/material.dart';
import 'package:place_finder/services/remote_service.dart';
import 'package:place_finder/utils/constants.dart';
import 'package:place_finder/utils/defaultButton.dart';
import 'package:place_finder/utils/defaultText.dart';
import 'package:place_finder/utils/defaultTextFormField.dart';

class AdHomePage extends StatefulWidget {
  const AdHomePage({super.key});

  @override
  State<AdHomePage> createState() => _AdHomePageState();
}

class _AdHomePageState extends State<AdHomePage> {
  int _selectedIndex = 1;

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
                                  onTap: () {
                                    // Navigator.pushNamed(context, '/studentDetails');
                                  },
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
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.amber,
                                          )),
                                      IconButton(
                                          onPressed: () {},
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
