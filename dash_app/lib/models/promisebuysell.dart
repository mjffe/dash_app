import 'package:cloud_firestore/cloud_firestore.dart';

class PromiseBuySellItem {
  PromiseBuySellItem({this.id, this.name, this.createdon});

  factory PromiseBuySellItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return PromiseBuySellItem(
        id: doc.id,
        name: data['name'] ?? '',
        createdon: data['createdon'] != null && data['createdon'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['createdon']).seconds * 1000)
            : new DateTime.now());
  }
  final String id;
  final String name;
  final DateTime createdon;
}
