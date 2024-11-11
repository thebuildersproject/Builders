import 'package:buildingapp/Login/account.dart';
import 'package:buildingapp/Login/admin.dart';
import 'package:buildingapp/Parking_Pages/parking_count.dart';
import 'package:buildingapp/main.dart';
import 'package:flutter/material.dart';

class YellowParkingPage extends StatefulWidget {
  const YellowParkingPage({super.key});
  @override
  _YellowParkingPageState createState() => _YellowParkingPageState();
}
class _YellowParkingPageState extends State<YellowParkingPage> {
  // Initial selected option from the popup menu
  Choice _selectedOption = choices[0];

  // List of parking lots for Yellow Parking Page
  final List<Map<String, dynamic>> yellowParkingLots = [
    {
      //Parking Lot information needs to be called on by backend
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
    // Add more parking lots if needed
  ];

  // Function to handle selection of a choice
  void _select(Choice choice) {
    setState(() {
      _selectedOption = choice;

      if (choice.name == 'Home') {

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> MyHomePage(title: 'homepage',))
        );

      }else if(choice.name=='Account'){

        //Navigate to account page to sign out
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=> AccountPage()),
        );
      } else if (choice.name == 'Admin') {

        // Navigate to the admin page to add/remove parking spots
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
          backgroundColor: Colors.amber,
          title: const Text("Yellow Parking"),
        actions: [
      // Adding PopupMenuButton in the AppBar's actions
      PopupMenuButton<Choice>(
      onSelected: _select,
        itemBuilder: (BuildContext context) {
          return choices.map((Choice choice) {
            return PopupMenuItem<Choice>(
              value: choice,
              child: Row(
                children: [
                  Icon(choice.icon),
                  const SizedBox(width:10),
                  Text(choice.name),
                ],
              )
            );
          }).toList();
        },
      ),
      ],
      ),
        body: ListView.builder(
        padding: EdgeInsets.all(8.0),
    itemCount: yellowParkingLots.length,
    itemBuilder: (context, index) {
      final lot = yellowParkingLots[index];
      return ParkingLotCard(
        lotName: lot['name'],
        description: lot['description'],
        maxSpots: lot['maxSpots'],
        openSpots: lot['openSpots'],
      );},
        ),
    );
  }
}

// Define the ParkingLotCard widget
class ParkingLotCard extends StatelessWidget {
  final String lotName;
  final String description;
  final int maxSpots;
  final int openSpots;

  const ParkingLotCard({
    required this.lotName,
    required this.description,
    required this.maxSpots,
    required this.openSpots,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Parking Lot Details Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lotName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            // Details Button
            OutlinedButton(
              onPressed: () {
                _showDetailsDialog(context);
              },
              child: Text("Details"),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Parking Lot Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Max spots: $maxSpots"),
              Text("Open spots: $openSpots"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close details dialog
                  _showConfirmationDialog(context);
                },
                child: Text("Park Here"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Parking"),
          content: Text("Are you sure you want to park here?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the confirmation dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close confirmation dialog
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> ParkingCountPage(parkingLotName: "Parking Lot Name"))
                );},
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}

// Define the Choice class for the popup menu
class Choice {
  const Choice({required this.name, required this.icon});
  final String name;
  final IconData icon;
}

// List of choices for the popup menu
const List<Choice> choices = <Choice>[
  Choice(name: 'Home', icon: Icons.home), //Go back to home page state
  Choice(name: 'Account', icon: Icons.person_2_outlined), //Add Sign out Option
  Choice(name: 'Admin', icon: Icons.lock), //Go to a page to add/remove parking spots
];