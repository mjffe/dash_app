import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScripturesCount extends StatelessWidget {
  final String userId;

  ScripturesCount(this.userId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<QuerySnapshot>(
        stream: users.doc(userId).collection('scriptures').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text("${snapshot.data.size}",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold));
          }

          if (snapshot.hasError) {
            return Text("hasError");
          }

          return Text("0",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold));
        });
  }
}
