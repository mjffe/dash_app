import 'package:cloud_firestore/cloud_firestore.dart';

class MediationContractItem {
  MediationContractItem({this.id, this.name, this.createdon, this.createdby});

  factory MediationContractItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    String user = doc.reference.parent.path.split('/')[1];

    return MediationContractItem(
        id: doc.id,
        name: data['name'] ?? '',
        createdon: data['createdon'] != null && data['createdon'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['createdon']).seconds * 1000)
            : new DateTime.now(),
        createdby: user ?? '');
  }
  final String id;
  final String name;
  final DateTime createdon;
  final String createdby;
}
