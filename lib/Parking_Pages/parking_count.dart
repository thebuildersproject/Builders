import 'package:buildingapp/Login/account.dart';
import 'package:buildingapp/Login/admin.dart';
import 'package:buildingapp/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ParkingCountPage extends StatefulWidget {
  final String parkingLotName;
  const ParkingCountPage({super.key, required this.parkingLotName});

  @override
  _CountPageState createState() => _CountPageState();  // Properly returning the state class
}

class _CountPageState extends State<ParkingCountPage> {
  // Initial selected option from the popup menu
  Choice _selectedOption = choices[0];

  //Demo Values
  final int maxSpots=45;
  final int currentSpots=20;

  void _select(Choice choice) {
    setState(() {
      _selectedOption = choice;
      if (choice.name == 'Home') {
        //Navigate to homepage
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
    });
  }

  @override
    Widget build(BuildContext context) {
    double fillPercentage = currentSpots /maxSpots;

    return Scaffold(
        appBar: AppBar(
            title: const Text("Parking Count"),
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
                        )
                    );
                  }).toList();
                },
              ),]
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.lightGreen.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                widget.parkingLotName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                )
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Counter:'),
                  SizedBox(height: 20), // Add some spacing between the text and the animation
                  Lottie.network(
                    'https://lottie.host/94b5f01e-822f-4dad-a7dc-cbe39d47924b/ABJXAP3mKs.json',
                    width: 200, // Adjust width as needed
                    height: 200, // Adjust height as needed
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20,), //space between counter and animation
                  CircularPercentIndicator(
                    radius: 100.0,
                    lineWidth:10.0,
                    percent: fillPercentage,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$currentSpots",
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "of $maxSpots spots",
                          style: TextStyle(fontSize: 16.0, color:Colors.grey),
                        ),
                      ],
                    ),
                    progressColor: Colors.red,
                    backgroundColor: Colors.grey.shade300,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ],
              ),
            )

          ]
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
