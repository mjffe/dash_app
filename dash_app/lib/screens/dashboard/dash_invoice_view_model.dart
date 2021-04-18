import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/invoicechart.dart';
import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/models/objectives.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class InvoiceChartViewModel {
  InvoiceChartViewModel({@required this.userId});
  final String userId;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /// returns the entire movies list with user-favourite information
  Stream<InvoiceChartItem> moviesUserFavouritesStream() {
    return Rx.combineLatest2(
        users.doc(userId).collection('invoicing').snapshots(),
        users.doc(userId).collection('objective').snapshots(),
        (QuerySnapshot invoicing, QuerySnapshot objective) {
      return InvoiceChartItem(
          invoices: invoicing.docs
              .map((doc) => InvoicingItem.fromFirestore(doc))
              .toList(),
          objectives: objective.docs
              .map((doc) => ObjectiveItem.fromFirestore(doc))
              .toList());

      // return InvoiceChartItem(
      //     invoices: invoicing.,
      //     objectives: : objective);
    });
  }
}
