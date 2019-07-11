import 'package:firebase_notification/screens/signup/signup.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SignUp(),
      ),
    );
  }
}
