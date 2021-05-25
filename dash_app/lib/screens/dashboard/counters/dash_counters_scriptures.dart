import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/sale.dart';
import 'package:dashapp/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ScripturesCount extends StatelessWidget {
  ScripturesCount(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);
    return Provider<ScripturesCountViewModel>(
      create: (_) => ScripturesCountViewModel(uData: uData),
      child: ScripturesData(),
    );
  }
}

class ScripturesCountViewModel {
  ScripturesCountViewModel({this.uData});
  final UserData uData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<List<SaleItem>> scripturesCountStream() {
    Stream<QuerySnapshot> s1 = users
        .doc(uData.uid)
        .collection('sales')
        //.where('state', isEqualTo: '1')
        .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();

    var send = [s1];
    if (uData.role == '0' || uData.role == '1') {
      for (var item in uData.consultants) {
        send.add(users
            .doc(item)
            .collection('sales')
            //.where('state', isEqualTo: '1')
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

      finalitem.removeWhere((item) => item.state != '1');
      return finalitem;
    });
  }
}

class ScripturesData extends StatelessWidget {
  //LeadBuyerCustomersData(this.userId);
  //final String userId;
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<ScripturesCountViewModel>(context, listen: false);
    return StreamBuilder<List<SaleItem>>(
        stream: viewModel.scripturesCountStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SaleItem> sales = snapshot.data;
            return Text(sales.length.toString(),
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
