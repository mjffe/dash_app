import 'package:cloud_firestore/cloud_firestore.dart';

class RatingItem {
  RatingItem(
      {this.userId,
      this.userName,
      this.invoicingCount,
      this.fullsales,
      this.raisingCount,
      this.raisingsales,
      this.points});

  final String userId;
  final String userName;
  final int invoicingCount;
  final int fullsales;
  final int raisingCount;
  final int raisingsales;
  final int points;
}

class RatingModelItem {
  RatingModelItem(
      {this.id,
      this.userId,
      this.collection,
      this.name,
      this.houseid,
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
        createdon: data['createdon'] != null && data['createdon'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['createdon']).seconds * 1000)
            : new DateTime.now(),
        houseid: data['houseid'] ?? '',
        createdby: data['createdby'] != null && data['createdby'] != ''
            ? data['createdby']
            : user);
  }
  final String id;
  final String userId;
  final String collection;
  final String name;
  final String houseid;
  final DateTime createdon;
  final String createdby;
}
