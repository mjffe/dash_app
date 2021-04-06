import 'package:cloud_firestore/cloud_firestore.dart';

class ProposalItem {
  ProposalItem({this.id, this.name, this.createdon});

  factory ProposalItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return ProposalItem(
      id: doc.id,
      name: data['name'] ?? '',
      createdon: data['createdon'] ?? new DateTime.now(),
    );
  }
  final String id;
  final String name;
  final DateTime createdon;
}
