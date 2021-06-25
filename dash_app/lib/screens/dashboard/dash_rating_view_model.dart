import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/models/raising.dart';
import 'package:dashapp/models/rating.dart';
import 'package:dashapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RatingViewModel {
  RatingViewModel({@required this.uData});
  final UserData uData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<RatingItem> ratingStream() {
    Stream<QuerySnapshot> s1 = users
        .doc(uData.uid)
        .collection('invoicing')
        .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();
    Stream<QuerySnapshot> s2 = users
        .doc(uData.uid)
        .collection('raisings')
        .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();

    //var send = [s1, s2];

    //return Rx.combineLatest(send.toList(), (List<QuerySnapshot> values) {});

    return Rx.combineLatest2(s1, s2, (QuerySnapshot i, QuerySnapshot r) {
      int invoicingCount = i.size;
      int fullsales = 0;
      int raisingCount = r.size;
      int raisingsales = 0;
      // from all invoices in this perios with ones are full (angariadas e vendidas )
      List<InvoicingItem> invoicingItens =
          i.docs.map((doc) => InvoicingItem.fromFirestore(doc)).toList();

      List<RaisingItem> raisingItens =
          r.docs.map((doc) => RaisingItem.fromFirestore(doc)).toList();

      for (var item in invoicingItens) {
        if (item.houseid != '') {
          if (raisingItens.any((element) => element.id == item.houseid)) {
            fullsales = fullsales + 1;
          }
        }
      }

      for (var item in raisingItens) {
        if (invoicingItens.any((element) => element.houseid == item.id)) {
          raisingsales = raisingsales + 1;
        }
      }

      return new RatingItem(
          invoicingCount: invoicingCount,
          fullsales: fullsales,
          raisingsales: raisingsales,
          raisingCount: raisingCount);
    });
  }
}
