import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/prospectingtime.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/prospectingtime/prospectingtime_list.dart';
import 'package:dashapp/screens/prospectingtime/prospectingtime_view_model.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProspectingTime extends StatelessWidget {
  ProspectingTime({this.uData});
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    return Provider<ProspectingTimeViewModel>(
      create: (_) => ProspectingTimeViewModel(uData: uData, month: 0),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: ProspectingTimeList(),
      ),
    );
  }
}

class ProspectingTimeFiltred extends StatelessWidget {
  //final AuthService _auth = AuthService();
  ProspectingTimeFiltred(this.uData, this.month);
  final int month;
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    return Provider<ProspectingTimeViewModel>(
      create: (_) => ProspectingTimeViewModel(uData: uData, month: month),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar: customAppBar(
                AppLocalizations.of(context).translate('prospecting_time'))
            .bar(),
        body: ProspectingTimeList(),
      ),
    );
  }
}
