// ignore_for_file: unnecessary_new, prefer_const_constructors, avoid_unnecessary_containers, avoid_print, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:anochatapp/helper/helperfuncs.dart';
import 'package:anochatapp/services/auth.dart';
import 'package:anochatapp/services/database.dart';
import 'package:anochatapp/views/homepage.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  TextEditingController usernameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  final formKey = GlobalKey<FormState>();

  signMeUp() {
    if (formKey.currentState!.validate()) {
      Map<String, String> userMap = {
        "name": usernameTextEditingController.text,
        "email": emailTextEditingController.text
      };

      HelperFunctions.saveUserEmailSharedPrefference(
          emailTextEditingController.text);
      HelperFunctions.saveUsernameSharedPrefference(
          usernameTextEditingController.text);

      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        //print("${val.uid}");

        databaseMethods.uploadUserInfo(userMap);
        HelperFunctions.saveUserLoggedInSharedPrefference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => HomePage())));
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
                                validator: (val) {
                                  return val == null || val.length < 4
                                      ? "Username should be at least 4 letters"
                                      : null;
                                },
                                controller: usernameTextEditingController,
                                style: normalTextStyle(),
                                decoration: textFieldInputDecoration(
                                    hintText: "username"),
                              ),
                              TextFormField(
                                cursorColor: Color(0xff343d52),
                        cursorWidth: 2,
                                validator: ((val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val!)
                                      ? null
                                      : "Please enter valid email id";
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
                          onTap: (() {
                            signMeUp();
                          }),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              "Sign Up",
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
                            Text("Already have an account? ",
                                style: smallTextStyle()),
                            GestureDetector(
                              onTap: () {
                                widget.toggle();
                                print("toggle reached - sign up");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 5),
                                child: Text("Sign In",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline,
                                    )),
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
