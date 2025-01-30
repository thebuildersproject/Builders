import 'package:buildingapp/Login/account.dart';
import 'package:flutter/material.dart';
import 'package:buildingapp/Parking_Pages/yellow_parking.dart';
import 'package:buildingapp/Parking_Pages/red_parking.dart'; //Extra parking spot dart files
import 'package:buildingapp/Parking_Pages/orange_parking.dart'; //Other Parking spot files
import 'package:buildingapp/Parking_Pages/all_parking.dart';

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
      home: const MyHomePage(title: 'home',), // Set HomePage as the initial screen
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Current page state to determine the body content
  String _currentPage = 'Home';

  // Function to change the page state
  void _changePage(String page) {
    setState(() {
      _currentPage = page;
    });
  }

  // Determine which parking page to show based on the time
  Widget _getParkingPage() {
    final DateTime now = DateTime.now();
    final int currentHour = now.hour;

    // Show YellowParkingPage from 8:00 AM to 5:00 PM
    if (currentHour >= 8 && currentHour < 17) {
      return const YellowParkingPage();
    }

    // Default to AllParkingSpotsPage outside this time range
    return const AllParkingSpotsPage();
  }

  @override
  Widget build(BuildContext context) {
    // Determine the content of the body based on the current page
    Widget bodyContent;
    if (_currentPage == 'Home') {
      bodyContent = const Center(
        child: Text(
          "Welcome to the Parking App!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    } else if (_currentPage == 'Parking') {
      bodyContent = _getParkingPage(); // Dynamically get the parking page
    } else if (_currentPage == 'Account') {
      bodyContent = const AccountPage();
    } else {
      bodyContent = const Center(
        child: Text("Unknown Page"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Parking App",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Buttons at the top
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _changePage('Account'),
                  icon: const Icon(Icons.person_outline),
                  label: const Text("Profile"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _changePage('Home'),
                  icon: const Icon(Icons.home),
                  label: const Text("Home"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _changePage('Parking'),
                  icon: const Icon(Icons.local_parking),
                  label: const Text("Parking"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Dynamic body content
          Expanded(
            child: bodyContent,
          ),
        ],
      ),
    );
  }
}
