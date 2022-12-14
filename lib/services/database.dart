// ignore_for_file: avoid_print, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUserEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print("The error is : $e");
    });
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap).catchError((e) {
      print("The error is : $e");
    });
  }

  sendGlobalChatMessage(String globalChatroomId, messageMap) {
    FirebaseFirestore.instance
        .collection("globalChatRooms")
        .doc(globalChatroomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print("The error in sendGlobalChatMessage: $e");
    });
  }

  getGlobalChatMessages(String globalChatroomId) async {
    Stream chatSnapshot = await FirebaseFirestore.instance
        .collection("globalChatRooms")
        .doc(globalChatroomId)
        .collection("chats")
        .orderBy("timestamp", descending: true)
        .snapshots();
    return chatSnapshot;
  }
}
