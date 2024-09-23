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

  //Create global key for form
  final formKey= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
          //All textfield in form to not allow empty entry
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
                onPressed: () {},
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
                  },
                      child: const Text("SIGN UP"))
                ],
              )
            ]
            ),
          ),
          ),
        ),
      ),
    );
  }
}