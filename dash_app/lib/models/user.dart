import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';

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
  final DateTime filterDateRangeStart;
  final DateTime filterDateRangeEnd;

  UserData(
      {this.uid,
      this.name,
      this.role,
      this.consultants,
      this.filterDateRangeStart,
      this.filterDateRangeEnd});

  factory UserData.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    //KC5XZqeOoict0UgyEInAnj097D33
    try {
      return UserData(
        uid: doc.id,
        name: doc.data()['name'] ?? '',
        consultants: doc.data()['consultants'] ?? [],
        role: doc.data()['role'] ?? '',
        filterDateRangeStart: data['filterDateRangeStart'] != null &&
                data['filterDateRangeStart'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['filterDateRangeStart']).seconds * 1000)
            : new DateTime(DateTime.now().year, 1, 1),
        filterDateRangeEnd: data['filterDateRangeEnd'] != null &&
                data['filterDateRangeEnd'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['filterDateRangeEnd']).seconds * 1000)
            : new DateTime(DateTime.now().year, 12, 31),
        // strength: doc.data()['strength'] ?? 0,
        // sugars: doc.data()['sugars'] ?? '0',
      );
    } catch (e) {
      print("UserData ${e}");
      return UserData();
    }
  }
}
