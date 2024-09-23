//Future login page
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState()=> _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //Text editors for when text inputed
  final username = TextEditingController();
  final password = TextEditingController();

  //Bool to show and hide password
  bool isVisible =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              //Username field

          //image.asset()
              Container(
                margin: EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            color: Colors.lightGreen.withOpacity(.3)),
                child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  border: InputBorder.none,
                  hintText: "Username",
                ),
              ),
              ),

              //Password field
              Container(
                margin: EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.lightGreen.withOpacity(.3)),
                child: TextFormField(
                  obscureText: !isVisible,
                  decoration:  InputDecoration(
                    icon: Icon(Icons.lock),
                    border: InputBorder.none,
                    hintText: "Password",
                    suffixIcon: IconButton(onPressed: () {
                      //Hide and show
                      setState(() {
                        //toggle button
                        isVisible= !isVisible;
                      });
                    },
                        icon: Icon(isVisible
                        ? Icons.visibility
                        : Icons.visibility_off))),
                  ),
                ),
            ],
          ),),
        ),
      ),
    );
  }
}