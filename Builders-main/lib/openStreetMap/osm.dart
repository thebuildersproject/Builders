import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class OsmWidget extends StatefulWidget{
  const OsmWidget({super.key});

  @override
  State<OsmWidget> createState() => OsmState();
}

class OsmState extends State<OsmWidget> {
  //limitAreaMap - bounding the map cant exceed from it's bounding box

  /*@override
  void initState(){
    super.initState();
    controller;
  }*/

  Future<void> currentLocation() async {
    await controller.currentLocation();
  }

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.bestForNavigation,
    distanceFilter: 0, //Supply 0 when you want to be notified of all movements. The default is 0.
  );

  //parking lot tests
  //parking spot one - lat long {35.296909,-93.140537}
  //parking spot two - lat long {35.296886, -93.140533}
  Future<void> parkingMarker() async{
    await controller.addMarker(
        GeoPoint(
            latitude: 35.296909, longitude: -93.140537),
        markerIcon: MarkerIcon(
          icon: Icon(
            Icons.directions_car,
            color: Colors.green,
            size: 48,
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context){
    return OSMFlutter(
      controller: controller,
      osmOption: OSMOption(

        zoomOption: ZoomOption(
          initZoom: 18, //inital zoom
          stepZoom: 1.0, //how much in or out of the zoom
          minZoomLevel: 5, //min zoom
          maxZoomLevel: 19, //max zoom
        ),


        userLocationMarker: UserLocationMaker(
          personMarker: MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.red,
              size: 48,
            ),
          ),

          directionArrowMarker: MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
            ),
          ),
        ),

        roadConfiguration: RoadOption(
          roadColor: Colors.yellowAccent,
        ),
      ),
    );
  }

  MapController controller = MapController(
    initMapWithUserPosition: UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
  );

  //for custom tile layers
  /*customTile: CustomTile(
  sourceName: "openstreetmap",
  tileExtension: ".png",
  urlsServers: [
  TileURLs(url: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",)],
  tileSize: 256,
  ),*/

//controls for when location access is not allowed
  /*MapController controller = MapController(
      initPosition: GeoPoint(
        //35.293946396262506, -93.13533181225705 for center of AR tech,
          latitude: 35.293946396262506, longitude: -93.13533181225705
      ),
      areaLimit: BoundingBox(
        east: -93.130850,
        north: 35.300852,
        south: 35.289077,
        west:  -93.141761
      ),
    );*/
}


