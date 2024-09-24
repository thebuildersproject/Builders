//Future login page
import 'package:flutter/material.dart';
import 'package:buildingapp/Login/sign_up.dart';
import 'package:buildingapp/SQLite/sqlite.dart';
import 'package:buildingapp/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState()=> _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //Text editors for when text is input
  final username = TextEditingController();
  final password = TextEditingController();

  //Bool to show and hide password
  bool isVisible =false;

  //Bool variable to hide red text
  bool isLoginTrue =false;

  final db= DatabaseHelper();

  login() async {
    var response= await db
        .login(Users(usrName: username.text, usrPassword: password.text));
    if (response ==true) {
      //If login is correct go to parking app
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Notes()));
    }else{
      //Show error message if not true
      setState(() {
        isLoginTrue =true;
      });
    }
  }

  //Create global key for form
  final formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
          //All text field in form to not allow empty entry
          child:Form(
            key: formKey,
            child: Column(
            children: [
              //Username field

              //ATU Icon here
              Image.asset("lib/assets/ATU_icon.png",
              width: 210,
              ),
              const SizedBox(height: 15),
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


              const SizedBox(height: 10,),
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
                    login();

                  }
                },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white),
                  )),
                  ),

              //Sign up button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(onPressed: () {
                    //Navigate to sign up
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>const SignUp()));
                  },
                      child: const Text("SIGN UP"))
                ],
              ),

              //Make this a trigger
              isLoginTrue? const Text(
                "Username or password is incorrect",
                style: TextStyle(color: Colors.red),
              )
                  :const SizedBox(),
            ]
            ),
          ),
          ),
        ),
      ),
    );
  }
}