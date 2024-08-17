

import 'package:flutter/material.dart';
import 'package:yelle/Login/phone_text_form.dart';
import 'package:yelle/main.dart';

class IntroLoginScreen extends StatefulWidget{
  const IntroLoginScreen({super.key});

  @override
  IntroLoginScreenState createState() => IntroLoginScreenState();

}

class IntroLoginScreenState extends State<IntroLoginScreen>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colorTheme,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text("Yelle", style: TextStyle(
                fontSize: 70,
              ),),
            ),
            const Spacer(),
            Padding(
               padding: const EdgeInsets.only(bottom: 50),
                child: continueWithPhoneButton())
          ],
        ),
      ),
    );
  }

  Widget continueWithPhoneButton() {
    return ElevatedButton(
      onPressed: () {

        Navigator.push(context, MaterialPageRoute(builder: (context) =>  PhoneTextForm()));
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 8,
        // This adds a shadow
        shadowColor: Colors.black.withOpacity(0.5),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
      ),
      child: SizedBox(
        width: screenWidth - 200,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.phone),
            ),
            Text(
              'Continue with Phone',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}