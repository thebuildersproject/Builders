import 'package:flutter/material.dart';

void main() => runApp(
    MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    ) //MaterialApp
);
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.green[600],
                Colors.green[300]
                ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
                padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),),
                  SizedBox(height: 10,),
                  Text("Welcome Back", style: TextStyle(color: Colors.white,fontSize: 18),),
                ],
              ),
            )
            Expanded(
                child:Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                  ),

                ),
            )
          ],
        ),
      ),
    )
  }
}