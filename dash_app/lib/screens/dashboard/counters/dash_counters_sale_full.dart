import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/sale.dart';
import 'package:dashapp/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SaleFullCount extends StatelessWidget {
  SaleFullCount(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);
    return Provider<SaleFullCountViewModel>(
      create: (_) => SaleFullCountViewModel(uData: uData),
      child: SalesFullData(),
    );
  }
}

class SaleFullCountViewModel {
  SaleFullCountViewModel({this.uData});
  final UserData uData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<List<SaleItem>> saleFullStream() {
    Stream<QuerySnapshot> s1 = users
        .doc(uData.uid)
        .collection('sales')
        // .where('leadtype', isEqualTo: '0')
        .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();

    var send = [s1];
    if (uData.role == '0' || uData.role == '1') {
      for (var item in uData.consultants) {
        send.add(users
            .doc(item)
            .collection('sales')
            // .where('leadtype', isEqualTo: '0')
            .where('createdon',
                isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());
      }
    }

    return Rx.combineLatest(send.toList(), (List<QuerySnapshot> values) {
      List<SaleItem> item;
      List<SaleItem> finalitem = [];

      //print('${values[0]}');
      for (var i = 0; i < values.length; i++) {
        if (values[i].docs != null && values[i].docs.length > 0) {
          item =
              values[i].docs.map((doc) => SaleItem.fromFirestore(doc)).toList();
          if (item.length > 0) {
            item.forEach((element) => finalitem.add(element));
          }
        }
      }

      finalitem.removeWhere((item) => item.type != '0');
      return finalitem;
    });
  }
}

class SalesFullData extends StatelessWidget {
  //LeadBuyerCustomersData(this.userId);
  //final String userId;
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<SaleFullCountViewModel>(context, listen: false);
    return StreamBuilder<List<SaleItem>>(
        stream: viewModel.saleFullStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SaleItem> itens = snapshot.data;
            return Text(itens.length.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold));
          }
          return Text("0",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold));
        });
  }
}
