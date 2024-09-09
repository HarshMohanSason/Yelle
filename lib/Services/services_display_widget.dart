

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yelle/Services/service_type.dart';
import 'package:yelle/main.dart';

class ServicesDisplayWidget extends StatelessWidget{
  final String imageType; 
  final String serviceType; 
  
  const ServicesDisplayWidget({super.key, required this.imageType, required this.serviceType});

  @override
  Widget build(BuildContext context) {
  
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ServiceType(serviceType: serviceType,)));
      },
      child: Container(
        width: screenWidth /2.3,
        height: screenHeight/5.6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 13),
              width: screenWidth/2.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(imageType, fit: BoxFit.cover,) ),
      
            const SizedBox(height: 10),
            Text(serviceType, style: TextStyle(
                fontFamily: 'Plus_Jakarta_Sans',
                fontSize: screenWidth / 29
            ),)
          ],
        ),
      ),
    );
  }
  
  
}