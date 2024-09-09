
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yelle/main.dart';

class ChatBubble extends StatelessWidget{
  const ChatBubble({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: screenWidth / 6, // Slightly larger to accommodate the border
      height: screenWidth /6, // Same as width to maintain a circle
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 4,
            blurRadius: 7,
            offset: const Offset(0, 3), // Offset for the shadow
          ),
        ],
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(
          color: Colors.white, // White border color
          width: 4.0, // Border width (adjust as needed)
        ),
      ),
      child: Center(
        child: Container(
          width: screenWidth / 5,
          height: screenWidth / 5,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xFFFE9900), // Start color
                Color(0xFFFFBE00), // End color
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: CircleAvatar(
            radius: screenWidth / 16,
            backgroundColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset(
                'assets/images/chatBubble.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }


}