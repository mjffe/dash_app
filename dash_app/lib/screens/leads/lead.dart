import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/leads/buyercustomers/lead_buyercustomers_list.dart';
import 'package:dashapp/screens/leads/buyercustomers/lead_buyercustomers_view_model.dart';
import 'package:dashapp/screens/leads/lead_list.dart';
import 'package:dashapp/screens/leads/prospecting/lead_prospecting_list.dart';
import 'package:dashapp/screens/leads/lead_view_model.dart';
import 'package:dashapp/screens/leads/prospecting/lead_prospecting_view_model.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Lead extends StatelessWidget {
  Lead({this.uData});
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);
    return Provider<LeadViewModel>(
      create: (_) => LeadViewModel(uData: uData),
      child: Scaffold(
          backgroundColor: MyColors.appBarBackgroundColor, body: LeadList()),
      //LeadData(uData),
    );
  }
}

class LeadProspectingFiltred extends StatelessWidget {
  LeadProspectingFiltred(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    return Provider<LeadProspectingViewModel>(
      create: (_) => LeadProspectingViewModel(uData: uData),
      child: Scaffold(
          backgroundColor: MyColors.appBarBackgroundColor,
          appBar: customAppBar(
                  AppLocalizations.of(context).translate('prospecting'))
              .bar(),
          body: LeadProspectingList()),
      //LeadData(uData),
    );
  }
}

class LeadBuyerCustomersFiltred extends StatelessWidget {
  LeadBuyerCustomersFiltred(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    return Provider<LeadBuyerCustomersViewModel>(
      create: (_) => LeadBuyerCustomersViewModel(uData: uData),
      child: Scaffold(
          backgroundColor: MyColors.appBarBackgroundColor,
          appBar: customAppBar(
                  AppLocalizations.of(context).translate('buyercustomers'))
              .bar(),
          body: LeadBuyerCustomersList()),
    );
  }
}
