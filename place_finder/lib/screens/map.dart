import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_finder/utils/constants.dart';
import 'package:place_finder/utils/defaultButton.dart';
import 'package:place_finder/utils/defaultText.dart';
import 'package:place_finder/utils/mapbox_handler.dart';

class MapPage extends StatefulWidget {
  final arguments;

  const MapPage(Object? this.arguments, {super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // final Completer<GoogleMapController> _controller = Completer();

  // List<LatLng> polylineCoordinates = [];

  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();

  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       Constants.googleAPiKey,
  //       PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //       PointLatLng(
  //           destinationLocation.latitude, destinationLocation.longitude));

  //   print(result.points);
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) => polylineCoordinates.add(
  //           LatLng(point.latitude, point.longitude),
  //         ));
  //   } else {
  //     print("result point is empty");
  //   }
  // }

  late String currentAddress;
  late CameraPosition _initialCameraPosition;
  LatLng currentLocation = Constants.getCurrentLocationFromSharedPref();
  late MapboxMapController controller;
  final List<CameraPosition> _kRouteEndPoints = [];
  late String distance;
  late Map geometry;

  @override
  void initState() {
    // getPolyPoints();
    _initialiseDirectionsResponse();

    _initialCameraPosition =
        CameraPosition(target: currentLocation, zoom: 14.0);

    if (widget.arguments['modifiedResponse'] != null) {
      for (String type in ['source', 'destination']) {
        _kRouteEndPoints.add(CameraPosition(
            target: Constants.getSourceDestLatLng(type), zoom: 15.0));
      }
    }

    super.initState();
  }

  _initialiseDirectionsResponse() {
    if (widget.arguments['modifiedResponse'] != null) {
      distance = (widget.arguments['modifiedResponse']['distance'] / 1000)
          .toStringAsFixed(1);
      // dropOffTime = getDropOffTime(widget.arguments['modifiedResponse']['duration']);
      geometry = widget.arguments['modifiedResponse']['geometry'];
    } else {
      distance = "";
      geometry = {};
    }
  }

  _addSourceAndLineLayer() async {
    // Create a polyLine between source and destination
    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "properties": <String, dynamic>{},
          "geometry": geometry,
        },
      ],
    };

    // Add new source and lineLayer
    await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller.addLineLayer(
      "fills",
      "lines",
      LineLayerProperties(
        lineColor: Colors.red.toHexStringRGB(),
        lineCap: "round",
        lineJoin: "round",
        lineWidth: 3,
      ),
    );
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async {
    for (int i = 0; i < _kRouteEndPoints.length; i++) {
      String iconImage = i == 0 ? 'circle' : 'square';
      await controller.addSymbol(
        SymbolOptions(
          geometry: _kRouteEndPoints[i].target,
          iconSize: 0.1,
          iconImage: "assets/images/$iconImage.png",
        ),
      );
    }
    _addSourceAndLineLayer();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        SizedBox(
          height: size.height,
          child: MapboxMap(
            initialCameraPosition: _initialCameraPosition,
            accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            onStyleLoadedCallback: _onStyleLoadedCallback,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
            minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
          ),
        ),
        Positioned(
            bottom: 0,
            child: SizedBox(
              width: size.width,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DefaultText(text: "From - To", size: 18.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10.0),
                      child: ListTile(
                        tileColor: Colors.grey[200],
                        title: DefaultText(
                          text: "Walking Distance: $distance km",
                          size: 18.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10.0, left: 10.0, bottom: 10.0),
                      child: SizedBox(
                        width: size.width,
                        child: DefaultButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/turnByturn');
                            },
                            text: "Start Movement",
                            textSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ]),
    ));
  }
}
