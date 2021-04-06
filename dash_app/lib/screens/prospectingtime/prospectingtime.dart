import 'package:dashapp/models/prospectingtime.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/prospectingtime/prospectingtime_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProspectingTime extends StatelessWidget {
  //final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<ProspectingTimeItem>>.value(
      initialData: null,
      value: DatabaseService().getprospectingtime(user),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: ProspectingTimeList(),
      ),
    );
  }
}
