import 'package:flutter/material.dart';
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
                  DefaultText(
                    text: "Available Locations",
                    size: 25.0,
                    weight: FontWeight.bold,
                    color: Constants.altColor,
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 20,
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
                              text: "Computer Science",
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
