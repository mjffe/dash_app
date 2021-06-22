import 'package:cloud_firestore/cloud_firestore.dart';

class ProposalItem {
  ProposalItem(
      {this.id,
      this.name,
      this.value,
      this.state,
      this.house,
      this.houseid,
      this.createdon,
      this.createdby});

  factory ProposalItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    String user = doc.reference.parent.path.split('/')[1];

    return ProposalItem(
        id: doc.id,
        name: data['name'] ?? '',
        value: data['value'] != null ? data['value'].toDouble() : 0.0,
        state: data['state'] ?? '0',
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
  final String state; //'0'-> draft '1'-> lost '2'-> won
  final String houseid;
  final String house;
  final DateTime createdon;
  final String createdby;
}
