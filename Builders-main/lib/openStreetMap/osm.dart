import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';


class OsmWidget extends StatefulWidget{
  const OsmWidget({super.key});

  @override
  State<OsmWidget> createState() => OsmState();
}

class OsmState extends State<OsmWidget> {
  Set<GeoPoint> existingMarkers = {};
  final GeoPoint targetGeoPoint = GeoPoint(latitude: 35.296909, longitude: -93.140537); //parking spot one
  //parking lot tests
  //parking spot one - lat long {35.296909,-93.140537}
  //parking spot two - lat long {35.296886, -93.140533}


  @override
  void initState(){
    super.initState();
    //add object with no real state or various states. Ex.) UserLocation has various states.
    controller;
    locationSettings;
    _addParkingMarker();
    _removeParkingMarker();
  }


  MapController controller = MapController(
    initMapWithUserPosition: UserTrackingOption(
      enableTracking: true,
      unFollowUser: false,
    ),
  );


  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.bestForNavigation,
    distanceFilter: 0, //Minimum distance in meters the device must move before updating. The default is 0.
  );


  void _addParkingMarker() {
    Geolocator.getPositionStream().listen((Position p) async {
      // listens to userLocation. Then GeoPoint userLocation is written in latLong.
      GeoPoint userLocation = GeoPoint(latitude: p.latitude, longitude: p.longitude);
      // !=null so userLocation will always compare to targetGeoPoint (Parking spot 1)
      if (userLocation != null) {
        if ((userLocation.latitude - targetGeoPoint.latitude).abs() < 0.0001 &&
            (userLocation.longitude - targetGeoPoint.longitude).abs() <
                0.0001) {
          //find the absolute value. If the difference of userLocation - parkingSpotOne is below 0.0001, then add the marker.
          //change logic later to calculate the difference between multiple parking spots.
          //add marker at parking spot one
          await controller.addMarker(
            targetGeoPoint, // test parking spot one
            markerIcon: MarkerIcon(
              icon: Icon(
                Icons.directions_car,
                color: Colors.green,
                size: 48,
              ),
            ),
          );
        }
      }
    });
  }

  void _removeParkingMarker(){
    Geolocator.getPositionStream().listen((Position p) async{
      GeoPoint userLocation = GeoPoint(latitude: p.latitude, longitude: p.longitude);
      if(userLocation != targetGeoPoint){
        await controller.removeMarker(targetGeoPoint);
      }
    });
  }





  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:OSMFlutter(
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
      )
    );
  }


  //for custom tile layers
  /*customTile: CustomTile(
  sourceName: "openstreetmap",
  tileExtension: ".png",
  urlsServers: [
  TileURLs(url: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",)],
  tileSize: 256,
  ),*/


//add logic to make _addParkingMarker smaller
/*bool isLocationClose(GeoPoint location1, GeoPoint location2, {double threshold = 0.001}) {
  return (location1.latitude - location2.latitude).abs() < threshold &&
         (location1.longitude - location2.longitude).abs() < threshold;
}*/

//controls for when location access is not allowed
  /*MapController controller = MapController(
      initPosition: GeoPoint(
        //35.293946396262506, -93.13533181225705 for center of AR tech,
          latitude: 35.293946396262506, longitude: -93.13533181225705
      ),
      areaLimit: BoundingBox( //box around AR Tech
        east: -93.130850,
        north: 35.300852,
        south: 35.289077,
        west:  -93.141761
      ),
    );*/
}




