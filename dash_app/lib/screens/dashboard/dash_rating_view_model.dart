import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/rating.dart';
import 'package:dashapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import "package:collection/collection.dart";

class RatingViewModel {
  RatingViewModel({@required this.uData});
  final UserData uData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<List<RatingItem>> ratingStream() {
    Stream<QuerySnapshot> s0 = users.snapshots();
    Stream<QuerySnapshot> s1 = users
        .doc(uData.uid)
        .collection('leads')
        .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();
    Stream<QuerySnapshot> s2 = users
        .doc(uData.uid)
        .collection('invoicing')
        .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();
    Stream<QuerySnapshot> s3 = users
        .doc(uData.uid)
        .collection('raisings')
        .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();

    var send = [s0, s1, s2, s3];
    if (uData.role == '0' || uData.role == '1') {
      for (var item in uData.consultants) {
        send.add(users
            .doc(item)
            .collection('leads')
            .where('createdon',
                isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());
        send.add(users
            .doc(item)
            .collection('invoicing')
            .where('createdon',
                isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());
        send.add(users
            .doc(item)
            .collection('raisings')
            .where('createdon',
                isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());
      }
    }

    return Rx.combineLatest(send.toList(), (List<QuerySnapshot> values) {
      //return Rx.combineLatest2(s1, s2, (QuerySnapshot i, QuerySnapshot r) {
      List<RatingModelItem> itens = [];
      List<RatingItem> result = [];

      for (var item in values) {
        itens.addAll(item.docs
            .map((doc) => RatingModelItem.fromFirestore(doc))
            .toList());
      }

// preciso de dividir por
// utilizador
      Map itensgroup = groupBy(itens, (RatingModelItem obj) => obj.userId);
      List<UsersItens> listUsersItens = [];
      //map.forEach((k, v) => list.add(Customer(k, v)));
      itensgroup.forEach((k, v) => listUsersItens.add(UsersItens(k, v)));

      for (var userItem in listUsersItens) {
        List<RatingModelItem> invoicingItens = [];
        List<RatingModelItem> raisingItens = [];
        List<RatingModelItem> userItens = [];
        List<RatingModelItem> leadItens = [];
        int fullsales = 0;
        int raisingsales = 0;
        int raisinglosts = 0;
        int leadnvoicingCount = 0;

        for (var item in userItem.itens) {
          if (item.collection == 'invoicing') invoicingItens.add(item);
          if (item.collection == 'raisings') raisingItens.add(item);
          if (item.collection == 'users') userItens.add(item);
          if (item.collection == 'leads') leadItens.add(item);
        }
        // print('object');

        for (var item in invoicingItens) {
          if (item.leadid != '') {
            if (leadItens.any((element) => element.id == item.leadid)) {
              leadnvoicingCount = leadnvoicingCount + 1;
            }
          }
        }
        // for (var item in invoicingItens) {
        //   if (item.houseid != '') {
        //     if (raisingItens.any((element) => element.id == item.houseid)) {
        //       fullsales = fullsales + 1;
        //     }
        //   }
        // }
        // int fullsales2 = 0;
        for (var item in raisingItens) {
          if (invoicingItens.any((element) => element.houseid == item.id)) {
            fullsales = fullsales + 1;
          } else {
            print(item.raisingexpirationdate);
            if (item.raisingexpirationdate.isBefore(DateTime.now())) {
              raisinglosts = raisinglosts + 1;
            }
          }
        }

        for (var item in raisingItens) {
          if (invoicingItens.any((element) => element.houseid == item.id)) {
            raisingsales = raisingsales + 1;
          }
        }
        if (invoicingItens.length > 0 && raisingItens.length > 0) {
          result.add(new RatingItem(
              userId: userItem.userId, // ver onde esta o id
              userName: userItens
                  .firstWhere((element) => element.userId == userItem.userId)
                  .name,
              leadCount: leadItens.length,
              leadnvoicingCount: leadnvoicingCount,
              invoicingCount: invoicingItens.length,
              fullsales: fullsales,
              raisingsales: raisingsales,
              raisingCount: raisingItens.length,
              raisinglost: raisinglosts,
              points: invoicingItens.length +
                  (raisingItens.length * 2) +
                  (fullsales * 2)));
        }
      }
      return result;
      //  new RatingItem(
      //     userId: '', // ver onde esta o id
      //     invoicingCount: 1,
      //     fullsales: 1,
      //     raisingsales: 1,
      //     raisingCount: 1);
    });
  }
}

class UsersItens {
  String userId;
  List<RatingModelItem> itens;

  UsersItens(this.userId, this.itens);
}
