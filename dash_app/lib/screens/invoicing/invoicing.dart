import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/invoicing/invoicing_list.dart';
import 'package:dashapp/screens/invoicing/invoicing_view_model.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Invoicing extends StatelessWidget {
  //final AuthService _auth = AuthService();
  Invoicing({this.uData});
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    return Provider<InvoicingViewModel>(
      create: (_) => InvoicingViewModel(uData: uData, month: 0),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: InvoicingList(),
      ),
    );
  }
}

class InvoicingFiltred extends StatelessWidget {
  InvoicingFiltred(this.uData, this.month);
  final int month;
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    return Provider<InvoicingViewModel>(
      create: (_) => InvoicingViewModel(uData: uData, month: month),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar:
            customAppBar(AppLocalizations.of(context).translate('invoicing'))
                .bar(),
        body: InvoicingList(),
      ),
    );
  }
}
