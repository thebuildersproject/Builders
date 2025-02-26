import 'package:flutter/material.dart';
import 'package:buildingapp/Parking_Pages/parking_count.dart';

class RedParkingPage extends StatefulWidget {
  const RedParkingPage({super.key});

  @override
  State<RedParkingPage> createState() => _RedParkingPageState();
}

class _RedParkingPageState extends State<RedParkingPage> {
  // Parking lot data
  final Map<String, List<Map<String, dynamic>>> parkingData = {
    'Corely': [
      {
        'name': 'Corely Parking Lot',
        'description': 'Parking lot in front of Corely building',
        'maxSpots': 60,
        'openSpots': 30,
      },
    ],
    'Colosseum': [
      {
        'name': 'Parking Lot A',
        'description': 'Closest to Coliseum',
        'maxSpots': 20,
        'openSpots': 0,
       },
      {
        'name': 'Parking Lot B',
        'description': 'Across from Brown and Rothwell',
        'maxSpots': 20,
        'openSpots': 1,
      },
    ],
  };

  // Current selected section
  String _selectedSection = 'Corely';

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
                'Staff Parking',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8.0),
              const Icon(Icons.badge_outlined, size: 28),
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
                    style: TextStyle(color: lot['openSpots'] == 0 ? Colors.red : Colors.green),
                  ),
                  onTap: () {
                    // Show navigate dialog
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
