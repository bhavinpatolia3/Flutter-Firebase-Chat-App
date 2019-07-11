import 'package:firebase_notification/data/recieverdata.dart';
import 'package:firebase_notification/screens/chatbody/chatbody.dart';
import 'package:firebase_notification/theme/color.dart';
import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  final RecieverData data;

  AppName({this.data});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: chatbody,
        centerTitle: true,
        leading: IconButton(
          highlightColor: Colors.transparent,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '${data.name}',
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w400),
        ),
      ),
      body: ChatBody(data: data.name),
    );
  }
}
