import 'dart:core';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yelle/Messaging/message_bubble_ui.dart';
import 'package:yelle/Messaging/message_structure.dart';
import 'package:yelle/main.dart';
import 'package:uuid/uuid.dart';

class MessageScreenUi extends StatefulWidget {
  final String? messageReceiverImage;
  final String messageReceiverName;
  final String receiverID;

  const MessageScreenUi(
      {super.key,
      this.messageReceiverImage,
      required this.receiverID,
      required this.messageReceiverName});

  @override
  MessageScreenUiState createState() => MessageScreenUiState();
}

class MessageScreenUiState extends State<MessageScreenUi> {
  TextEditingController messageController = TextEditingController();
  late Stream<List<MessageStructure>> messageStream;

  bool isUserOnline = false;

  @override
  void initState() {
    super.initState();
    isUserOnline = true;
    messageStream = MessageStructure.getMessages(widget.receiverID);
  }

  @override
  void dispose() {
    super.dispose();
    isUserOnline = false;
    messageController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight / 12),
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
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back), // Use arrow_back icon
                    onPressed: () {
                      Navigator.pop(context); // Handles back navigation
                    },
                  ),
                  backgroundColor: Colors.transparent,
                  title: Row(children: [
                    CircleAvatar(
                      radius: screenWidth / 17,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget.messageReceiverImage ?? '',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.messageReceiverName,
                      style: TextStyle(
                          fontFamily: 'Plus_Jakarta_Sans',
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth / 25),
                    ),
                  ]),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFF8E6),
                          // Set the background color to #FFF8E6
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          // Adjust padding for better appearance
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: SizedBox(
                          height: 27,
                          width: screenWidth / 4.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.black,
                                size: screenWidth / 24,
                              ),
                              // Phone icon on the left
                              const SizedBox(width: 5),
                              // Space between icon and text
                              const Text(
                                "Contact",
                                style: TextStyle(
                                  color: Colors.black, // Text color
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          StreamBuilder(
              stream: messageStream,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text("Loading"));
                } else if (snapshot.hasError) {
                 // print(snapshot.error.toString());
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      scrollDirection: Axis.vertical,
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return MessageBubbleUi(
                            messageStructure: snapshot.data[index]);
                      },
                    ),
                  );
                }
              }),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 50),
            child: Row(
              children: [
                SizedBox(width: screenWidth - 100, child: createMessageInput()),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () async {
                      if (messageController.text.trim().isEmpty) {
                       messageController.clear();
                        return;
                      }
                      var uuid = const Uuid();
                      String messageId = uuid.v4();
                      DateTime currentDate = DateTime.now();
                      Timestamp timestamp = Timestamp.fromDate(currentDate);
                      var message = MessageStructure(
                          messageId,
                          FirebaseAuth.instance.currentUser!.uid,
                          widget.receiverID,
                          timestamp,
                          true,
                          isUserOnline,
                          [],
                          messageController.text);
                      messageController.clear();
                      await MessageStructure.sendMessage(message);
                    },
                    child: createSendMessageButton()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createSendMessageButton() {
    return Container(
      width: screenWidth / 8,
      height: screenWidth / 8,
      decoration: const BoxDecoration(
        shape: BoxShape.circle, // Circular shape
        gradient: LinearGradient(
          colors: [
            Color(0xFFFE9900), // Start color
            Color(0xFFFFBE00), // End color
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: CircleAvatar(
          radius: screenWidth / 10,
          backgroundColor: Colors.transparent,
          child: Image.asset(
            'assets/images/sendMessage.png',
            width: screenWidth / 18,
            height: screenWidth / 18,
          )),
    );
  }

  Widget createMessageInput() {
    return TextFormField(
      controller: messageController,
      minLines: 1,
      maxLines: 15,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mic),
          hintText: 'Type message...',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
                color: Colors.transparent), // Make enabled border transparent
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.transparent,
              // Make focused border transparent
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.7),
          // Slightly transparent white background
          suffixIcon: const Icon(Icons.attachment)),
      onChanged: (value) {
        // Handle search query changes
      },
    );
  }
}
