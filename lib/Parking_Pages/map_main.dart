import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainParkingPage extends StatefulWidget {
  final String parkingLotName;

  const MainParkingPage({super.key, required this.parkingLotName});

  @override
  _MainParkingPageState createState() => _MainParkingPageState();
}

class _MainParkingPageState extends State<MainParkingPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(35.2938, -93.1361); // Arkansas Tech University

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 15.0,
            ),
          ),
          // Bottom green bar with parking lot name and close button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.green[900],
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Parking lot name
                  Text(
                    widget.parkingLotName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Circular exit button
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Exit to the previous page
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
