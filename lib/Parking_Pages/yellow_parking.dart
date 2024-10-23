import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class YellowParkingPage extends StatefulWidget {
  const YellowParkingPage({super.key});
  @override
  _YellowParkingPageState createState() => _YellowParkingPageState();
}
class _YellowParkingPageState extends State<YellowParkingPage> {
  // Initial selected option from the popup menu
  Choice _selectedOption = choices[0];

  // Function to handle selection of a choice
  void _select(Choice choice) {
    setState(() {
      _selectedOption = choice;

      if (choice.name == 'Home') {

        // Navigate to Home Page
        Navigator.pop(context);  // Assuming Home is the previous page

      }
    });
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
      body: Center(
        child: Lottie.network(
    'https://lottie.host/94b5f01e-822f-4dad-a7dc-cbe39d47924b/ABJXAP3mKs.json'),
    ),
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