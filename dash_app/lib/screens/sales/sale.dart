import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/sales/promisebuysell/promisebuysell_list.dart';
import 'package:dashapp/screens/sales/sales_list.dart';
import 'package:dashapp/screens/sales/sales_view_model.dart';
import 'package:dashapp/screens/sales/scriptures/scriptures_list.dart';
import 'package:dashapp/screens/sales/scriptures/scriptures_view_model.dart';
import 'package:dashapp/screens/sales/promisebuysell/promisebuysell_view_model.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sale extends StatelessWidget {
  Sale({this.uData});
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);

    // return StreamProvider<List<SaleItem>>.value(
    //   initialData: null,
    //   value: DatabaseService().getsales(uData.uid),
    return Provider<SalesViewModel>(
      create: (_) => SalesViewModel(uData: uData),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: SaleList(),
      ),
    );
  }
}

class SaleFiltred extends StatelessWidget {
  SaleFiltred(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    return Provider<SalesViewModel>(
      create: (_) => SalesViewModel(uData: uData),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar:
            customAppBar(AppLocalizations.of(context).translate('sales')).bar(),
        body: SaleList(),
      ),
    );
  }
}

class ScripturesFiltred extends StatelessWidget {
  ScripturesFiltred(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    // return StreamProvider<List<SaleItem>>.value(
    //   initialData: null,
    //   value: DatabaseService().getsalesScriptures(userId),
    return Provider<ScripturesViewModel>(
      create: (_) => ScripturesViewModel(uData: uData),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar:
            customAppBar(AppLocalizations.of(context).translate('scriptures'))
                .bar(),
        body: ScripturesList(),
      ),
    );
  }
}

class PromiseBuySellFiltred extends StatelessWidget {
  PromiseBuySellFiltred({this.uData});
  final UserData uData;
  @override
  Widget build(BuildContext context) {
    // return StreamProvider<List<SaleItem>>.value(
    //   initialData: null,
    //   value: DatabaseService().getsalesPromiseBuySell(uData.uid),
    return Provider<PromiseBuySellViewModel>(
      create: (_) => PromiseBuySellViewModel(uData: uData),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar: customAppBar(
                AppLocalizations.of(context).translate('promise_buy_sell'))
            .bar(),
        body: PromiseBuySellList(),
      ),
    );
  }
}
