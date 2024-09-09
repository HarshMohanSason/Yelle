import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yelle/ReusableWidgets/all_services_home_screen_tiles.dart';
import 'package:yelle/ReusableWidgets/chat_bubble.dart';
import 'package:yelle/ReusableWidgets/home_screen_popular_features_circles.dart';
import 'package:yelle/ReusableWidgets/horizontal_lines_for_settings_button.dart';
import 'package:yelle/ReusableWidgets/image_slider_with_circle_indicator.dart';
import 'package:yelle/ReusableWidgets/search_bar.dart';
import 'package:yelle/Services/services.dart';
import 'package:yelle/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
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
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "YELLE",
                    style: TextStyle(
                        fontFamily: 'Plus_Jakarta_Sans',
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth / 12),
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: screenWidth / 17,
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                          FirebaseAuth.instance.currentUser!.photoURL!),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: screenWidth / 17,
                    backgroundColor: Colors.white,
                    // Ensure background is transparent
                    child: CustomPaint(
                      painter: HorizontalLinesForSettingsButton(),
                      child: Container(
                        color: Colors
                            .transparent, // Container color inside CircleAvatar
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Experience our services and messaging",
                style: TextStyle(
                    fontFamily: 'Plus_Jakarta_Sans',
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth / 16.538),
              ),
            ),
            const SearchBarApp(searchHintText: 'Services',),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: screenWidth,
              height: screenHeight - 321,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Popular Features",
                                style: TextStyle(
                                    fontFamily: 'Plus_Jakarta_Sans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth / 23.88),
                              )),
                          const Spacer(),
                          Text(
                            "View all",
                            style: TextStyle(
                                fontFamily: 'Plus_Jakarta_Sans',
                                fontSize: screenWidth / 35.833),
                          ),
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFFFE9900), // Start color
                                  Color(0xFFFFBE00), // End color
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ).createShader(bounds);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              size: screenWidth / 21.5,
                              // Set the desired icon size
                              color: Colors
                                  .white, // This color will be replaced by the gradient
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          HomeScreenPopularFeaturesCircles(
                            startColor: const Color(0xFFFF9598),
                            endColor: const Color(0xFFFF70A7),
                            imagePaddingValue: screenWidth / 23,
                            radiusSize: screenWidth / 11,
                            imagePath: "assets/images/Lotus.png",
                            featureName: "BEAUTY",
                          ),
                         const Spacer(),
                          HomeScreenPopularFeaturesCircles(
                              startColor: const Color(0xFF19E5A5),
                              endColor: const Color(0xFF15BD92),
                              imagePaddingValue: screenWidth / 23,
                              radiusSize: screenWidth / 11,
                              imagePath: "assets/images/Carpenter.png",
                            featureName: "CARPENTER",),
                         const  Spacer(),
                          InkWell(
                            onTap: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> const Services()));
                            },
                            child: HomeScreenPopularFeaturesCircles(
                                startColor: const Color(0xFFFFC06F),
                                endColor: const Color(0xFFFE9900),
                                imagePaddingValue: screenWidth / 23,
                                radiusSize: screenWidth / 11,
                                imagePath: "assets/images/Brush.png",
                              featureName: "BRUSH",),
                          ),
                          const Spacer(),
                          HomeScreenPopularFeaturesCircles(
                              startColor: const Color(0xFF4DB7FF),
                              endColor: const Color(0xFF3E7DFF),
                              imagePaddingValue: screenWidth / 23,
                              radiusSize: screenWidth / 11,
                              imagePath: "assets/images/Construction.png",
                          featureName: "CIVIL WORK",),
                        ],
                      ),
                    ),
                    const ImageSliderWithCircleIndicator(),
                   const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                        child:  Text("All Services",
                         style:  TextStyle(
                              fontFamily: 'Plus_Jakarta_Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth / 23.88),
                        )),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        alignment: Alignment.center, // Center alignment for easy positioning
                        children: [
                          const Column(
                            children: [
                              Row(
                                children: [
                                  AllServicesHomeScreenTiles(
                                      serviceName: "Chowk", imagePath: 'assets/images/direction.png'),
                                  Spacer(),
                                  AllServicesHomeScreenTiles(
                                      serviceName: "Commune", imagePath: 'assets/images/persons.png'),
                                ],
                              ),
                              SizedBox(height: 20), // Add some space between rows
                              Row(
                                children: [
                                  AllServicesHomeScreenTiles(
                                      serviceName: "Emergency", imagePath: 'assets/images/siren.png'),
                                  Spacer(),
                                  AllServicesHomeScreenTiles(
                                      serviceName: "Atdoor", imagePath: 'assets/images/door.png'),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            top: screenHeight / 13, // Adjust this value to position the bubble correctly
                            left: screenWidth / 1.28, // Adjust this value for horizontal alignment
                            child: const ChatBubble(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

}
