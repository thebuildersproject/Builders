import 'package:buildingapp/Login/account.dart';
import 'package:buildingapp/Login/admin.dart';
import 'package:buildingapp/main.dart';
import 'package:flutter/material.dart';
import 'package:buildingapp/openStreetMap/osm.dart';

class MainParkingPage extends StatefulWidget {
  const MainParkingPage({super.key});

  @override
  _MainParkingPageState createState() => _MainParkingPageState();
}

class _MainParkingPageState extends State<MainParkingPage> {
  // Initial selected option from the popup menu
  Choice _selectedOption = choices[0];

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
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("School Parking"),
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
                      const SizedBox(width: 10),
                      Text(choice.name),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: const OsmWidget(),
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
