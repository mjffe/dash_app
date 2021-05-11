import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/models/user.dart';
import 'package:jiffy/jiffy.dart';
import 'package:rxdart/rxdart.dart';

class InvoicingViewModel {
  InvoicingViewModel({this.uData, this.month});
  final UserData uData;
  final int month;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Stream<List<InvoicingItem>> raisingsStream() {
    List<Stream<QuerySnapshot>> send;
    if (month == 0) {
      Stream<QuerySnapshot> s1 =
          users.doc(uData.uid).collection('invoicing').snapshots();

      send = [s1];
      if (uData.role == '0' || uData.role == '1') {
        for (var item in uData.consultants) {
          send.add(users.doc(item).collection('invoicing').snapshots());
        }
      }
    } else {
      DateTime startDate = new DateTime(DateTime.now().year, month, 1);
      Jiffy end = Jiffy(DateTime(DateTime.now().year, month, 1)).add(months: 1);
      DateTime endDate = new DateTime(DateTime.now().year, end.month, 1);

      Stream<QuerySnapshot> s1 = users
          .doc(uData.uid)
          .collection('invoicing')
          .where('date', isGreaterThanOrEqualTo: startDate)
          .where('date', isLessThan: endDate)
          .snapshots();

      send = [s1];
      if (uData.role == '0' || uData.role == '1') {
        for (var item in uData.consultants) {
          send.add(users
              .doc(item)
              .collection('invoicing')
              .where('date', isGreaterThanOrEqualTo: startDate)
              .where('date', isLessThan: endDate)
              .snapshots());
        }
      }
    }
    return Rx.combineLatest(send.toList(), (List<QuerySnapshot> values) {
      List<InvoicingItem> item;
      List<InvoicingItem> finalitem = [];

      print('${values[0]}');
      for (var i = 0; i < values.length; i++) {
        if (values[i].docs != null && values[i].docs.length > 0) {
          item = values[i]
              .docs
              .map((doc) => InvoicingItem.fromFirestore(doc))
              .toList();
          if (item.length > 0) {
            item.forEach((element) => finalitem.add(element));
          }
        }
      }
      finalitem.sort((a, b) => a.createdon.compareTo(b.createdon));
      return finalitem;
    });
  }
}
