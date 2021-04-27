import 'package:cloud_firestore/cloud_firestore.dart';

class LeadItem {
  LeadItem(
      {this.id,
      this.email,
      this.name,
      this.phone,
      this.leadtype,
      this.createdon});

  // LeadItem.leadMap(Map<String, dynamic> data) {
  //   email = data['Email'] ?? '';
  //   name = data['Nome'] ?? '';
  //   phone = data['Telefone'] ?? 0;
  // }
  factory LeadItem.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();
    try {
      return LeadItem(
        id: doc.id,
        email: data['email'] ?? '',
        name: data['name'] ?? '',
        phone: data['telefone'] ?? 0,
        leadtype: data['leadtype'] ?? '0',
        createdon: data['createdon'] != null && data['createdon'] != ''
            ? DateTime.fromMillisecondsSinceEpoch(
                (data['createdon']).seconds * 1000)
            : new DateTime.now(),
      );
    } catch (e) {
      print("Lead ${e}");
      return LeadItem();
    }
  }
  final String id;
  final String email;
  final String name;
  final String phone;
  final String leadtype;
  final DateTime createdon;
}
