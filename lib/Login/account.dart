import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Text Editing Controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _parkingTagController = TextEditingController();

  // Sign out function
  void _signOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Account Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Username Field
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Password Field
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true, // Hides the password
            ),
            const SizedBox(height: 16),
            // Email Field
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Parking Tag Field
            TextField(
              controller: _parkingTagController,
              decoration: const InputDecoration(
                labelText: "Parking Color Tag",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            // Edit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // For now, just print values to console
                  print("Username: ${_usernameController.text}");
                  print("Password: ${_passwordController.text}");
                  print("Email: ${_emailController.text}");
                  print("Parking Tag: ${_parkingTagController.text}");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Details updated successfully!")),
                  );
                },
                child: const Text("Edit"),
              ),
            ),
            const Spacer(),
            // Sign Out Button
            Center(
              child: ElevatedButton(
                onPressed: _signOut,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Sign-out button color
                ),
                child: const Text("Sign Out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Page")),
      body: const Center(
        child: Text("Login Page Implementation Goes Here"),
      ),
    );
  }
}
