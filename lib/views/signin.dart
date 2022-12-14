// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, avoid_print, unnecessary_new, file_names, avoid_unnecessary_containers

//import 'package:anochatapp/helper/authenticate.dart';
//import 'package:anochatapp/views/signup.dart';
//import 'package:anochatapp/helper/constants.dart';
import 'package:anochatapp/services/auth.dart';
import 'package:anochatapp/services/database.dart';
import 'package:anochatapp/views/homepage.dart';
import 'package:anochatapp/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/helperfuncs.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  bool isLoading = false;
  QuerySnapshot? snapshotUserInfo;
  final formKey = GlobalKey<FormState>();

  signIn() {
    if (formKey.currentState!.validate()) {
      HelperFunctions.saveUserEmailSharedPrefference(
          emailTextEditingController.text);
      setState(() {
        isLoading = true;
      });
      databaseMethods
          .getUserByUserEmail(emailTextEditingController.text)
          .then((value) {
        snapshotUserInfo = value;
        String username = snapshotUserInfo!.docs[0].get("name");
        HelperFunctions.saveUsernameSharedPrefference(username);
        HelperFunctions.saveUserEmailSharedPrefference(
            emailTextEditingController.text);
        print("my name is : $username");
      });

      authMethods
          .signInWithEmailPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        if (value != null) {
          print("User is signed in from signin : true");
          HelperFunctions.saveUserLoggedInSharedPrefference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff343d52),
      body: SafeArea(
        child: isLoading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - 50,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                cursorColor: Color(0xff343d52),
                                cursorWidth: 2,
                                validator: ((val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val!)
                                      ? null
                                      : "Please enter correct email id";
                                }),
                                controller: emailTextEditingController,
                                style: normalTextStyle(),
                                decoration:
                                    textFieldInputDecoration(hintText: "email"),
                              ),
                              TextFormField(
                                cursorColor: Color(0xff343d52),
                                cursorWidth: 2,
                                validator: (val) {
                                  return val == null || val.length < 6
                                      ? "Password should be at least 6 letters long"
                                      : null;
                                },
                                obscureText: true,
                                controller: passwordTextEditingController,
                                style: normalTextStyle(),
                                decoration: textFieldInputDecoration(
                                    hintText: "Password"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Text(
                              "Forgot Password?",
                              style: normalTextStyle(),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            signIn();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "Sign In",
                              style: mediumTextStyle(),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              gradient: LinearGradient(
                                // ignore: prefer_const_literals_to_create_immutables
                                colors: [
                                  const Color(0xff4D89FC),
                                  const Color(0xff4D89FC),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: smallTextStyle(),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                                print("reached toggle");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "Register now",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
