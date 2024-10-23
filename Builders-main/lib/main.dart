//import 'package:buildingapp/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:latlong2/latlong.dart';



void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Home page",), // Set HomePage from login_page.dart as the initial screen
    );
  }
}

// Keep the MyHomePage class for navigation purposes
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: content2(),

      floatingActionButton: FloatingActionButton(
        onPressed: _launchURL,
        tooltip: 'Add Route?',
        child: Icon(Icons.add_location_outlined),
      ),
    );
  }

  Widget content2(){ //version from a video for a test
    return FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(35.293946396262506, -93.13533181225705),
        initialZoom: 11,
        interactionOptions:
            const InteractionOptions(flags: ~InteractiveFlag.doubleTapDragZoom),
        ),
        children: [
          openStreetMapTilLayer,
        ]
    );
  }

  TileLayer get openStreetMapTilLayer => TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  );

  Widget content(){ //version from flutter page
    return OSMFlutter(
      controller: SimpleMapController(
          initPosition: GeoPoint(latitude: 35.293946396262506, longitude: -93.13533181225705 //35.293946396262506, -93.13533181225705 for AR tech,
          ),
          markerHome: const MarkerIcon(
            icon: Icon(Icons.home),
          ),
      ),
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
                   marker settings go here
                ),*/
      ),
    );
  }

}

Future<void> _launchURL() async{
  final Uri url=Uri.parse("https://www.atu.edu/map/docs/ATU-Campus-Map-2024.pdf");
  if(!await launchUrl(url)) {
    throw Exception('Could not load $url');
  }
}
