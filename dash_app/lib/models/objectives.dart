import 'package:cloud_firestore/cloud_firestore.dart';

class ObjectiveItem {
  ObjectiveItem(
      {this.id,
      this.name,
      this.createdon,
      this.value,
      this.date,
      this.datemonth});

  factory ObjectiveItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return ObjectiveItem(
      id: doc.id,
      name: data['name'] ?? '',
      createdon: data['createdon'] != null && data['createdon'] != ''
          ? DateTime.fromMillisecondsSinceEpoch(
              (data['createdon']).seconds * 1000)
          : new DateTime.now(),
      value: data['value'] ?? 0,
      date: data['date'] != null && data['date'] != ''
          ? DateTime.fromMillisecondsSinceEpoch((data['date']).seconds * 1000)
          : new DateTime.now(),
      datemonth: data['date'] != null && data['date'] != ''
          ? DateTime.fromMillisecondsSinceEpoch((data['date']).seconds * 1000)
              .month
          : new DateTime.now().month,
    );
  }
  final String id;
  final String name;
  final DateTime createdon;
  final double value;
  final DateTime date;
  final int datemonth;
}
