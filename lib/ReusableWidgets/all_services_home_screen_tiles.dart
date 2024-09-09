
import 'package:flutter/material.dart';
import 'package:yelle/main.dart';

class AllServicesHomeScreenTiles extends StatelessWidget{
  final String serviceName;
  final String imagePath;
  const AllServicesHomeScreenTiles({super.key, required this.serviceName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Slightly transparent background
        borderRadius: BorderRadius.circular(10), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // Offset for the shadow
          ),
        ],
      ),
      width: screenWidth / 2.3,
      height: screenHeight / 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: screenWidth / 7.5, // Slightly larger to accommodate the border
              height: screenWidth / 7.5, // Same as width to maintain a circle
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFE9900), // Start color
                    Color(0xFFFFBE00),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Container(
                  width: screenWidth / 8,
                  height: screenWidth / 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFFF8E6), // Light cream background color
                  ),
                  child: CircleAvatar(
                    radius: screenWidth / 15,
                    backgroundColor: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth/40),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(serviceName, style: TextStyle(
                fontFamily: 'Plus_Jakarta_Sans',
                fontSize: screenWidth / 30),)

          ],
        ),
      ),
    );
  }

}