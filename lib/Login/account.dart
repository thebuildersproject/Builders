import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buildingapp/firebase_options.dart';
import 'package:buildingapp/Login/login.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  String _selectedColor = 'Green'; // Default color
  bool _isUpdating = false;
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (user != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(user!.uid).get();
      if (doc.exists) {
        setState(() {
          _selectedColor = doc['hangtagColor'] ?? 'Green';
        });
      }
    }
  }

  Future<void> _updatePassword() async {
    if (_newPasswordController.text.isEmpty) return;
    if (_currentPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your current password')),
      );
      return;
    }

    setState(() => _isUpdating = true);

    try {
      // Re-authenticate user
      AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: _currentPasswordController.text,
      );

      await user!.reauthenticateWithCredential(credential);
      await user!.updatePassword(_newPasswordController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password updated successfully')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_getErrorMessage(e.code))),
      );
    } finally {
      setState(() => _isUpdating = false);
      _newPasswordController.clear();
      _currentPasswordController.clear();
    }
  }

  Future<void> _updateHangtagColor() async {
    setState(() => _isUpdating = true);
    try {
      await _firestore.collection('users').doc(user!.uid).set({
        'hangtagColor': _selectedColor,
        'email': user!.email,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preferences updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating preferences: ${e.toString()}')),
      );
    } finally {
      setState(() => _isUpdating = false);
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'wrong-password':
        return 'Incorrect current password';
      case 'weak-password':
        return 'Password must be at least 6 characters';
      case 'requires-recent-login':
        return 'Session expired - please re-login';
      default:
        return 'Password update failed. Please try again';
    }
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } catch (e) {
      print("Sign out error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Header
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.greenAccent[700],
              child: const Icon(
                Icons.person_outline,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              user?.email ?? 'No email available',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),

            // Account Details Section
            _buildSectionHeader("Account Details"),
            _buildDetailItem(
              icon: Icons.email,
              label: "Email",
              value: user?.email ?? 'Not set',
            ),
            const SizedBox(height: 20),

            _buildSectionHeader("Security"),
            TextFormField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                labelText: "Current Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_reset),
                labelText: "New Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 20),

            // Parking Tag Color Selection
            _buildSectionHeader("Parking Preferences"),
            DropdownButtonFormField<String>(
              value: _selectedColor,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.color_lens),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              items: ['Red', 'Green', 'Blue', 'Yellow', 'Orange']
                  .map((color) => DropdownMenuItem(
                value: color,
                child: Text(color),
              ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedColor = value!),
            ),
            const SizedBox(height: 40),

            // Update Button
            ElevatedButton(
              onPressed: _isUpdating
                  ? null
                  : () async {
                await _updatePassword();
                await _updateHangtagColor();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.greenAccent[700],
              ),
              child: _isUpdating
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                "UPDATE PROFILE",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            // Sign Out Button
            OutlinedButton(
              onPressed: _signOut,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: Colors.red[400]!),
              ),
              child: Text(
                "SIGN OUT",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildDetailItem({required IconData icon, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.greenAccent[700]),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}