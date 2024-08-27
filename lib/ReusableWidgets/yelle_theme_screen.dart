
import 'package:flutter/material.dart';
import '../main.dart';

class YelleThemeScreen extends StatelessWidget {
  const YelleThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return PopScope(
     canPop: false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFE9900),  // Start color
                Color(0xFFFFBE00),  // End color
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Text(
                  "YELLE",
                  style: TextStyle(
                    fontFamily: 'Kanit',
                    fontSize: screenWidth * .153,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}