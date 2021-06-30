import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/lead.dart';
import 'package:dashapp/models/user.dart';
import 'package:rxdart/rxdart.dart';

class LeadViewModel {
  LeadViewModel({this.uData});
  final UserData uData;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<List<LeadItem>> leadsStream() {
    Stream<QuerySnapshot> s1 =
        users.doc(uData.uid).collection('leads').snapshots();

    var send = [s1];
    if (uData.role == '0' || uData.role == '1') {
      for (var item in uData.consultants) {
        send.add(users.doc(item).collection('leads').snapshots());
      }
    }

    return Rx.combineLatest(send.toList(), (List<QuerySnapshot> values) {
      List<LeadItem> item;
      List<LeadItem> finalitem = [];

      //print('${values[0]}');
      for (var i = 0; i < values.length; i++) {
        if (values[i].docs != null && values[i].docs.length > 0) {
          item =
              values[i].docs.map((doc) => LeadItem.fromFirestore(doc)).toList();
          if (item.length > 0) {
            item.forEach((element) => finalitem.add(element));
          }
        }
      }
      finalitem.sort((b, a) => a.createdon.compareTo(b.createdon));
      return finalitem;
    });
  }
}
