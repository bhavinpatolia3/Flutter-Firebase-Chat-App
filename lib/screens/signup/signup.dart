import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notification/screens/chatscreen/chatscreen.dart';
import 'package:firebase_notification/screens/signin.dart/login.dart';
import 'package:firebase_notification/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  final GoogleAuthProvider _googleSignIn = GoogleAuthProvider();
  final db = Firestore.instance;

  @override
  void initState() {
    super.initState();

    _messaging.getToken().then((token) {
      print(token);
    });
  }

  String _emailsignup, _passwordsignup, _username;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_color,
        title: Center(child: Text('Sign up')),
      ),
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            username(),
            email(),
            password(),
            signunbutton(),
            signinbutton(),
          ],
        ),
      ),
    );
  }

  Widget username() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_circle,
          ),
          hintText: "Username",
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
        validator: (signupinput) {
          if (signupinput.length < 4) {
            return 'Please Enter user name';
          }
        },
        onSaved: (signupinput) => _username = signupinput,
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
        validator: (signupinput) {
          if (!signupinput.contains('@')) {
            return 'Please Enter Email';
          }
        },
        onSaved: (signupinput) => _emailsignup = signupinput,
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
        validator: (signupinput) {
          if (signupinput.length < 6) {
            return 'Please Enter at list 6 character';
          }
        },
        onSaved: (signupinput) => _passwordsignup = signupinput,
      ),
    );
  }

  Widget signunbutton() {
    return RaisedButton(
      color: primary_color,
      child: Text(
        'Sign up',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: signup,
    );
  }

  Widget signinbutton() {
    return RaisedButton(
      color: primary_color,
      child: Text(
        'Already Have an account? Login',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => SignIn()));
      },
    );
  }

  Future<void> signup() async {
    final formstate = formkey.currentState;

    if (formstate.validate()) {
      formstate.save();

      FirebaseUser user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailsignup, password: _passwordsignup);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ChatScreen(
                user: user,
                username: _username,
              ),
        ),
      );

      formstate.reset();
      print(user.uid);

      db.collection("users").add({
        "username": _username,
        "email": _emailsignup,
        'userid': user.uid,
      }).then((val) {
        print("sucess");
      }).catchError((err) {
        print(err);
      });

      setState(() {});
    }
  }
}
