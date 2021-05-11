import 'package:cloud_firestore/cloud_firestore.dart';

class InvoicingItem {
  InvoicingItem(
      {this.id,
      this.name,
      this.home,
      this.createdon,
      this.value,
      this.date,
      this.datemonth,
      this.createdby});

  factory InvoicingItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    String user = doc.reference.parent.path.split('/')[1];

    return InvoicingItem(
        id: doc.id,
        name: data['name'] ?? '',
        home: data['home'] ?? '',
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
        createdby: user ?? '');
  }
  final String id;
  final String name;
  final String home;
  final DateTime createdon;
  final DateTime date;
  final double value;
  final int datemonth;
  final String createdby;
}
