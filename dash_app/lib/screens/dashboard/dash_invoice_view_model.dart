import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/invoicechart.dart';
import 'package:dashapp/models/objectives.dart';
import 'package:dashapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class InvoiceChartViewModel {
  InvoiceChartViewModel({@required this.uData});
  final UserData uData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<InvoiceChartItem> invoiceChartStream() {
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
    Stream<QuerySnapshot> s3 = users
        .doc(uData.uid)
        .collection('sales')
        .where('date', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('date', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();

    var send = [s1, s2, s3];
    if (uData.role == '0' || uData.role == '1') {
      for (var item in uData.consultants) {
        send.add(users
            .doc(item)
            .collection('invoicing')
            .where('date', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('date', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());

        send.add(users
            .doc(item)
            .collection('sales')
            .where('date', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('date', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());

        send.add(users
            .doc(item)
            .collection('sales')
            .where('date', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('date', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());
      }
    }

    return Rx.combineLatest(send.toList(), (List<QuerySnapshot> values) {
      List<ChartItem> itens;
      List<ChartItem> invo = [];
      List<ChartItem> sale = [];
      List<ObjectiveItem> obj;

      for (var i = 0; i < values.length; i++) {
        if (i == 0) {
          obj = values[i]
              .docs
              .map((doc) => ObjectiveItem.fromFirestore(doc))
              .toList();
        } else {
          //print('Document found at path: ${values[i].query}');
          //print('Document found at path: ${values[i].docs.ref.path}');
          // for (var doc in values[i].docs) {
          //    print('Document found at path: ${doc.ref.path}');
          // }
          itens = values[i]
              .docs
              .map((doc) => ChartItem.fromFirestore(doc))
              .toList();
          itens.removeWhere((item) => item.collection == null);
          if (itens.length > 0) {
            if (itens.first.collection == 'invoicing')
              itens.forEach((element) => invo.add(element));
            if (itens.first.collection == 'sales')
              itens.forEach((element) => sale.add(element));
          }
          //invoJoin.addAll(invo);
        }
      }
      //sale.removeWhere((item) => item.collection == null);

      return InvoiceChartItem(invoices: invo, objectives: obj, sales: sale);
    });
  }
}
