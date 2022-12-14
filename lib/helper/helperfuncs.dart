// ignore_for_file: await_only_futures, avoid_print

import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUsernameKey = "USERNAME";
  static String sharedPreferenceUserEmailKey = "USEREMAIL";

  // saving data to Shared Prefs
  static saveUserLoggedInSharedPrefference(bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
    //print("user is logged in : $isUserLoggedIn");
  }

  static saveUsernameSharedPrefference(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(sharedPreferenceUsernameKey, username);
  }

  static saveUserEmailSharedPrefference(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(sharedPreferenceUserEmailKey, email);
  }

  // get data from Shared Prefs

  static Future<bool> getUserLoggedInSharedPrefference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = await prefs.getBool(sharedPreferenceUserLoggedInKey)!;
    print("The prefs login get status : $loggedIn");
    return loggedIn;
  }

  static Future<String> getUsernameSharedPrefference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = await prefs.getString(sharedPreferenceUsernameKey)!;
    print("The prefs username get status : $username");
    return username;
  }

  static Future<String> getUserEmailSharedPrefference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = await prefs.getString(sharedPreferenceUserEmailKey)!;
    print("The prefs email get status : $email");
    return email;
  }
}
