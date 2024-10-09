import 'package:buildingapp/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


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
    });
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
                  child: Text(choice.name),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Select parking lot:',
            ),
            Text(
              ' Which parking spot?  ',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // Display the selected option from the popup menu
            Text(
              'Selected: ${_selectedOption.name}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _launchURL,
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
              MaterialPageRoute(builder: (context) => const OrangePage()));
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
  Choice(name: 'Home', icon: Icons.home),
  Choice(name: 'Account', icon: Icons.person_2_outlined),
  Choice(name: 'Admin', icon: Icons.lock),
];

// Launch URL function remains the same
Future<void> _launchURL() async {
  final Uri url = Uri.parse("https://www.atu.edu/map/docs/ATU-Campus-Map-2024.pdf");
  if (!await launchUrl(url)) {
    throw Exception('Could not load $url');
  }
}
// Dummy yellow parking page
class YellowParkingPage extends StatelessWidget {
  const YellowParkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yellow Parking")),
      body: const Center(child: Text("Yellow Parking Page")),
    );
  }
}

// Dummy orange parking page
class OrangePage extends StatelessWidget {
  const OrangePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Orange Parking")),
      body: const Center(child: Text("Orange Parking Page")),
    );
  }
}