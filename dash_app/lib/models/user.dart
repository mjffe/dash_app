import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUser {
  FirebaseUser(this.uid);

  final String uid;
}

class UserData {
  final String uid;
  final String name;
  // final String sugars;
  // final int strength;
  final List<dynamic> consultants;
  final String role;

  UserData({this.uid, this.name, this.role, this.consultants});

  factory UserData.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    //KC5XZqeOoict0UgyEInAnj097D33
    try {
      return UserData(
        uid: doc.id,
        name: doc.data()['name'] ?? '',
        consultants: doc.data()['consultants'] ?? '',
        role: doc.data()['role'] ?? '',
        // strength: doc.data()['strength'] ?? 0,
        // sugars: doc.data()['sugars'] ?? '0',
      );
    } catch (e) {
      print("UserData ${e}");
      return UserData();
    }
  }
}
