import 'package:cloud_firestore/cloud_firestore.dart';

class RatingItem {
  RatingItem(
      {this.userId,
      this.userName,
      this.leadCount,
      this.invoicingCount,
      this.leadnvoicingCount,
      this.fullsales,
      this.raisingCount,
      this.raisingsales,
      this.raisinglost,
      this.points});

  final String userId;
  final String userName;
  final int leadCount;
  final int leadnvoicingCount;
  final int invoicingCount;
  final int fullsales;
  final int raisingCount;
  final int raisingsales;
  final int raisinglost;
  final int points;
}

class RatingModelItem {
  RatingModelItem(
      {this.id,
      this.userId,
      this.collection,
      this.name,
      this.raisingexpirationdate,
      this.houseid,
      this.leadid,
      this.createdon,
      this.createdby});

  factory RatingModelItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    String user = doc.reference.parent.path.split('/').length > 1
        ? doc.reference.parent.path.split('/')[1]
        : '';
    return RatingModelItem(
        id: doc.id,
        userId: doc.reference.parent.path.split('/').length > 1
            ? doc.reference.parent.path.split('/')[1]
            : doc.id,
        collection: doc.reference.parent.path.split('/').length > 1
            ? doc.reference.parent.path.split('/')[2]
            : 'users',
        name: data["name"] ?? '',
        raisingexpirationdate:
            data['expirationdate'] != null && data['expirationdate'] != ''
                ? DateTime.fromMillisecondsSinceEpoch(
                    (data['expirationdate']).seconds * 1000)
                : new DateTime.now(),
        createdon: data['createdon'] != null && data['createdon'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['createdon']).seconds * 1000)
            : new DateTime.now(),
        houseid: data['houseid'] ?? '',
        leadid: data['leadid'] ?? '',
        createdby: data['createdby'] != null && data['createdby'] != ''
            ? data['createdby']
            : user);
  }
  final String id;
  final String userId;
  final String collection;
  final String name;
  final String houseid;
  final String leadid;
  final DateTime raisingexpirationdate;
  final DateTime createdon;
  final String createdby;
}
