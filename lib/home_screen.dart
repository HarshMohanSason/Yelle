
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yelle/main.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override

  HomeScreenState createState()=> HomeScreenState();


}

class HomeScreenState extends State<HomeScreen>{
  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child:  Scaffold(
        backgroundColor: colorTheme,
      ),
    );
  }

}