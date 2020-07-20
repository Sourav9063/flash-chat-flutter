import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static getUserByName(String username) async {
    return await Firestore.instance
        .collection('users')
        .where('name', isEqualTo: username)
        .getDocuments();
  }

  static uploadUserData(String user, String email) async {
    await Firestore.instance
        .collection('users')
        .document()
        .setData({'name': user, 'email': email});
  }
}
