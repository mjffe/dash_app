import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/leads/buyercustomers/lead_buyercustomers_list.dart';
import 'package:dashapp/screens/leads/buyercustomers/lead_buyercustomers_view_model.dart';
import 'package:dashapp/screens/leads/lead_list.dart';
import 'package:dashapp/screens/leads/prospecting/lead_prospecting_list.dart';
import 'package:dashapp/screens/leads/lead_view_model.dart';
import 'package:dashapp/screens/leads/prospecting/lead_prospecting_view_model.dart';
import 'package:dashapp/screens/leads/types/lead_type_list.dart';
import 'package:dashapp/screens/leads/types/lead_type_view_model.dart';
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

// class LeadProspectingFiltred extends StatelessWidget {
//   LeadProspectingFiltred(this.uData);
//   final UserData uData;

//   @override
//   Widget build(BuildContext context) {
//     return Provider<LeadProspectingViewModel>(
//       create: (_) => LeadProspectingViewModel(uData: uData),
//       child: Scaffold(
//           backgroundColor: MyColors.appBarBackgroundColor,
//           appBar: customAppBar(
//                   AppLocalizations.of(context).translate('prospecting'))
//               .bar(),
//           body: LeadProspectingList()),
//       //LeadData(uData),
//     );
//   }
// }

// class LeadBuyerCustomersFiltred extends StatelessWidget {
//   LeadBuyerCustomersFiltred(this.uData);
//   final UserData uData;

//   @override
//   Widget build(BuildContext context) {
//     return Provider<LeadBuyerCustomersViewModel>(
//       create: (_) => LeadBuyerCustomersViewModel(uData: uData),
//       child: Scaffold(
//           backgroundColor: MyColors.appBarBackgroundColor,
//           appBar: customAppBar(
//                   AppLocalizations.of(context).translate('buyercustomers'))
//               .bar(),
//           body: LeadBuyerCustomersList()),
//     );
//   }
// }

class LeadTypeFiltred extends StatelessWidget {
  LeadTypeFiltred(this.uData, this.type);
  final UserData uData;
  final String type;

  @override
  Widget build(BuildContext context) {
    print('type LeadTypeFiltred: ${type}');
    return Provider<LeadTypeViewModel>(
      create: (_) => LeadTypeViewModel(uData: uData, type: type),
      child: Scaffold(
          backgroundColor: MyColors.appBarBackgroundColor,
          appBar:
              customAppBar(AppLocalizations.of(context).translate(type)).bar(),
          body: LeadTypeList()),
      //LeadData(uData),
    );
  }
}
