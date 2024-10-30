import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class OsmWidget extends StatefulWidget{
  const OsmWidget({super.key});

  @override
  State<OsmWidget> createState() => OsmState();
}

class OsmState extends State<OsmWidget> {

  MapController controller = MapController(
    initPosition: GeoPoint(
        latitude: 35.293946396262506, longitude: -93.13533181225705), //35.293946396262506, -93.13533181225705 for AR tech,
    areaLimit: BoundingBox(
      north: 35.300852,
      south: 35.289077,
      east: -93.130850,
      west:  -93.141761,
    ),
  );

  @override
  Widget build(BuildContext context){
    return OSMFlutter(
        controller: MapController(),
        osmOption: OSMOption(
            userTrackingOption: UserTrackingOption(
              enableTracking: true,
              unFollowUser: false,
            ),
            zoomOption: ZoomOption(
              initZoom: 8,
              minZoomLevel: 3,
              maxZoomLevel: 19,
              stepZoom: 1.0,
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
            /*markerOption: MarkerOption(
            //marker settings go here
        ),*/
    ),
    );
  }
}