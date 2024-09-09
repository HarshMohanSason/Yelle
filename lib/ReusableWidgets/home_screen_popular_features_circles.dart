import 'package:flutter/material.dart';

import '../main.dart';

class HomeScreenPopularFeaturesCircles extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final double radiusSize;
  final double imagePaddingValue;
  final String imagePath;
  final String featureName;

  const HomeScreenPopularFeaturesCircles(
      {super.key,
      required this.startColor,
      required this.endColor,
      required this.radiusSize,
      required this.imagePaddingValue,
      required this.imagePath,
      required this.featureName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                startColor,
                endColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: CircleAvatar(
            radius: radiusSize,
            backgroundColor: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.all(imagePaddingValue),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          featureName,
          style: TextStyle(
              fontFamily: 'Plus_Jakarta_Sans',
              fontSize: screenWidth / 35.83),
        ),
      ],
    );
  }
}
