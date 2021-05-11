import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class LeadBuyerCustomersCount extends StatelessWidget {
  final UserData uData;

  LeadBuyerCustomersCount(this.uData);

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);
    return Provider<LeadBuyerCustomersViewModel>(
      create: (_) => LeadBuyerCustomersViewModel(uData: uData),
      child: LeadBuyerCustomersData(),
    );
  }
}

class LeadBuyerCustomersViewModel {
  LeadBuyerCustomersViewModel({@required this.uData});
  final UserData uData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /// returns the entire movies list with user-favourite information
  Stream<int> moviesUserFavouritesStream() {
    Stream<QuerySnapshot> s1 = users
        .doc(uData.uid)
        .collection('leads')
        .where('leadtype', isEqualTo: '1')
        .snapshots();

    var send = [s1];
    if (uData.role == '0' || uData.role == '1') {
      for (var item in uData.consultants) {
        send.add(users
            .doc(item)
            .collection('leads')
            .where('leadtype', isEqualTo: '1')
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

class LeadBuyerCustomersData extends StatelessWidget {
  //LeadBuyerCustomersData(this.userId);
  //final String userId;
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<LeadBuyerCustomersViewModel>(context, listen: false);
    return StreamBuilder<int>(
        stream: viewModel.moviesUserFavouritesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
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
