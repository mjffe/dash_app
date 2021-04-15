import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/piechart.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PieChartViewModel {
  PieChartViewModel({@required this.userId});
  final String userId;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /// returns the entire movies list with user-favourite information
  Stream<PieChartItem> moviesUserFavouritesStream() {
    return Rx.combineLatest4(
        users.doc(userId).collection('servicepresentation').snapshots(),
        users.doc(userId).collection('mediationcontract').snapshots(),
        users.doc(userId).collection('proposal').snapshots(),
        users.doc(userId).collection('promisebuysell').snapshots(),
        (QuerySnapshot servicepresentation, QuerySnapshot mediationcontract,
            QuerySnapshot proposal, QuerySnapshot promisebuysell) {
      return PieChartItem(
          apsCount: servicepresentation.size,
          cmiCount: mediationcontract.size,
          cpvcCount: promisebuysell.size,
          propostasCount: proposal.size);
    });
  }
}
