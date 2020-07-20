import 'package:flash_chat/screens/search.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  static const String id = 'chat_Room';
  ChatRoom({Key key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Recents'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'src',
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () {
          // Navigator.push(context, PageRouteBuilder(pageBuilder:()=> SearchScreen(),transitionDuration: Duration(milliseconds: 500),),);
          // Navigator.push(context, MaterialPageRoute(builder:(context) => SearchScreen(), settings:RouteSettings()));
          Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: Duration(seconds: 1),
                      
                      pageBuilder: (_, __, ___) => SearchScreen()));
         
        },
      ),
    ));
  }
}
