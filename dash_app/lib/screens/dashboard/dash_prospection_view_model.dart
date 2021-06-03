import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/prospectingtime.dart';
import 'package:dashapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class DashProspectionViewModel {
  DashProspectionViewModel({@required this.uData});
  final UserData uData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<List<ProspectingTimeItem>> prospectingTimeStream() {
    Stream<QuerySnapshot> s1 = users
        .doc(uData.uid)
        .collection('prospectingtime')
        .where('date', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('date', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();

    var send = [s1];
    if (uData.role == '0' || uData.role == '1') {
      for (var item in uData.consultants) {
        send.add(users
            .doc(item)
            .collection('prospectingtime')
            .where('date', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('date', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());
      }
    }

    return Rx.combineLatest(send.toList(), (List<QuerySnapshot> values) {
      List<ProspectingTimeItem> item;
      List<ProspectingTimeItem> time = [];

      print('${values[0]}');
      for (var i = 0; i < values.length; i++) {
        if (values[i].docs != null && values[i].docs.length > 0) {
          item = values[i]
              .docs
              .map((doc) => ProspectingTimeItem.fromFirestore(doc))
              .toList();
          if (item.length > 0) {
            item.forEach((element) => time.add(element));
          }
        }
      }

      return item;
    });
  }
}
