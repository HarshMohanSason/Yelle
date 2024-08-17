import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:yelle/Login/intro_login_screen.dart';

const colorTheme = Color(0xFFFFBF00);
final FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
final Size screenSize = view.physicalSize/view.devicePixelRatio; //get the device pixel size
final screenWidth = screenSize.width;
final screenHeight = screenSize.height;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Yelle",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colorTheme),
        useMaterial3: true,
      ),
      home: const IntroLoginScreen(),
    );
  }
}
