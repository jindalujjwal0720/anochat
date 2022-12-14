// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print

//import 'package:anochatapp/views/signin.dart';
import 'package:anochatapp/helper/authenticate.dart';
import 'package:anochatapp/helper/helperfuncs.dart';
import 'package:anochatapp/views/homepage.dart';
//import 'package:anochatapp/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(AnoChatApp());
}

class AnoChatApp extends StatefulWidget {
  @override
  State<AnoChatApp> createState() => _AnoChatAppState();
}

class _AnoChatAppState extends State<AnoChatApp> {
  bool isUserLoggedIn = false;
  @override
  void initState() {
    getLoggedInStatus();
    super.initState();
  }

  getLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInSharedPrefference().then((value) {
      //print("the value is : $value");
      setState(() {
        isUserLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnoChat',
      theme: ThemeData(
        primaryColor: Color(0xff6699cc),
      ),
      home: isUserLoggedIn ? HomePage() : Authenticate(),
    );
  }
}
