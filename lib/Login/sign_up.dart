import 'package:buildingapp/Login/login.dart';
import 'package:buildingapp/SQLite/sqlite.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget{
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{
  final username= TextEditingController();
  final password= TextEditingController();
  final confirmPassword= TextEditingController();

  final formKey= GlobalKey<FormState>();

  bool isVisible=false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //SingleChildScrollView to have scoll in screen
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [


                const ListTile(
                  title: Text(
                    "Register New Account",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),

                //
                Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.lightGreen.withOpacity(.2)),
                  child: TextFormField(
                    controller: username,
                    validator: (value){
                      if(value!.isEmpty){
                        return "username required";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: "Username",
                    ),
                  ),
                ),

                  //Password field
                  Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.lightGreen.withOpacity(.2)),
                  child: TextFormField(
                    controller: password,
                    validator: (value){
                      if(value!.isEmpty){
                        return "password required";
                  }
                      return null;
                  },
                    obscureText: !isVisible,
                    decoration:  InputDecoration(
                        icon: const Icon(Icons.lock),
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

                //Confirm Password field
                //Check if passwords match
                Container(
                  margin: const EdgeInsets.all(8),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.lightGreen.withOpacity(.2)),
                  child: TextFormField(
                    controller: confirmPassword,
                    validator: (value){
                      if(value!.isEmpty){
                        return "password required";
                      }else if(password.text !=confirmPassword.text ){
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    obscureText: !isVisible,
                    decoration:  InputDecoration(
                        icon: const Icon(Icons.lock),
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


                const SizedBox(height: 10),
                //Login Button
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width *9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.greenAccent),
                  child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()){
                          //Login method here

                          final db= DatabaseHelper();
                          db.signup(Users(
                              usrName: username.text, 
                              usrPassword: password.text))
                              .whenComplete((){
                                Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) =>
                                    const LoginScreen()));
                          });
                        }
                      },
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.white),
                      )),
                ),

                //Sign up button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(onPressed: () {
                      //Navigate to sign up
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>const LoginScreen()));
                    },
                        child: const Text("Login"))
                  ],
                )

              ],
                  ),
            ),
          ),
        ),
      )
    );
}
}
