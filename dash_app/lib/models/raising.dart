import 'package:cloud_firestore/cloud_firestore.dart';

class RaisingItem {
  RaisingItem({this.id, this.name, this.createdon});

  factory RaisingItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return RaisingItem(
      id: doc.id,
      name: data['name'] ?? '',
      createdon: data['createdon'] ?? new DateTime.now(),
    );
  }
  final String id;
  final String name;
  final DateTime createdon;
}
