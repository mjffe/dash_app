import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/prospectingtime.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/prospectingtime/prospectingtime_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProspectingTime extends StatelessWidget {
  const ProspectingTime({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return StreamProvider<List<ProspectingTimeItem>>.value(
      initialData: null,
      value: DatabaseService().getprospectingtime(user.uid, 0),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: ProspectingTimeList(user.uid),
      ),
    );
  }
}

class ProspectingTimeFiltred extends StatelessWidget {
  //final AuthService _auth = AuthService();
  ProspectingTimeFiltred(this.userId, this.month);
  final int month;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ProspectingTimeItem>>.value(
      initialData: null,
      value: DatabaseService().getprospectingtime(userId, month),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar: customAppBar(
                AppLocalizations.of(context).translate('prospecting_time'))
            .bar(),
        body: ProspectingTimeList(userId),
      ),
    );
  }
}
