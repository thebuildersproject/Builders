import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingPathPage extends StatefulWidget{
  const ParkingPathPage({super.key});

  @override
  State<ParkingPathPage> createState() =>ParkingPathPage();
}

class ParkingPathPageState extends State<ParkingPathPage>{
  final Completer<GoogleMapController>_controller=Completer();

  static const LatLng sourceLocation=LatLng(latitude, longitude);
  static const LatLng destination=LatLng(latitude, longitude);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Path to Parking",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: sourceLocation,
              zoom: 13.5
          ),
        markers: {
            const Marker(
                markerId: MarkerId("source"),
                position: sourceLocation
            ),
          const Marker(
              markerId: MarkerId("destination"),
              position: destination,
          ),
        },
      )
    );
  }
}