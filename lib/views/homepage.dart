// ignore_for_file: prefer_const_constructors, unnecessary_new, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, non_constant_identifier_names

//import 'package:anochatapp/helper/authenticate.dart';
import 'dart:async';

import 'package:anochatapp/helper/constants.dart';
import 'package:anochatapp/helper/helperfuncs.dart';
import 'package:anochatapp/services/auth.dart';
import 'package:anochatapp/services/database.dart';
import 'package:anochatapp/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController messageTextEditingController =
      new TextEditingController();
  late Stream globalChatMessageListStream;

  @override
  void initState() {
    getUserInfo();
    getGlobalChatStream();
    super.initState();
    print("myName : ${Constants.myName}");
    print("myEmail : ${Constants.myEmail}");
  }

  getGlobalChatStream() async {
    Stream value = await databaseMethods.getGlobalChatMessages("global");
    globalChatMessageListStream = value;
    setState(() {});
    return value;
  }

  getUserInfo() async {
    String name = await HelperFunctions.getUsernameSharedPrefference();
    Constants.myName = name;
    String email = await HelperFunctions.getUserEmailSharedPrefference();
    Constants.myEmail = email;
    print("my name is ${Constants.myName} and email is ${Constants.myEmail}");
    setState(() {});
  }

  Widget globalChatMessageList(String globalChatroomId) {
    return StreamBuilder(
      stream: globalChatMessageListStream,
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: (snapshot.data as QuerySnapshot).docs.length,
          itemBuilder: (context, index) {
            return messageTile(
                (snapshot.data as QuerySnapshot).docs[index]["message"],
                (snapshot.data as QuerySnapshot).docs[index]["timestamp"]);
          },
        );
      },
    );
  }

  sendGlobalMessage(String globalChatroomId, String message) {
    if (messageTextEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": message,
        "sendByName": Constants.myName,
        "sendByEmail": Constants.myEmail,
        "timestamp": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.sendGlobalChatMessage(globalChatroomId, messageMap);
      messageTextEditingController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      backgroundColor: Color(0xff485063),
      body: Container(
        child: Stack(
          children: [
            globalChatMessageList("global"),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff5d6476),
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: Color(0xff343d52),
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageTextEditingController,
                        cursorColor: Color(0xff343d52),
                        cursorWidth: 2,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your message...",
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        // send msg to Global
                        sendGlobalMessage(
                            "global", messageTextEditingController.text);
                      }),
                      child: Container(
                        height: 24,
                        width: 24,
                        child: Icon(
                          Icons.send,
                          color: Color(0xffffffff),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/*
Widget blankHomePage(){
  return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text("Home Page"),
            IconButton(
              onPressed: (() {
                authMethods.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
              }),
              icon: Icon(Icons.exit_to_app),
            )
          ],
        ),
      );
}
*/
