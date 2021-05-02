import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/sale.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/sales/sales_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<SaleItem>>.value(
      initialData: null,
      value: DatabaseService().getsales(user.uid),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: SaleList(user.uid),
      ),
    );
  }
}

class SaleFiltred extends StatelessWidget {
  SaleFiltred(this.userId);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<SaleItem>>.value(
      initialData: null,
      value: DatabaseService().getsales(userId),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar:
            customAppBar(AppLocalizations.of(context).translate('sales')).bar(),
        body: SaleList(userId),
      ),
    );
  }
}

class ScripturesFiltred extends StatelessWidget {
  ScripturesFiltred(this.userId);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<SaleItem>>.value(
      initialData: null,
      value: DatabaseService().getsalesScriptures(userId),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar:
            customAppBar(AppLocalizations.of(context).translate('scriptures'))
                .bar(),
        body: SaleList(userId),
      ),
    );
  }
}

class PromiseBuySellFiltred extends StatelessWidget {
  PromiseBuySellFiltred(this.userId);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<SaleItem>>.value(
      initialData: null,
      value: DatabaseService().getsalesPromiseBuySell(userId),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar: customAppBar(
                AppLocalizations.of(context).translate('promise_buy_sell'))
            .bar(),
        body: SaleList(userId),
      ),
    );
  }
}
