
import 'package:flutter/cupertino.dart';
import '../main.dart';

class SignUpPageImageBackground extends StatelessWidget{
  const SignUpPageImageBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Background image at the top
        Image.asset(
          "assets/images/YelleBackground.png",
          width: screenWidth,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}