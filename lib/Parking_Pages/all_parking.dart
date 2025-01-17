import 'package:flutter/material.dart';
import 'package:buildingapp/Parking_Pages/yellow_parking.dart';
import 'package:buildingapp/Parking_Pages/orange_parking.dart';
import 'package:buildingapp/Parking_Pages/red_parking.dart';

class AllParkingSpotsPage extends StatelessWidget {
  const AllParkingSpotsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Four tabs: Yellow, Red, Orange, and Guests/Handicap
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Parking Spots'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.local_parking, color: Colors.yellow),
                text: 'Yellow',
              ),
              Tab(
                icon: Icon(Icons.local_parking, color: Colors.red),
                text: 'Red',
              ),
              Tab(
                icon: Icon(Icons.local_parking, color: Colors.orange),
                text: 'Orange',
              ),
              Tab(
                icon: Icon(Icons.accessible, color: Colors.blue),
                text: 'Guests/Handicap',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            YellowParkingPage(), // Reuse your Yellow parking page
            RedParkingPage(),    // Reuse your Red parking page
            OrangeParkingPage(), // Reuse your Orange parking page
            GuestsHandicapParkingPage(), // New Guests/Handicap parking page
          ],
        ),
      ),
    );
  }
}

class GuestsHandicapParkingPage extends StatelessWidget {
  const GuestsHandicapParkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> parkingLots = [
      {
        'name': 'Guest Parking',
        'description': 'Designated parking for campus visitors.',
        'maxSpots': 145,
        'openSpots': 33,
      },
      {
        'name': 'Handicap Parking',
        'description': 'Reserved parking for individuals with accessibility needs.',
        'maxSpots': 100,
        'openSpots': 27,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Guest/Handicap Parking',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.accessible, size: 30, color: Colors.blue),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: parkingLots.length,
            itemBuilder: (context, index) {
              final lot = parkingLots[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(
                    lot['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(lot['description']),
                  trailing: Text(
                    "${lot['openSpots']}/${lot['maxSpots']} open",
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
