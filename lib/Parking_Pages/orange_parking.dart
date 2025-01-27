import 'package:flutter/material.dart';
import 'package:buildingapp/Parking_Pages/parking_count.dart';

class OrangeParkingPage extends StatefulWidget {
  const OrangeParkingPage({super.key});

  @override
  State<OrangeParkingPage> createState() => _OrangeParkingPageState();
}

class _OrangeParkingPageState extends State<OrangeParkingPage> {
  // Tabs and dropdown data
  final Map<String, String> tabDescriptions = {
    'Orange': 'Parking in the back portion of the school.',
    'Blue': 'Parking spots near stadium suite housing and across visiting team dressing facility.',
    'Green': 'Parking spots for the University Commons Apartments. Near the Energy Center.',
  };

  final Map<String, Map<String, List<Map<String, dynamic>>>> parkingData = {
    'Orange': {
      'Orange': [
        {
          'name': 'Paine Residence Parking',
          'description': 'Generic description',
          'maxSpots': 50,
          'openSpots': 46,
        },
      ],
    },
    'Blue': {
      'Blue': [
        {
          'name': 'Stadium Suite Parking',
          'description': 'Generic description',
          'maxSpots': 25,
          'openSpots': 1,
        },
        {
          'name': 'Williamson Hall Extra Parking',
          'description': 'Generic description',
          'maxSpots': 60,
          'openSpots': 12,
        },
      ],
    },
    'Green': {
      'Green': [
        {
          'name': 'Commons Main Parking',
          'description': 'Main lot located across the street from the Energy Center',
          'maxSpots': 100,
          'openSpots': 32,
        },
        {
          'name': 'Jones Residence Parking A',
          'description': 'Main parking of Jones residence',
          'maxSpots': 40,
          'openSpots': 30,
        },
        {
          'name': 'Jones Residence Parking B',
          'description': 'Jones residence parking across Corely building',
          'maxSpots': 10,
          'openSpots': 9,
        },
        {
          'name': 'Jones Residence Parking C',
          'description': 'Parking beside residence outdoor recreation area',
          'maxSpots': 20,
          'openSpots': 2,
        },
      ],
    },
  };

  // Currently selected tab and dropdown
  String _selectedTab = 'Orange';
  String _selectedSection = 'Orange';

  void _showTabDescription(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> selectedLots = parkingData[_selectedTab]?[_selectedSection] ?? [];

    return Column(
      children: [
        // Title with an icon
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Residential Parking',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8.0),
              const Icon(Icons.bedroom_child_outlined, size: 28),
            ],
          ),
        ),
        // Tabs with information icons
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: tabDescriptions.keys.map((tab) {
              return Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedTab = tab;
                        _selectedSection = tab; // Update dropdown to match the tab
                      });
                    },
                    child: Text(
                      tab,
                      style: TextStyle(
                        color: _selectedTab == tab ? Colors.blue : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => _showTabDescription(context, tabDescriptions[tab]!),
                  ),
                ],
              );
            }).toList(),
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
            items: parkingData[_selectedTab]!.keys.map((section) {
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
