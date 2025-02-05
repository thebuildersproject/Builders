import 'package:flutter/material.dart';
import 'package:buildingapp/main.dart';
import 'package:buildingapp/Parking_Pages/map_Main.dart';

class ParkingCountPage extends StatefulWidget {
  final String parkingLotName;
  final int maxSpots;
  final int openSpots;

  const ParkingCountPage({
    super.key,
    required this.parkingLotName,
    required this.maxSpots,
    required this.openSpots,
  });

  @override
  State<ParkingCountPage> createState() => _ParkingCountPageState();
}

class _ParkingCountPageState extends State<ParkingCountPage> {
  late List<bool> spotStatus;

  @override
  void initState() {
    super.initState();
    _generateSpotStatus();
  }

  // Generate dynamic spot status for a 10-spot layout
  void _generateSpotStatus() {
    final int filledSpots = ((widget.maxSpots - widget.openSpots) / widget.maxSpots * 10).floor();
    spotStatus = List.generate(
      10,
          (index) => index < filledSpots, // Fill the first `filledSpots` slots
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // Removes the back arrow
        title: const Text(
          "Parking App",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Buttons at the top
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: 'Profile'),
                      ),
                          (route) => false,
                    );
                  },
                  icon: const Icon(Icons.person_outline),
                  label: const Text("Profile"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: 'Home'),
                      ),
                          (route) => false,
                    );
                  },
                  icon: const Icon(Icons.home),
                  label: const Text("Home"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(title: 'Parking'),
                      ),
                          (route) => false,
                    );
                  },
                  icon: const Icon(Icons.local_parking),
                  label: const Text("Parking"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Title with parking lot name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.parkingLotName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                const Icon(Icons.directions_car, size: 28),
              ],
            ),
          ),
          // Parking lot layout in scrollable view
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  // "C" shaped border
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.black, width: 3.0),
                        top: BorderSide(color: Colors.black, width: 3.0),
                        bottom: BorderSide(color: Colors.black, width: 3.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Left column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) {
                            return Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: spotStatus[index]
                                  ? Image.asset('lib/assets/car_icon.png')
                                  : const SizedBox(),
                            );
                          }),
                        ),
                        const SizedBox(width: 32.0), // Gap between columns
                        // Right column
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) {
                            return Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: spotStatus[index + 5]
                                  ? Image.asset('lib/assets/car_icon.png')
                                  : const SizedBox(),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  // Entry text
                  Positioned(
                    top: 8,
                    right: 16,
                    child: const Text(
                      "Entry",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Exit text
                  Positioned(
                    bottom: 8,
                    right: 16,
                    child: const Text(
                      "Exit",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Floating button at the bottom
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainParkingPage(parkingLotName:  widget.parkingLotName),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            minimumSize: const Size(double.infinity, 50), // Full-width button
          ),
          child: const Text(
            "Navigate to Main Map",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}