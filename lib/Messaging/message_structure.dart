import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class MessageStructure extends ChangeNotifier{
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

  Future sendMessage(
      String messageReceiverID, MessageStructure messageObject) async {
    try {
      //send the message to the sender's sentMessages collection
      await FirebaseFirestore.instance
          .collection('usersInfo')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('sentMessages')
          .doc()
          .update(messageObject.toMap(messageObject));

      //send the message also to the receiver's receivedMessages collection
      await FirebaseFirestore.instance
          .collection('usersInfo')
          .doc(messageReceiverID)
          .collection('receivedMessages')
          .doc()
          .update(messageObject.toMap(messageObject));
    } on SocketException {
      //
    } catch (e) {
      //
    }
  }

  Stream getMessages(String otherUserID) {

    try{
      //get the sentMessages from our sentMessages collection of sentMessages where the receiverID matches with the current user who we are chatting with
      var sentMessagesSnapshot = FirebaseFirestore.instance.collection(
          'usersInfo').doc(FirebaseAuth.instance.currentUser!.uid).collection(
          'sentMessages').where(
          'receiverID', isEqualTo: otherUserID).snapshots();
      //get the receivedMessages which is sent by the other user from our receivedMessages collection where the senderID is the other user sending the messages
      var receivedMessagesSnapshot = FirebaseFirestore.instance.collection(
          'usersInfo').doc(FirebaseAuth.instance.currentUser!.uid).collection(
          'sentMessages').where(
          'senderID', isEqualTo: otherUserID).snapshots();


      var combinedStream = Rx.combineLatest(
          [receivedMessagesSnapshot, sentMessagesSnapshot], (
          List<QuerySnapshot> snapshot) => snapshot);
      return combinedStream;
    }
    on SocketException{
      //
      rethrow;
    }
    catch(e)
    {
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
}
