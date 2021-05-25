import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/servicepresentation.dart';
import 'package:dashapp/models/user.dart';
import 'package:rxdart/rxdart.dart';

class ServicePresentationViewModel {
  ServicePresentationViewModel({this.uData});
  final UserData uData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<List<ServicePresentationItem>> servicePresentationStream() {
    Stream<QuerySnapshot> s1 =
        users.doc(uData.uid).collection('servicepresentation').snapshots();

    var send = [s1];
    if (uData.role == '0' || uData.role == '1') {
      for (var item in uData.consultants) {
        send.add(users.doc(item).collection('servicepresentation').snapshots());
      }
    }

    return Rx.combineLatest(send.toList(), (List<QuerySnapshot> values) {
      List<ServicePresentationItem> item;
      List<ServicePresentationItem> finalitem = [];

      //print('${values[0]}');
      for (var i = 0; i < values.length; i++) {
        if (values[i].docs != null && values[i].docs.length > 0) {
          item = values[i]
              .docs
              .map((doc) => ServicePresentationItem.fromFirestore(doc))
              .toList();
          if (item.length > 0) {
            item.forEach((element) => finalitem.add(element));
          }
        }
      }

      return finalitem;
    });
  }
}
