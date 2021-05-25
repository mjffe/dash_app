import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/invoicechart.dart';
import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/models/objectives.dart';
import 'package:dashapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class InvoiceChartViewModel {
  InvoiceChartViewModel({@required this.uData});
  final UserData uData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<InvoiceChartItem> moviesUserFavouritesStream() {
    Stream<QuerySnapshot> s1 = users
        .doc(uData.uid)
        .collection('objective')
        .where('date', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('date', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();
    Stream<QuerySnapshot> s2 = users
        .doc(uData.uid)
        .collection('invoicing')
        .where('date', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('date', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();
    var send = [s1, s2];
    if (uData.role == '0' || uData.role == '1') {
      for (var item in uData.consultants) {
        send.add(users
            .doc(item)
            .collection('invoicing')
            .where('date', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('date', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());
      }
    }

    return Rx.combineLatest(send.toList(), (List<QuerySnapshot> values) {
      List<InvoicingItem> invo;
      List<InvoicingItem> invoJoin = [];
      List<ObjectiveItem> obj;

      for (var i = 0; i < values.length; i++) {
        if (i == 0) {
          obj = values[i]
              .docs
              .map((doc) => ObjectiveItem.fromFirestore(doc))
              .toList();
        } else {
          invo = values[i]
              .docs
              .map((doc) => InvoicingItem.fromFirestore(doc))
              .toList();
          if (invo.length > 0) {
            invo.forEach((element) => invoJoin.add(element));
          }
          //invoJoin.addAll(invo);
        }
      }
      return InvoiceChartItem(invoices: invoJoin, objectives: obj);
    });
  }
}
