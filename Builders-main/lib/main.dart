import 'package:buildingapp/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:buildingapp/openStreetMap/osm.dart';


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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity,
          height: double.infinity,
        child: const OsmWidget(),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: _launchURL,
        tooltip: 'Add Route?',
        child: Icon(Icons.add_location_outlined),
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
