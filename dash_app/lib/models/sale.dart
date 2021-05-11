import 'package:cloud_firestore/cloud_firestore.dart';

class SaleItem {
  SaleItem(
      {this.id,
      this.name,
      this.value,
      this.state,
      this.proposalid,
      this.proposal,
      this.createdon,
      this.createdby});

  factory SaleItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    String user = doc.reference.parent.path.split('/')[1];

    return SaleItem(
        id: doc.id,
        name: data['name'] ?? '',
        value: data['value'] ?? 0,
        state: data['state'] ?? '0',
        proposal: data['proposal'] ?? '',
        proposalid: data['proposalid'] ?? '',
        createdon: data['createdon'] != null && data['createdon'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['createdon']).seconds * 1000)
            : new DateTime.now(),
        createdby: user ?? '');
  }
  final String id;
  final String name;
  final int value;
  final String state;
  final String proposalid;
  final String proposal;
  final DateTime createdon;
  final String createdby;
}
