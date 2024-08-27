
import 'package:flutter/material.dart';

import '../main.dart';

class SignUpPageImageText extends StatelessWidget{
  final String mainHeading;
  final String subHeading;

  const SignUpPageImageText({super.key, required this.mainHeading, required this.subHeading});

  @override
  Widget build(BuildContext context) {

   return Positioned(
     top: screenHeight / 14,
     left: 15,
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Text(
           mainHeading,
           style: TextStyle(
             fontFamily: 'Plus_Jakarta_Sans',
             fontSize: screenWidth / 16.5,
             color: Colors.white,
             fontWeight: FontWeight.bold,
           ),
         ),
         Padding(
           padding: const EdgeInsets.only(top: 20),
           child: SizedBox(
             width: screenWidth,
             child: Text(
               softWrap: true,
              subHeading,
               style: TextStyle(
                 fontFamily: 'Plus_Jakarta_Sans',
                 fontSize: screenWidth / 30.17,
                 color: Colors.white,
               ),
             ),
           ),
         ),
       ],
     ),
   );
  }

}