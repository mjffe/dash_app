// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dashapp/models/lead.dart';
// import 'package:dashapp/models/user.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:rxdart/rxdart.dart';

// class LeadBuyerCustomersCount extends StatelessWidget {
//   final UserData uData;

//   LeadBuyerCustomersCount(this.uData);

//   @override
//   Widget build(BuildContext context) {
//     //final user = Provider.of<FirebaseUser>(context);
//     return Provider<LeadBuyerCustomersViewModel>(
//       create: (_) => LeadBuyerCustomersViewModel(uData: uData),
//       child: LeadBuyerCustomersData(),
//     );
//   }
// }

// class LeadBuyerCustomersViewModel {
//   LeadBuyerCustomersViewModel({this.uData});
//   final UserData uData;
//   CollectionReference users = FirebaseFirestore.instance.collection('users');

//   Stream<List<LeadItem>> leadBuyerCustomersCount() {
//     Stream<QuerySnapshot> s1 = users
//         .doc(uData.uid)
//         .collection('leads')
//         // .where('leadtype', isEqualTo: '0')
//         .where('createdon', isGreaterThanOrEqualTo: uData.filterDateRangeStart)
//         .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
//         .snapshots();

//     var send = [s1];
//     if (uData.role == '0' || uData.role == '1') {
//       for (var item in uData.consultants) {
//         send.add(users
//             .doc(item)
//             .collection('leads')
//             // .where('leadtype', isEqualTo: '0')
//             .where('createdon',
//                 isGreaterThanOrEqualTo: uData.filterDateRangeStart)
//             .where('createdon', isLessThanOrEqualTo: uData.filterDateRangeEnd)
//             .snapshots());
//       }
//     }

//     return Rx.combineLatest(send.toList(), (List<QuerySnapshot> values) {
//       List<LeadItem> item;
//       List<LeadItem> finalitem = [];

//       //print('${values[0]}');
//       for (var i = 0; i < values.length; i++) {
//         if (values[i].docs != null && values[i].docs.length > 0) {
//           item =
//               values[i].docs.map((doc) => LeadItem.fromFirestore(doc)).toList();
//           if (item.length > 0) {
//             item.forEach((element) => finalitem.add(element));
//           }
//         }
//       }

//       finalitem.removeWhere((item) => item.leadtype != '0');
//       return finalitem;
//     });
//   }
// }

// class LeadBuyerCustomersData extends StatelessWidget {
//   //LeadBuyerCustomersData(this.userId);
//   //final String userId;
//   @override
//   Widget build(BuildContext context) {
//     final viewModel =
//         Provider.of<LeadBuyerCustomersViewModel>(context, listen: false);
//     return StreamBuilder<List<LeadItem>>(
//         stream: viewModel.leadBuyerCustomersCount(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<LeadItem> leads = snapshot.data;
//             return Text(leads.length.toString(),
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold));
//           }
//           return Text("0",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold));
//         });
//   }
// }
