import 'package:flutter/material.dart';
import 'package:buildingapp/Parking_Pages/parking_count.dart';

class YellowParkingPage extends StatefulWidget {
  const YellowParkingPage({super.key});

  @override
  State<YellowParkingPage> createState() => _YellowParkingPageState();
}

class _YellowParkingPageState extends State<YellowParkingPage> {
  // Parking lot data
  final Map<String, List<Map<String, dynamic>>> parkingData = {
    'Brown': [
      {
        'name': 'Parking Lot A',
        'description': '',
        'maxSpots': 40,
        'openSpots': 20,
      },
      {
        'name': 'Parking Lot B',
        'description': '',
        'maxSpots': 15,
        'openSpots': 7,
      },
    ],
    'Corely': [
      {
        'name': 'Parking Lot A',
        'description': 'First parking lot of Corely',
        'maxSpots': 100,
        'openSpots': 45,
      },
      {
        'name': 'Parking Lot B',
        'description': 'Second parking lot of Corely',
        'maxSpots': 80,
        'openSpots': 20,
      },
    ],
    'Colosseum': [
      {
        'name': 'Parking Lot A',
        'description': '',
        'maxSpots': 50,
        'openSpots': 30,
      },
      {
        'name': 'Parking Lot B',
        'description': '',
        'maxSpots': 35,
        'openSpots': 25,
      },
    ],
    'Rothwell': [
      {
        'name': 'Parking Lot A',
        'description': 'In front of Rothwell',
        'maxSpots': 200,
        'openSpots': 22,
      },
      {
        'name': 'Parking Lot B',
        'description': 'Beside pasture',
        'maxSpots': 20,
        'openSpots': 0,
      },
    ],
  };

  // Current selected section
  String _selectedSection = 'Brown';

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> selectedLots = parkingData[_selectedSection]!;

    return Column(
      children: [
        // Title with an icon
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Commuter Parking',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8.0),
              const Icon(Icons.directions_car, size: 28),
            ],
          ),
        ),
        // Dropdown to filter sections
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DropdownButton<String>(
            value: _selectedSection,
            onChanged: (value) {
              setState(() {
                _selectedSection = value!;
              });
            },
            isExpanded: true,
            items: parkingData.keys.map((section) {
              return DropdownMenuItem(
                value: section,
                child: Text(
                  section,
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }).toList(),
          ),
        ),
        // Parking lot list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: selectedLots.length,
            itemBuilder: (context, index) {
              final lot = selectedLots[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(
                    lot['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: lot['description'].isNotEmpty
                      ? Text(lot['description'])
                      : null,
                  trailing: Text(
                    "${lot['openSpots']}/${lot['maxSpots']} open",
                    style: const TextStyle(color: Colors.green),
                  ),
                  onTap: () {
                    // Show dialog on tap
                    _showNavigateDialog(
                      context,
                      lot['name'],
                      lot['maxSpots'],
                      lot['openSpots'],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Function to show the navigate dialog
  void _showNavigateDialog(
      BuildContext context,
      String parkingLotName,
      int maxSpots,
      int openSpots,
      ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Close dialog
                  },
                  child: const Icon(Icons.close, size: 24),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Navigate to $parkingLotName?',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParkingCountPage(
                        parkingLotName: parkingLotName,
                        maxSpots: maxSpots,
                        openSpots: openSpots,
                      ),
                    ),
                  );
                },
                child: const Text('View Lot?'),
              ),
            ],
          ),
        );
      },
    );
  }
}
