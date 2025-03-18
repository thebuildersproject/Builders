import 'package:buildingapp/Login/account.dart' as account;
import 'package:buildingapp/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:buildingapp/Parking_Pages/yellow_parking.dart';
import 'package:buildingapp/Parking_Pages/red_parking.dart'; //Extra parking spot dart files
import 'package:buildingapp/Parking_Pages/orange_parking.dart'; //Other Parking spot files
import 'package:buildingapp/Parking_Pages/all_parking.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:buildingapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signOut();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ParkATU',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      // Changed home to use auth stream
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Show loading indicator while checking auth state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // If user is logged in, show HomePage
          if (snapshot.hasData) {
            return const MyHomePage(title: 'Home');
          }

          // If not logged in, show LoginScreen
          return const LoginScreen();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentPage = 'Home';

  void _changePage(String page) {
    setState(() => _currentPage = page);
  }

  Widget _getParkingPage() {
    final DateTime now = DateTime.now();
    final int currentHour = now.hour;
    return currentHour >= 8 && currentHour < 17
        ? const OrangeParkingPage()
        : const AllParkingSpotsPage();
  }

  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'lib/assets/ATU_icon.png',
            height: 150,
            width: 150,
          ),
          const SizedBox(height: 32),
          Text(
            "Welcome to ParkATU!",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent[700],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Your Smart Campus Parking Solution",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 40),
          _buildFeatureCard(
            icon: Icons.directions_car,
            title: "Real-Time Availability",
            description: "See up-to-date parking spot availability",
          ),
          const SizedBox(height: 20),
          _buildFeatureCard(
            icon: Icons.security,
            title: "Secure Account",
            description: "Protected user authentication and data security",
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({required IconData icon, required String title, required String description}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.greenAccent[700]),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    if (_currentPage == 'Home') {
      bodyContent = _buildHomeContent();
    } else if (_currentPage == 'Parking') {
      bodyContent = _getParkingPage();
    } else if (_currentPage == 'Account') {
      bodyContent = const account.AccountPage();
    } else {
      bodyContent = const Center(child: Text("Unknown Page"));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "ParkATU",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          // Keep original buttons
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
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _changePage('Parking'),
                  icon: const Icon(Icons.local_parking),
                  label: const Text("Parking"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Updated body content
          Expanded(
            child: bodyContent,
          ),
        ],
      ),
    );
  }
}
