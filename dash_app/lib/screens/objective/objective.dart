import 'package:dashapp/models/objectives.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/objective/objective_list.dart';
import 'package:dashapp/service/database.dart';
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
      value: DatabaseService().getobjectives(user),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: ObjectiveList(),
      ),
    );
  }
}
