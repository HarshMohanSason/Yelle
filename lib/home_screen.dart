import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  HomeScreenState createState()=> HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {

    return  PopScope(
      canPop: false,
      child:  Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors:  [
             Color(0xFFFE9900),  // Start color
             Color(0xFFFFBE00),
// End color
            ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          )
          ),
        ),
      ),
    );
  }

}