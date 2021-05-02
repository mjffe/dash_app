import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/objectives.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/objective/objective_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Objective extends StatelessWidget {
  //final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<ObjectiveItem>>.value(
      initialData: null,
      value: DatabaseService().getobjectives(user.uid, 0),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: ObjectiveList(user.uid),
      ),
    );
  }
}

class ObjectiveFiltred extends StatelessWidget {
  ObjectiveFiltred(this.userId, this.month);
  final int month;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ObjectiveItem>>.value(
      initialData: null,
      value: DatabaseService().getobjectives(userId, month),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar:
            customAppBar(AppLocalizations.of(context).translate('objectives'))
                .bar(),
        body: ObjectiveList(userId),
      ),
    );
  }
}
