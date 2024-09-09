import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:yelle/main.dart';

class ImageSliderWithCircleIndicator extends StatefulWidget {

  const ImageSliderWithCircleIndicator({
    super.key,
  });

  @override
  ImageSliderWithCircleIndicatorState createState() => ImageSliderWithCircleIndicatorState();
}

class ImageSliderWithCircleIndicatorState extends State<ImageSliderWithCircleIndicator> {
  final List<String> images = ["assets/images/happy_lady_with_flowers.png", "assets/images/lady_with_flowers_smelling.png", "assets/images/pretty_lady.png"];
  final _currentPageNotifier = ValueNotifier<int>(1);

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.white,
              width: screenWidth - 20,
              height: screenHeight/6,
              child: PageView.builder(
                onPageChanged: (page) {
                  setState(() {
                    _currentPageNotifier.value = page;
                  });
                },
                itemCount: images.length,
                itemBuilder: (context, index) {
                  String imageUrl = images[index];
                  return buildImageWidget(imageUrl);
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        circleIndicator()
      ],
    );
  }

  Widget buildImageWidget(String imagePath) {
    return FittedBox(
      fit: BoxFit.cover,
      child: Image.asset(
        imagePath,
      ),
    );
  }

  Widget circleIndicator() {
    return CirclePageIndicator(
      selectedDotColor: Colors.black,
      dotColor: Colors.grey,
      size: screenWidth/45,
      selectedSize: screenWidth/40,
      itemCount: images.length,
      currentPageNotifier: _currentPageNotifier,
    );
  }
}
