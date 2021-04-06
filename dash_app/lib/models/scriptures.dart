import 'package:cloud_firestore/cloud_firestore.dart';

class ScripturesItem {
  ScripturesItem({this.id, this.name, this.createdon, this.date});

  factory ScripturesItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return ScripturesItem(
      id: doc.id,
      name: data['name'] ?? '',
      date: data['date'] ?? new DateTime.now(),
      createdon: data['createdon'] ?? new DateTime.now(),
    );
  }
  final String id;
  final String name;
  final DateTime createdon;
  final DateTime date;
}
