import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ChatBody extends StatefulWidget {
  final String data;
  final FirebaseUser user;
  ChatBody({this.data, this.user});

  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  final FirebaseMessaging _message = FirebaseMessaging();
  List allData = [];
  String datetime;
  TextEditingController _controller = TextEditingController();
  int userid = 1;
  final db = Firestore.instance;

  @override
  void initState() {
    super.initState();

    _message.getToken().then((token) {});
  }

  void onSubmit(String input) {
    _controller.clear();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy kk:mm').format(now);

    db.collection("messages").add({
      "to": widget.data,
      'senderid': userid,
      "text": input,
      "time": formattedDate,
      //'messagetoken' : token,
    }).then((val) {
      print("sucess");
    }).catchError((err) {
      print(err);
    });

    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: chatbody,
        ),
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection("messages")
                    .orderBy("time", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (BuildContext context, index) {
                        DocumentSnapshot document =
                            snapshot.data.documents[index];
                        if (snapshot.data.documents == null)
                          return CircularProgressIndicator();
                        if (userid == document['senderid']) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: send(document['text'],
                                'Sent ${document['time'].toString()}'),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: reciverata(
                                document['text'], 'Sent ${document['time']}'),
                          );
                        }
                      },
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 1.0, color: primary_color)],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  cursorColor: primary_color,
                  controller: _controller,
                  onSubmitted: onSubmit,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Answer...',
                    hintStyle: TextStyle(
                        color: timecolor, fontSize: 20.0, height: 1.5),
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.attach_file,
                        size: 30.0,
                        color: primary_color,
                      ),
                      onPressed: () {},
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 45.0,
                        width: 45.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(blurRadius: 5.0, color: primary_color)
                          ],
                          color: primary_color,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: IconButton(
                          alignment: Alignment.center,
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () => onSubmit(_controller.text),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reciverata(String receiver, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 2.0, color: timecolor)],
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: new Text(
                receiver,
                style: TextStyle(
                  color: timecolor,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                time,
                style: TextStyle(color: timecolor),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget send(String send, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 2.0, color: primary_color)],
                color: primary_color,
                borderRadius: BorderRadius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                child: new Text(
                  send,
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                time,
                style: TextStyle(color: timecolor),
              )
            ],
          ),
        )
      ],
    );
  }
}
