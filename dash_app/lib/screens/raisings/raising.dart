import 'package:dashapp/models/raising.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/raisings/raising_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Raising extends StatelessWidget {
  //final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<RaisingItem>>.value(
      initialData: null,
      value: DatabaseService().getraisings(user),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: RaisingList(),
      ),
    );
  }
}
