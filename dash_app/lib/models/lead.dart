import 'package:cloud_firestore/cloud_firestore.dart';

class LeadItem {
  LeadItem({this.id, this.email, this.name, this.phone});

  // LeadItem.leadMap(Map<String, dynamic> data) {
  //   email = data['Email'] ?? '';
  //   name = data['Nome'] ?? '';
  //   phone = data['Telefone'] ?? 0;
  // }
  factory LeadItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return LeadItem(
      id: doc.id,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      phone: data['telefone'] ?? 0,
    );
  }
  final String id;
  final String email;
  final String name;
  final String phone;
}
