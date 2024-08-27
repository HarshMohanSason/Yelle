
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yelle/Login/email_login_service.dart';
import 'package:yelle/Login/intro_login_screen.dart';
import 'package:yelle/Login/password_reset_service.dart';
import 'package:yelle/Login/sign_up_service.dart';

const colorTheme = Color(0xFFFFBF00);

final FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
final Size screenSize = view.physicalSize/view.devicePixelRatio; //get the device pixel size
final screenWidth = screenSize.width;
final screenHeight = screenSize.height;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context)=> SignUpService())),
        ChangeNotifierProvider(create: ((context)=> EmailLoginService())),
        ChangeNotifierProvider(create: ((context)=> PasswordResetService())),
      ],
      child: MaterialApp(
        title: "Yelle",
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: colorTheme),
          useMaterial3: true,
        ),
        home: const IntroLoginScreen(),
      ),
    );
  }
}
