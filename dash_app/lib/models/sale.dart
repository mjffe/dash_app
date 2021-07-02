import 'package:cloud_firestore/cloud_firestore.dart';

class SaleItem {
  SaleItem(
      {this.id,
      this.name,
      this.value,
      this.date,
      this.datemonth,
      this.type,
      this.state,
      this.statereason,
      this.proposalid,
      this.proposal,
      this.house,
      this.houseid,
      this.createdon,
      this.createdby});

  factory SaleItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    String user = doc.reference.parent.path.split('/')[1];

    return SaleItem(
        id: doc.id,
        name: data['name'] ?? '',
        value: data['value'] != null ? data['value'].toDouble() : 0.0,
        date: data['date'] != null && data['date'] != ''
            ? DateTime.fromMillisecondsSinceEpoch((data['date']).seconds * 1000)
            : new DateTime.now(),
        datemonth: data['date'] != null && data['date'] != ''
            ? DateTime.fromMillisecondsSinceEpoch((data['date']).seconds * 1000)
                .month
            : new DateTime.now().month,
        type: data['type'] ?? '0',
        state: data['state'] ?? '0',
        statereason: data['statereason'] ?? '0',
        proposal: data['proposal'] ?? '',
        proposalid: data['proposalid'] ?? '',
        house: data['house'] ?? '',
        houseid: data['houseid'] ?? '',
        createdon: data['createdon'] != null && data['createdon'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['createdon']).seconds * 1000)
            : new DateTime.now(),
        createdby: data['createdby'] != null && data['createdby'] != ''
            ? data['createdby']
            : user);
  }
  final String id;
  final String name;
  final double value;
  final DateTime date;
  final int datemonth;
  final String type;
  final String state;
  final String statereason;
  final String proposalid;
  final String proposal;
  final String houseid;
  final String house;
  final DateTime createdon;
  final String createdby;
}
