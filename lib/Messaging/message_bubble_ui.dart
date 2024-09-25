import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yelle/Messaging/message_structure.dart';
import 'package:yelle/main.dart';

class MessageBubbleUi extends StatelessWidget {
  final MessageStructure messageStructure;

  const MessageBubbleUi({super.key, required this.messageStructure});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          messageStructure.senderID == FirebaseAuth.instance.currentUser!.uid
              ? EdgeInsets.only(top: 30, right: 20, left: screenWidth / 7)
              : EdgeInsets.only(right: screenWidth / 2.8, left: 10),
      child: Container(
        width: screenWidth,
        decoration: BoxDecoration(
          color: messageStructure.senderID ==
                  FirebaseAuth.instance.currentUser!.uid
              ? const Color(0xFFFFE496) // Color for sent messages
              : Colors.white, // Color for received messages
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15), // Round top-left corner
            topRight: const Radius.circular(15), // Round top-right corner
            bottomLeft: messageStructure.senderID ==
                    FirebaseAuth.instance.currentUser!.uid
                ? const Radius.circular(
                    15) // Round bottom-left corner for sent messages
                : Radius.zero, // No rounding for received messages
            bottomRight: messageStructure.senderID ==
                    FirebaseAuth.instance.currentUser!.uid
                ? Radius.zero // No rounding for sent messages
                : const Radius.circular(
                    15), // Round bottom-right corner for received messages
          ),
        ),
        padding: const EdgeInsets.all(15), // Add padding inside the bubble
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Message text
            Text(
              messageStructure.message,
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                color: Colors.black,
                fontSize: screenWidth / 30,
              ),
            ),
            const SizedBox(height: 5),
            // Small gap between the message and the timestamp
            // Timestamp
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: SvgPicture.asset(
                    'assets/svg/messageTick.svg',
                    height: screenWidth/43, // You can set height and width
                    width: screenWidth/43,
                    colorFilter: ColorFilter.mode(
                      messageStructure.isRead ? Colors.lightBlue[400]! : Colors.black38, // The color you want to apply
                      BlendMode.srcIn, // Blend mode to replace the color in the SVG
                    ),
                  ),
                ),
                Text(
                  MessageStructure.formatTimestamp(messageStructure.timestamp),
                  // Function to format timestamp
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Colors.grey[600],
                    // Light grey color for the timestamp
                    fontSize:
                        screenWidth / 40, // Smaller font size for the timestamp
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
