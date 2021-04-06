import 'package:cloud_firestore/cloud_firestore.dart';

class ProspectingTimeItem {
  ProspectingTimeItem({this.id, this.name, this.createdon});

  factory ProspectingTimeItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return ProspectingTimeItem(
      id: doc.id,
      name: data['name'] ?? '',
      createdon: data['createdon'] ?? new DateTime.now(),
    );
  }
  final String id;
  final String name;
  final DateTime createdon;
}
