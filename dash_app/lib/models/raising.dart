import 'package:cloud_firestore/cloud_firestore.dart';

class RaisingItem {
  RaisingItem(
      {this.id,
      this.name,
      this.state,
      this.expirationdate,
      this.createdon,
      this.createdby});

  factory RaisingItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    String user = doc.reference.parent.path.split('/')[1];
    //print('RaisingItem: ${doc.id}');
    return RaisingItem(
        id: doc.id,
        name: data['name'] ?? '',
        state: data['state'] ?? '0',
        expirationdate:
            data['expirationdate'] != null && data['expirationdate'] != ''
                ? DateTime.fromMillisecondsSinceEpoch(
                    (data['expirationdate']).seconds * 1000)
                : new DateTime.now(),
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
  final String state; //'0'-> draft '1'-> reserved '2'-> sell '3'-> lost
  final DateTime expirationdate;
  final DateTime createdon;
  final String createdby;
}
