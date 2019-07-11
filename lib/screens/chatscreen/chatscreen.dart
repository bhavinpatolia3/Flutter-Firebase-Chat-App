import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notification/data/recieverdata.dart';
import 'package:firebase_notification/screens/widgets/appbar/appbar.dart';
import 'package:firebase_notification/screens/widgets/tabbar/tabbar.dart';

import 'package:firebase_notification/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class ChatScreen extends StatefulWidget {
  final String username;
  final FirebaseUser user;
  ChatScreen({Key key, this.user, this.username}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final db = Firestore.instance;
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
              height: 200.0,
              width: double.infinity,
              child: Image(
                colorBlendMode: BlendMode.darken,
                color: Colors.black45,
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/images/image/images (1).jfif',
                ),
              )),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  onPressed: () {},
                )
              ],
            ),
            body: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 40.0, left: 50.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://randomuser.me/api/portraits/men/41.jpg',
                            scale: 20.0),
                        maxRadius: 40.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                    ),
                    Container(
                      height: 120.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${widget.user.email}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: textcolor,
                              fontSize: 23.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                          ),
                          Text(
                            '@${widget.user.email.substring(0, 5)}',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: textcolor,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 80.0,
                  color: chatbody,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '520',
                                style:
                                    TextStyle(color: textcolor, fontSize: 20.0),
                              ),
                              Text(
                                'Tweets',
                                style:
                                    TextStyle(color: textcolor, fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                        width: 136.5,
                        color: primary_color,
                      ),
                      Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '23114',
                                style:
                                    TextStyle(color: textcolor, fontSize: 20.0),
                              ),
                              Text(
                                'Followers',
                                style:
                                    TextStyle(color: textcolor, fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                        width: 136.5,
                        color: primary_color,
                      ),
                      Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '520',
                                style:
                                    TextStyle(color: textcolor, fontSize: 20.0),
                              ),
                              Text(
                                'Following',
                                style:
                                    TextStyle(color: textcolor, fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                        width: 136.5,
                        color: primary_color,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: VerticalTabs(
                    itemExtent: 100.0,
                    tabsShadowColor: primary_color,
                    tabsElevation: 10.0,
                    indicatorWidth: 0.0,
                    selectedTabBackgroundColor: Colors.grey[300],
                    tabsWidth: 80,
                    tabs: <Tab>[
                      Tab(
                        child: TabButton(
                          icon:
                              Icon(Icons.people_outline, color: primary_color),
                        ),
                      ),
                      Tab(
                        child: TabButton(
                          icon: Icon(
                            Icons.chat_bubble,
                            color: primary_color,
                          ),
                        ),
                      ),
                      Tab(
                        child: TabButton(
                          icon: Icon(
                            Icons.call_to_action,
                            color: primary_color,
                          ),
                        ),
                      ),
                      Tab(
                        child: TabButton(
                          icon: Icon(
                            Icons.note_add,
                            color: primary_color,
                          ),
                        ),
                      ),
                    ],
                    contents: <Widget>[
                      Container(
                          child:
                              Container(child: contactView(), color: chatbody)),
                      Container(child: chatView(), color: chatbody),
                      Container(child: Text(''), color: chatbody),
                      Container(child: Text(''), color: chatbody),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chatView() {
    return ListView.builder(
      itemCount: recievermessages.length,
      itemBuilder: (BuildContext context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(recievermessages[index].userimage),
          ),
          title: Text(
            recievermessages[index].name,
            style: TextStyle(fontSize: 16.0),
          ),
          subtitle: Text(
            recievermessages[index].message,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: timecolor, fontSize: 14.0),
          ),
          trailing: Text(
            recievermessages[index].time,
            style: TextStyle(color: timecolor),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppName(
                      data: recievermessages[index],
                    ),
              ),
            );
          },
        );
      },
    );
  }

  Widget contactView() {
    return ListView.builder(
        itemCount: recievermessages.length,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(recievermessages[index].userimage),
            ),
            title: Text(
              recievermessages[index].name,
              style: TextStyle(fontSize: 16.0),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AppName(data: recievermessages[index])));
            },
          );
        });
  }
}
