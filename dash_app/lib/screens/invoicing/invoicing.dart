import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/invoicing/invoicing_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
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
      value: DatabaseService().getinvoices(user.uid, 0),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: InvoicingList(user.uid),
      ),
    );
  }
}

class InvoicingFiltred extends StatelessWidget {
  InvoicingFiltred(this.userId, this.month);
  final int month;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<InvoicingItem>>.value(
      initialData: null,
      value: DatabaseService().getinvoices(userId, month),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar:
            customAppBar(AppLocalizations.of(context).translate('invoicing'))
                .bar(),
        body: InvoicingList(userId),
      ),
    );
  }
}
