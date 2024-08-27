
import 'package:flutter/material.dart';
import '../main.dart';

class GradientButton extends StatelessWidget {
  final String text;

  const GradientButton({super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Container(
        height: 50,
        width: screenWidth - 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFE9900), // Start color
              Color(0xFFFFBE00), // End color
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth / 25,
            ),
          ),
        ),
      ),
    );
  }
}