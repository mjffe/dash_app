import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/piechart.dart';
import 'package:dashapp/models/sale.dart';
import 'package:dashapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PieCharCountViewModel {
  PieCharCountViewModel({@required this.uData});
  final UserData uData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<PieChartItem> pieCharCountStream() {
    Stream<QuerySnapshot> s1 = users
        .doc(uData.uid)
        .collection('servicepresentation')
        .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();
    Stream<QuerySnapshot> s2 = users
        .doc(uData.uid)
        .collection('mediationcontract')
        .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();
    Stream<QuerySnapshot> s3 = users
        .doc(uData.uid)
        .collection('proposal')
        .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();
    // Stream<QuerySnapshot> s4 = users
    //     .doc(uData.uid)
    //     .collection('sales')
    //     .where('state', isEqualTo: '0')
    //     .snapshots();
    Stream<QuerySnapshot> s5 = users
        .doc(uData.uid)
        .collection('sales')
        //.where('state', isEqualTo: '0')
        .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();

    var send = [s1, s2, s3, s5];
    if (uData.role == '0' || uData.role == '1') {
      for (var item in uData.consultants) {
        send.add(users
            .doc(item)
            .collection('servicepresentation')
            .where('createdon',
                isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());
        send.add(users
            .doc(item)
            .collection('mediationcontract')
            .where('createdon',
                isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());
        send.add(users
            .doc(item)
            .collection('proposal')
            .where('createdon',
                isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());
        send.add(users
            .doc(item)
            .collection('sales')
            .where('state', isEqualTo: '0')
            // .where('createdon',
            //     isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            // .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());
      }
    }

    return Rx.combineLatest(send.toList(), (List<QuerySnapshot> values) {
      int apsCount = 0;
      int cmiCount = 0;
      int cpvcCount = 0;
      int propostasCount = 0;

      //print('${values[0].docs[0].reference.path}');
      for (var i = 0; i < values.length; i++) {
        if (values[i].docs != null && values[i].docs.length > 0) {
          String origin = values[i].docs[0].reference.path.split('/')[2];
          //print('${origin}');
          switch (origin) {
            case 'servicepresentation':
              apsCount = apsCount + values[i].size;
              break;
            case 'mediationcontract':
              cmiCount = cmiCount + values[i].size;
              break;
            case 'proposal':
              propostasCount = propostasCount + values[i].size;
              break;
            case 'sales':
              //cpvcCount = cpvcCount + values[i].size;
              List<SaleItem> item;

              item = values[i]
                  .docs
                  .map((doc) => SaleItem.fromFirestore(doc))
                  .toList();

              item.removeWhere((item) => item.state != '0');
              cpvcCount = cpvcCount + item.length;
              break;
            default:
              break;
          }
        }
      }

      return PieChartItem(
          apsCount: apsCount,
          cmiCount: cmiCount,
          cpvcCount: cpvcCount,
          propostasCount: propostasCount);
    });
  }
}
