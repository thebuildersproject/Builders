import 'package:buildingapp/Login/account.dart';
import 'package:buildingapp/Login/admin.dart';
import 'package:buildingapp/Parking_Pages/map_main.dart';
import 'package:flutter/material.dart';
import 'package:buildingapp/Parking_Pages/yellow_parking.dart';
import 'package:buildingapp/Parking_Pages/orange_parking.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: "Homepage"), // Set HomePage from login_page.dart as the initial screen
    );
  }
}

// Keep the MyHomePage class for navigation purposes
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text(widget.title),
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
          ),
        ],
      ),
      body: Stack(
          children: [
            // Background image using Container and BoxDecoration
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("lib/assets/atu_background.jpg"), // Replace with your image path
                  fit: BoxFit.cover, // Adjust to your preference
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.dstATop,
                  )
                ),
              ),
            ),
            Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height:100),
              Text(
                "Welcome Back",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
                letterSpacing: 1.5,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(3,3),
                  )
                ],
              ),
            ),
          const SizedBox(height: 15,),
            Text(
              'Ready to Park?',
               style: TextStyle(
                 fontSize: 36,
                 fontWeight: FontWeight.bold,
                 color: Colors.amber,
                 letterSpacing: 1.5,
                 shadows: [
                   Shadow(
                     blurRadius: 10.0,
                     color: Colors.black.withOpacity(0.3),
                     offset: Offset(3,3),
                   )
                 ]
               ),
            ),
          ],
        ),
      ),
  ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context)=> const MainParkingPage())
          );
        },
        tooltip: 'Open Map',
        backgroundColor: Colors.amber,
        child: Icon(Icons.navigation_outlined),
      ),
      //Position of Floating Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //Navigation Bar
      bottomNavigationBar: BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
      IconButton(
      icon: const Icon(Icons.directions_car),
        onPressed: () {
          // Navigate to Yellow parking page
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const YellowParkingPage()));
        },
      ),
      IconButton(
        icon: const Icon(Icons.airport_shuttle),
        onPressed: () {
          // Navigate to Orange parking page
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const OrangeParkingPage()));
        },
      ),
      ]),
    ));
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
  Choice(name: 'Admin', icon: Icons.lock), //Go to a page to add parking spots or remove
];


