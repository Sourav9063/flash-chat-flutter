import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/chat_screen.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MsgStream extends StatelessWidget {
  const MsgStream({
    Key key,
    @required Firestore firestore,
  })  : _firestore = firestore,
        super(key: key);

  final Firestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, snapshot) {
        if (snapshot.hasData == false) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        print(snapshot);
        final messages = snapshot.data.documents.reversed;
        List<Widget> messageBubbles = [];
        for (var msg in messages) {
          final msgText = msg.data['text'];
          final msgSender = msg.data['sender'];
          final msgTime = msg.data['time'];
          final currentUser = loggedInUser.email;

          final messageBubble = MsgBubble(
            sender: msgSender,
            text: msgText,
            msgTime: msgTime,
            isme: currentUser == msgSender ? true : false,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
            child: ListView(
          reverse: true,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          children: messageBubbles,
        ));
      },
      stream: _firestore.collection('messages').snapshots(),
    );
  }
}

class MsgBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isme;
  final Timestamp msgTime;

  const MsgBubble({Key key, this.sender, this.text, this.isme, this.msgTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bubbleColor = isme ? Colors.pinkAccent.shade400 : Color(0xff981830);
    DateTime time = msgTime.toDate();
    String timeJm = DateFormat.jm().format(time);
    String monDate = DateFormat.MMMd().format(time);
    // String timeString = time.toString().substring(8);
    // List<String> months = [
    //   'jan',
    //   'feb',
    //   'mar',
    //   'apr',
    //   'may',
    //   'jun',
    //   'jul',
    //   'aug',
    //   'sep',
    //   'oct',
    //   'nov',
    //   'dec'
    // ];
    // int date = time.day;
    // int month = time.month;
    // int hour = time.hour;
    // hour = hour > 12 ? hour - 12 : hour;
    // hour = hour == 0 ? 12 : hour;
    // String pmam = time.hour > 12 ? 'PM' : 'AM';
    // int min = time.minute;
    return Column(
      crossAxisAlignment:
          isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$sender\n ',
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
        Center(
          child: Text('$monDate $timeJm'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: isme ? Radius.circular(30) : Radius.circular(0),
                topRight: Radius.circular(30),
                bottomRight: isme ? Radius.circular(0) : Radius.circular(30)),
            color: bubbleColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '$text',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
