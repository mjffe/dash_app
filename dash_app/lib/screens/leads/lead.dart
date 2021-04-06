import 'package:dashapp/models/lead.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/leads/lead_list.dart';
import 'package:dashapp/service/auth.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lead extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<LeadItem>>.value(
      initialData: null,
      value: DatabaseService().getleads(user),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: LeadList(),
      ),
    );
  }
}

// class Lead extends StatefulWidget {
//   Lead({Key key}) : super(key: key);

//   @override
//   _LeadState createState() => _LeadState();
// }

// class _LeadState extends State<Lead> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<List<Brew>>.value(
//       initialData: null,
//       value: DatabaseService().brews,
//       child: Scaffold(
//         backgroundColor: Colors.grey[300],
//         body: LeadList(),
//       ),
//     );
//   }
// }
