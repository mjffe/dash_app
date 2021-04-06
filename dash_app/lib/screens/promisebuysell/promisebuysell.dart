import 'package:dashapp/models/promisebuysell.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/promisebuysell/promisebuysell_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromiseBuySell extends StatelessWidget {
  //final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<PromiseBuySellItem>>.value(
      initialData: null,
      value: DatabaseService().getpromisesbuysell(user),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: PromiseBuySellList(),
      ),
    );
  }
}
