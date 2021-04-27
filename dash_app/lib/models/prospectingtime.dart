import 'package:cloud_firestore/cloud_firestore.dart';

class ProspectingTimeItem {
  ProspectingTimeItem(
      {this.id,
      this.name,
      this.date,
      this.duration,
      this.createdon,
      this.datemonth});

  factory ProspectingTimeItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    try {
      return ProspectingTimeItem(
        id: doc.id,
        name: data['name'] ?? '',
        date: data['date'] != null && data['date'] != ''
            ? DateTime.fromMillisecondsSinceEpoch((data['date']).seconds * 1000)
            : new DateTime.now(),
        duration: data['duration'] ?? 0,
        createdon: data['createdon'] != null && data['createdon'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['createdon']).seconds * 1000)
            : new DateTime.now(),
        datemonth: data['date'] != null && data['date'] != ''
            ? DateTime.fromMillisecondsSinceEpoch((data['date']).seconds * 1000)
                .month
            : new DateTime.now().month,
      );
    } catch (e) {
      print("ProspectingTime ${e}");
      return ProspectingTimeItem();
    }
  }
  final String id;
  final String name;
  final DateTime date;
  final int datemonth;
  final double duration;
  final DateTime createdon;
}
