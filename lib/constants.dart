import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
  
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  filled: true,
  fillColor: Colors.white,
  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 4.0),
    borderRadius: BorderRadius.all(Radius.circular(50.0)),
  ),

);

const kMessageContainerDecoration = BoxDecoration(

  color: Color(0xfff85068),
  borderRadius: BorderRadius.all(Radius.circular(30))

);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,

  
  hintText: 'Enter your email',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  // border: OutlineInputBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
  // ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 4.0),
    borderRadius: BorderRadius.all(Radius.circular(50.0)),
  ),
 
);
