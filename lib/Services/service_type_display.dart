
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yelle/Services/service_provider_information.dart';
import 'package:yelle/main.dart';

class ServiceTypeDisplay extends StatelessWidget {


  final ServiceProviderInformation serviceProviderInformation;
  const ServiceTypeDisplay({super.key, required this.serviceProviderInformation });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: screenWidth - 40,
      height: screenHeight / 5.8,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 20, right: 10),
                child: Container(
                  width: screenWidth/ 3.8,
                  height: screenHeight /9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: CachedNetworkImage(imageUrl: serviceProviderInformation.imageUrl, fit: BoxFit.contain,)
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${serviceProviderInformation.name}'
                      ),
                  Text('Occupation: ${serviceProviderInformation.occupation}'),
                  Text("Exp: ${serviceProviderInformation.experience} Years")
                ],
              ),

              Padding(
                padding: EdgeInsets.only(bottom: screenWidth/7.2),
                child: Container(
                  width: screenWidth/7.8,
                  height: screenHeight/37.8,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E6),
                        borderRadius: BorderRadius.circular(5),
                    ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(serviceProviderInformation.currentRating.toString()),
                       const SizedBox(width: 2,),
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [
                                Color(0xFFFE9900), // Start color
                                Color(0xFFFFBE00),], // Define your gradient colors here
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ).createShader(bounds);
                          },
                          child: Icon(
                            Icons.star,
                            size: screenWidth / 23, // Use your desired size
                            color: Colors.white, // This color acts as the mask
                          ),
                        )
                      ],
                    ),

                  ),
                ),
              )

            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1, left: 5, right: 5),
            child: Container(
              width: screenWidth/1.15,
              height: screenHeight/22,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8E6),
                borderRadius: BorderRadius.circular(8)
              ),
          child: Padding(
            padding: const EdgeInsets.only(left:10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFFFE9900), // Start color
                      Color(0xFFFFBE00),
                      // End color
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ).createShader(bounds),
                  child: Icon(
                    Icons.location_pin,
                    size: screenWidth/15, // Adjust the size as needed
                    color: Colors.white, // This will be the base color for the gradient
                  ),
                ),
                const SizedBox(width: 10),
                Text(serviceProviderInformation.location, style: TextStyle(
                    fontFamily: 'Plus_Jakarta_Sans',
                    fontSize: screenWidth / 30),)
              ],
            ),
          )
            ),
          )
        ],
      ),
    );
  }
}
