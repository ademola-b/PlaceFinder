import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:place_finder/utils/constants.dart';

class TurnByTurn extends StatefulWidget {
  const TurnByTurn({super.key});

  @override
  State<TurnByTurn> createState() => _TurnByTurnState();
}

class _TurnByTurnState extends State<TurnByTurn> {
  // Waypoints to mark source and destination
  LatLng source = Constants.getSourceDestLatLng('source');
  LatLng destination = Constants.getSourceDestLatLng('destination');
  late WayPoint sourceWaypoint, destinationWaypoint;
  var waypoints = <WayPoint>[];

  late MapBoxNavigation directions;
  late MapBoxOptions _options;
  late double distanceRemaining, durationRemaining;
  late MapBoxNavigationViewController _controller;

  final isMultipleStop = false;
  String instruction = "";
  bool arrived = false;
  bool routeBuilt = false;
  bool isNavigating = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    if (!mounted) return;

    // Setup directions and options
    directions = MapBoxNavigation(onRouteEvent: _onRouteEvent);
    _options = MapBoxOptions(
        zoom: 18.0,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        mode: MapBoxNavigationMode.walking,
        isOptimized: true,
        units: VoiceUnits.metric,
        simulateRoute: true,
        language: "en");

    // Configure Waypoints
    sourceWaypoint = WayPoint(
        name: "Source", latitude: source.latitude, longitude: source.longitude);
    destinationWaypoint = WayPoint(
        name: "Destination",
        latitude: destination.latitude,
        longitude: destination.longitude);
    waypoints.add(sourceWaypoint);
    waypoints.add(destinationWaypoint);

    // Start movement
    await directions.startNavigation(wayPoints: waypoints, options: _options);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // to be triggered when direction is set
  Future<void> _onRouteEvent(e) async {
    distanceRemaining = await directions.distanceRemaining;
    durationRemaining = await directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        arrived = progressEvent.arrived!;
        if (progressEvent.currentStepInstruction != null) {
          instruction = progressEvent.currentStepInstruction!;
        }
        break;

      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        routeBuilt = true;
        break;

      case MapBoxEvent.route_build_failed:
        routeBuilt = false;
        break;

      case MapBoxEvent.navigation_running:
        isNavigating = true;
        break;

      case MapBoxEvent.on_arrival:
        arrived = true;
        if (!isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller.finishNavigation();
        }
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        routeBuilt = false;
        isNavigating = false;
        break;

      default:
    }

    setState(() {});
  }
}
