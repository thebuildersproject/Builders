import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

class OsmWidget extends StatefulWidget {
  const OsmWidget({super.key});

  @override
  State<OsmWidget> createState() => OsmState();
}

class OsmState extends State<OsmWidget> {
  MapController controller = MapController(
    initPosition: GeoPoint(
      latitude: 35.293946396262506, // Example starting coordinates (AR Tech)
      longitude: -93.13533181225705,
    ),
    areaLimit: BoundingBox( // Testing Box for parking lot
      north: 35.300852,
      south: 35.289077,
      east: -93.130850,
      west: -93.141761,
    ),
  );

  final BoundingBox parkingLotBounds = BoundingBox(
    north: 35.300852,
    south: 35.289077,
    east: -93.130850,
    west: -93.141761,
  );

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _addParkingLotMarkers();
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      await controller.enableTracking();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission is required to show your location")),
      );
    }
  }

  // Adds markers at the corners of the bounding box to represent the parking lot area
  Future<void> _addParkingLotMarkers() async {
    // Add markers for the corners
    await controller.addMarker(
      GeoPoint(latitude: 35.300852, longitude: -93.141761), // NW corner
      markerIcon: MarkerIcon(
        icon: Icon(
          Icons.location_on,
          color: Colors.blue,
          size: 48,
        ),
      ),
    );
    await controller.addMarker(
      GeoPoint(latitude: 35.300852, longitude: -93.130850), // NE corner
      markerIcon: MarkerIcon(
        icon: Icon(
          Icons.location_on,
          color: Colors.blue,
          size: 48,
        ),
      ),
    );
    await controller.addMarker(
      GeoPoint(latitude: 35.289077, longitude: -93.130850), // SE corner
      markerIcon: MarkerIcon(
        icon: Icon(
          Icons.location_on,
          color: Colors.blue,
          size: 48,
        ),
      ),
    );
    await controller.addMarker(
      GeoPoint(latitude: 35.289077, longitude: -93.141761), // SW corner
      markerIcon: MarkerIcon(
        icon: Icon(
          Icons.location_on,
          color: Colors.blue,
          size: 48,
        ),
      ),
    );

    // Listen for clicks on these markers
    controller.onGeoPointClicked.addListener(() async {
      GeoPoint? point = await controller.onGeoPointClicked.value;
      if (point != null) {
        _onMarkerTap(point);
      }
    });
  }

  // Callback function when a marker is tapped
  void _onMarkerTap(GeoPoint point) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Tapped marker at: ${point.latitude}, ${point.longitude}")),
    );
    // Additional actions can be added here, like showing details about the parking lot

  }

  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      controller: controller,
      osmOption: OSMOption(
        userTrackingOption: UserTrackingOption(
          enableTracking: true,
          unFollowUser: true,
        ),
        zoomOption: ZoomOption(
          initZoom: 18,
          minZoomLevel: 3,
          maxZoomLevel: 19,
          stepZoom: 1.0,
        ),
        userLocationMarker: UserLocationMaker(
          personMarker: MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.blue,
              size: 48,
            ),
          ),
          directionArrowMarker: MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 32,
              color: Colors.blue,
            ),
          ),
        ),
        roadConfiguration: RoadOption(
          roadColor: Colors.yellowAccent,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.onGeoPointClicked.removeListener(() {}); // Remove any listeners in dispose
    controller.dispose();
    super.dispose();
  }
}

extension on MapController {
  get onGeoPointClicked => null;
}
