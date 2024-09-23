import 'package:flutter/material.dart';

class SignUp extends StatefulWidget{
  const SignUp({super.key})

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignupState extends State<SignUp>{
  final username= TextEditingController();
  final password= TextEditingController();
  final confirmPassword= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
      body: Column(
      children: [


      ],
    )
}
}