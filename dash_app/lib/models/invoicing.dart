import 'package:cloud_firestore/cloud_firestore.dart';

class InvoicingItem {
  InvoicingItem(
      {this.id,
      this.name,
      this.createdon,
      this.value,
      this.date,
      this.datemonth,
      this.sale,
      this.saleid,
      this.house,
      this.houseid,
      this.createdby});

  factory InvoicingItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    String user = doc.reference.parent.path.split('/')[1];

    return InvoicingItem(
        id: doc.id,
        name: data['name'] ?? '',
        createdon: data['createdon'] != null && data['createdon'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['createdon']).seconds * 1000)
            : new DateTime.now(),
        // value: data['value'] ?? 0,
        value: data['value'] != null ? data['value'].toDouble() : 0.0,
        date: data['date'] != null && data['date'] != ''
            ? DateTime.fromMillisecondsSinceEpoch((data['date']).seconds * 1000)
            : new DateTime.now(),
        datemonth: data['date'] != null && data['date'] != ''
            ? DateTime.fromMillisecondsSinceEpoch((data['date']).seconds * 1000)
                .month
            : new DateTime.now().month,
        sale: data['sale'] ?? '',
        saleid: data['saleid'] ?? '',
        house: data['house'] ?? '',
        houseid: data['houseid'] ?? '',
        createdby: data['createdby'] != null && data['createdby'] != ''
            ? data['createdby']
            : user);
  }
  final String id;
  final String name;
  final DateTime date;
  final double value;
  final int datemonth;
  final String saleid;
  final String sale;
  final String houseid;
  final String house;
  final DateTime createdon;
  final String createdby;
}
