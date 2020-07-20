import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Components/dataBase.dart';

import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'src_scrn';
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool hidee = false;
  String search;
  String name = 'Name';
  String email = 'Email';
  QuerySnapshot searchSnapshot;

  // List<Card> listCard = [];

  initiateSrc(String src) async {
    await Database.getUserByName(src).then((val) {
      // print(val.toString());

      setState(() {
        searchSnapshot = val;
      });
    });

    try {
      if (searchSnapshot != null) {
        name = searchSnapshot.documents[0].data['name'];
        email = searchSnapshot.documents[0].data['email'];
        hidee = true;
      } else {}
    } catch (e) {
      hidee = true;
      name = 'Not Found';
      email = 'Try to be specific';
    }
  }

  // Card listCardItems(QuerySnapshot data, int n) {
  //   return Card(
  //     color: Colors.white70,
  //     child: ListTile(
  //       title: Text(data.documents[n].data['name']),
  //       subtitle: Text(data.documents[n].data['email']),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade700,
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(6),
              decoration: kMessageContainerDecoration.copyWith(
                  color: Colors.lightBlueAccent),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: TextField(
                      onChanged: (value) {
                        search = value;
                        hidee = false;
                      },
                      onSubmitted: (value) {
                        initiateSrc(search);
                        hidee = true;
                      },
                      decoration: kMessageTextFieldDecoration.copyWith(
                          hintText: 'Username or Email'),
                    ),
                  ),
                  Expanded(
                    child: Hero(
                      tag: 'src',
                      child: Container(
                        height: 55,
                        child: FlatButton(
                            color: Colors.blueAccent.shade400,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.blue, width: 6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            onPressed: () {
                              initiateSrc(search);
                            },
                            child: Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: hidee ? 1 : 0,
              child: Card(
                color: Colors.white70,
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, ChatScreen.id);
                  },
                  leading: Icon(
                    Icons.account_circle,
                    size: 55,
                  ),
                  title: Text(name),
                  subtitle: Text(email),
                  trailing: Icon(Icons.send),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
