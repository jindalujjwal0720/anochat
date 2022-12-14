// ignore_for_file: prefer_const_constructors, unnecessary_new, avoid_unnecessary_containers

import 'package:anochatapp/helper/authenticate.dart';
import 'package:anochatapp/services/auth.dart';
import 'package:flutter/material.dart';

appBarMain(BuildContext context) {
  AuthMethods authMethods = new AuthMethods();
  return AppBar(
    backgroundColor: Color(0xff343d52),
    elevation: 0,
    shadowColor: Colors.white,
    title: Image.asset(
      "assets/images/anochat.png",
      height: 20,
    ),
    actions: [
      IconButton(
        onPressed: (() {
          authMethods.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Authenticate()));
        }),
        icon: Icon(Icons.exit_to_app),
      )
    ],
  );
}

InputDecoration textFieldInputDecoration({String hintText = ""}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white54,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  );
}

TextStyle normalTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}

TextStyle smallTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 15,
  );
}

TextStyle mediumTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
  );
}

Widget messageTile(String message, time) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0x20ffffff),
      borderRadius: BorderRadius.circular(5),
    ),
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
    margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          style: smallTextStyle(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${DateTime.fromMillisecondsSinceEpoch(time).hour % 12}:${DateTime.fromMillisecondsSinceEpoch(time).minute}",
              style: TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
