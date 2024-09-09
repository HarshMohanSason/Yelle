import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yelle/ReusableWidgets/chat_bubble.dart';
import 'package:yelle/ReusableWidgets/search_bar.dart';
import 'package:yelle/Services/services_display_widget.dart';
import 'package:yelle/main.dart';

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  ServicesState createState() => ServicesState();
}

class ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Platform.isAndroid ? true: false,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight / 15),
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xFFFE9900), // Start color
                Color(0xFFFFBE00),
                // End color
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back), // Use arrow_back icon
                onPressed: () {
                  Navigator.pop(context); // Handles back navigation
                },
              ),
              backgroundColor: Colors.transparent,
              title: Text(
                "SERVICES",
                style: TextStyle(
                    fontFamily: 'Plus_Jakarta_Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth / 18),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: SearchBarApp(
                      searchHintText: 'Services',
                    )),
                const SizedBox(
                  height: 30,
                ),
               const  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ServicesDisplayWidget(
                      imageType: 'assets/images/Painter.png',
                      serviceType: 'Painter',
                    ),
                    Spacer(),
                    ServicesDisplayWidget(
                      imageType: 'assets/images/Carpainter.png',
                      serviceType: 'Carpainter',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ServicesDisplayWidget(
                      imageType: 'assets/images/Civil.png',
                      serviceType: 'Civil',
                    ),
                    Spacer(),
                    ServicesDisplayWidget(
                      imageType: 'assets/images/BeautyService.png',
                      serviceType: 'Beauty',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ServicesDisplayWidget(
                      imageType: 'assets/images/TileService.png',
                      serviceType: 'Tiles',
                    ),
                    Spacer(),
                    ServicesDisplayWidget(
                      imageType: 'assets/images/DriverService.png',
                      serviceType: 'Driver',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ServicesDisplayWidget(
                      imageType: 'assets/images/MaidService.png',
                      serviceType: 'Maid',
                    ),
                    const Spacer(),
                    Container(
                      width: screenWidth / 2.3,
                      height: screenHeight / 5.6,
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
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Stack(
                          children: [

                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "More",
                                style: TextStyle(
                                  fontFamily: 'Plus_Jakarta_Sans',
                                  fontSize: screenWidth / 29,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Center(
                                child: Container(
                                    width: screenWidth / 2.7,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.asset(
                                      'assets/images/tintedGradient.png',
                                      fit: BoxFit.cover,)

                                ),
                              ),
                            ),
                            Center(
                              child: Image.asset('assets/images/Ellipse16.png', fit: BoxFit.cover,
                              scale: 2.8),

                            ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/serviceGradientSquare.png', fit: BoxFit.cover,
                                      scale: screenWidth/50),
                                const   SizedBox(width: 3,),
                                  Image.asset('assets/images/serviceGradientSquare.png', fit: BoxFit.cover,
                                      scale: screenWidth/50),
                                ],
                              ),
                             const  SizedBox(height: 3,),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/serviceGradientSquare.png', fit: BoxFit.cover,
                                      scale: screenWidth/50),
                                 const SizedBox(width: 2,),
                                  ClipOval(
                                    child: Image.asset('assets/images/serviceGradientSquare.png', fit: BoxFit.cover,
                                        scale: screenWidth/55),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                           const  Positioned(
                              right: 1,
                              bottom: 1,
                                child: ChatBubble()),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
