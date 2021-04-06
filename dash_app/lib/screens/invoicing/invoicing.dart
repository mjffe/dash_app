import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/invoicing/invoicing_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Invoicing extends StatelessWidget {
  //final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<InvoicingItem>>.value(
      initialData: null,
      value: DatabaseService().getinvoices(user),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: InvoicingList(),
      ),
    );
  }
}
