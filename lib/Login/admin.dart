import 'package:flutter/material.dart';
import 'package:buildingapp/Login/account.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();  // Properly returning the state class
}

class _AdminPageState extends State<AdminPage> {
  // Initial selected option from the popup menu
  Choice _selectedOption = choices[0];

  // Function to handle selection of a choice
  void _select(Choice choice) {
    setState(() {
      _selectedOption = choice;

      if (choice.name == 'Home') {

        // Navigate to Home Page
        Navigator.pop(context);  // Assuming Home is the previous page

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
        title: const Text("Admin Page"),
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
      body: const Center(
        child: Text("Admin functionalities here"),
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
