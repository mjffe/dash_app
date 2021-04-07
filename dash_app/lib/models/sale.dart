import 'package:cloud_firestore/cloud_firestore.dart';

class SaleItem {
  SaleItem({this.id, this.name, this.createdon, this.value});

  factory SaleItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return SaleItem(
      id: doc.id,
      name: data['name'] ?? '',
      createdon: data['createdon'] != null && data['createdon'] != ''
          ? DateTime.fromMillisecondsSinceEpoch(
              (data['createdon']).seconds * 1000)
          : new DateTime.now(),
      value: data['value'] ?? 0,
    );
  }
  final String id;
  final String name;
  final DateTime createdon;
  final int value;
}
