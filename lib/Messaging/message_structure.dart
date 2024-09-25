import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:intl/intl.dart';

class MessageStructure  {
  final String messageID;
  final String senderID;
  final String receiverID;
  final Timestamp timestamp;
  final bool isSent;
  final bool isRead;
  final List<String> images;
  final String message;

  MessageStructure(this.messageID, this.senderID, this.receiverID,
      this.timestamp, this.isSent, this.isRead, this.images, this.message);

  static Future sendMessage(MessageStructure messageObject) async {
    try {
      //send the message to the sender's sentMessages collection
      await FirebaseFirestore.instance
          .collection('usersInfo')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('sentMessages')
          .doc()
          .set(messageObject.toMap(messageObject));

      //send the message also to the receiver's receivedMessages collection
      await FirebaseFirestore.instance
          .collection('usersInfo')
          .doc(messageObject.receiverID)
          .collection('receivedMessages')
          .doc()
          .set(messageObject.toMap(messageObject));
    } on SocketException {
      //
    } catch (e) {
      rethrow;
    }
  }

  static Stream<List<MessageStructure>> getMessages(String otherUserID) {
    try {
      //get the sentMessages from our sentMessages collection of sentMessages where the receiverID matches with the current user who we are chatting with
      var sentMessagesStream = FirebaseFirestore.instance
          .collection('usersInfo')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('sentMessages')
          .where('ReceiverID', isEqualTo: otherUserID).orderBy('TimeStamp', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => toMessageStructure(doc.data()))
              .toList());

      //get the receivedMessages which is sent by the other user from our receivedMessages collection where the senderID is the other user sending the messages
      var receivedMessagesStream = FirebaseFirestore.instance
          .collection('usersInfo')
          .doc(FirebaseAuth.instance.currentUser!.uid) // Fetch from the other user's ID
          .collection('receivedMessages') // Corrected collection name
          .where('SenderID', isEqualTo: otherUserID).orderBy('TimeStamp', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => toMessageStructure(doc.data()))
              .toList());

      // Combine the two streams
      var combinedStream =  Rx.combineLatest2(sentMessagesStream, receivedMessagesStream,
          (List<MessageStructure> sentMessages,
              List<MessageStructure> receivedMessages) {
        return [...sentMessages, ...receivedMessages];

      });
      return combinedStream;

    } on SocketException {
      //
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  //convert the object to a Map
  Map<String, dynamic> toMap(MessageStructure object) {
    return {
      'MessageID': object.messageID,
      'SenderID': object.senderID,
      'ReceiverID': object.receiverID,
      'TimeStamp': object.timestamp,
      'IsSent': object.isSent,
      'IsRead': object.isRead,
      'Images': object.images,
      'Message': object.message,
    };
  }

  static MessageStructure toMessageStructure(Map<String, dynamic> snapshot) {
    return MessageStructure(
        snapshot['MessageID'],
        snapshot['SenderID'],
        snapshot['ReceiverID'],
        snapshot['TimeStamp'],
        snapshot['IsSent'],
        snapshot['IsRead'],
        (snapshot['Images'] as List<dynamic>).cast<String>(),
        snapshot['Message']);
  }

  static String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('hh:mm a').format(dateTime);
  }

  //Mark the messages seen once user opens that chat.
  Future markMessageSeen(String otherUserID) async
  {
    try {
     await FirebaseFirestore.instance
          .collection('usersInfo')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('sentMessages')
          .where('ReceiverID', isEqualTo: otherUserID)
          .get()
          .then((snapshot) {

        for (var doc in snapshot.docs) {
          doc.reference.update({'isRead': true});
        }
      });

    }
    catch (e) {
      //print(e.toString());
    }
  }


}
