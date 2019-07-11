import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notification/screens/chatscreen/chatscreen.dart';
import 'package:firebase_notification/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  final db = Firestore.instance;

  String _emaillogin, _passwordlogin, _usernamelogin;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary_color,
        title: Text('Login'),
      ),
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            email(),
            password(),
            signinbutton(),
          ],
        ),
      ),
    );
  }

  Widget email() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: "Email",
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primary_color, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primary_color, width: 2.0),
          ),
        ),
        keyboardType: TextInputType.text,
        validator: (inputlogin) {
          if (!inputlogin.contains('@')) {
            return 'Please Enter Email';
          }
        },
        onSaved: (inputlogin) => _emaillogin = inputlogin,
      ),
    );
  }

  Widget password() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.screen_lock_portrait),
          hintText: "Password",
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primary_color, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primary_color, width: 2.0),
          ),
        ),
        keyboardType: TextInputType.text,
        validator: (inputlogin) {
          if (inputlogin.length < 6) {
            return 'Please Enter at list 6 character';
          }
        },
        onSaved: (inputlogin) => _passwordlogin = inputlogin,
      ),
    );
  }

  Widget signinbutton() {
    return RaisedButton(
      color: primary_color,
      child: Text(
        'Login',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: signin,
    );
  }

  Future<void> signin() async {
    final formstate = formkey.currentState;

    if (formstate.validate()) {
      formstate.save();

      FirebaseUser user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emaillogin, password: _passwordlogin);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ChatScreen(
                user: user,
                username: _usernamelogin,
              ),
        ),
      );
      formstate.reset();
    }
  }
}
