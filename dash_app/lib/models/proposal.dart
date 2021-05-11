import 'package:cloud_firestore/cloud_firestore.dart';

class ProposalItem {
  ProposalItem(
      {this.id,
      this.name,
      this.value,
      this.state,
      this.createdon,
      this.createdby});

  factory ProposalItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    String user = doc.reference.parent.path.split('/')[1];

    return ProposalItem(
        id: doc.id,
        name: data['name'] ?? '',
        value: data['value'] ?? 0,
        state: data['state'] ?? '0',
        createdon: data['createdon'] != null && data['createdon'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['createdon']).seconds * 1000)
            : new DateTime.now(),
        createdby: user ?? '');
  }
  final String id;
  final String name;
  final int value;
  final String state; //'0'-> draft '1'-> lost '2'-> won
  final DateTime createdon;
  final String createdby;
}
