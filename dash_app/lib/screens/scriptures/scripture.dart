import 'package:dashapp/models/scriptures.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/scriptures/scripture_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Scriptures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<ScripturesItem>>.value(
      initialData: null,
      value: DatabaseService().getscriptures(user),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: ScripturesList(),
      ),
    );
  }
}
