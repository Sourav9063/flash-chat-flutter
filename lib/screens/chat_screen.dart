import 'package:flash_chat/Components/ChatBubbles.dart';
import 'package:flash_chat/screens/chatRoom.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_scrn';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Firestore _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  DateTime now = DateTime.now();

  final msgTextController = TextEditingController();
  String msgTxt;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    print(now);
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        loggedInUser = user;
        // print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMsg() async {
  //   final messages = await _firestore.collection('messages').getDocuments();

  //   for (var message in messages.documents) {
  //     print(message.data);
  //   }
  // }

  void msgStream() async {
    await for (var snapshots in _firestore
        .collection('messages')
        .orderBy('time')
        .limit(50)
        .snapshots()) {
      for (var message in snapshots.documents) {
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDaC0C0),
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                // _auth.signOut();
                // Navigator.pop(context);

                Navigator.pushNamed(context, ChatRoom.id);

                msgStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Color(0xff600010),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MsgStream(
              firestore: _firestore,
            ),
            Container(
              padding: EdgeInsets.all(6),
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: TextField(
                      controller: msgTextController,
                      onChanged: (value) {
                        msgTxt = value;
                      },
                      onSubmitted: (value) {
                        now = DateTime.now();

                        msgTextController.clear();
                        _firestore.collection('messages').document().setData({
                          'text': msgTxt,
                          'sender': loggedInUser.email,
                          'time': now
                        });
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 55,
                      child: FlatButton(
                          color: Colors.blueAccent.shade400,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue, width: 6),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          onPressed: () {
                            now = DateTime.now();

                            msgTextController.clear();
                            _firestore.collection('messages').add({
                              'text': msgTxt,
                              'sender': loggedInUser.email,
                              'time': now
                            });
                          },
                          child: Icon(
                            Icons.send,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
