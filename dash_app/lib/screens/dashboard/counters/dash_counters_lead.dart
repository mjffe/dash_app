import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class LeadCount extends StatelessWidget {
  LeadCount(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);
    return Provider<LeadViewModel>(
      create: (_) => LeadViewModel(uData: uData),
      child: LeadData(),
    );
  }
}

class LeadViewModel {
  LeadViewModel({@required this.uData});
  final UserData uData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /// returns the entire movies list with user-favourite information
  Stream<int> moviesUserFavouritesStream() {
    Stream<QuerySnapshot> s1 = users
        .doc(uData.uid)
        .collection('leads')
        .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
        .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
        .snapshots();

    var send = [s1];
    if (uData.role == '0' || uData.role == '1') {
      for (var item in uData.consultants) {
        send.add(users
            .doc(item)
            .collection('leads')
            .where('createdon',
                isGreaterThanOrEqualTo: uData.filterDateRangeStart)
            .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
            .snapshots());
      }
    }
    return Rx.combineLatest(send.toList(), (values) {
      int s = 0;
      for (var d in values) {
        s = s + d.size;
      }
      return s;
    });
  }
}

class LeadData extends StatelessWidget {
  //LeadBuyerCustomersData(this.userId);
  //final String userId;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LeadViewModel>(context, listen: false);
    return StreamBuilder<int>(
        stream: viewModel.moviesUserFavouritesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString(),
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
