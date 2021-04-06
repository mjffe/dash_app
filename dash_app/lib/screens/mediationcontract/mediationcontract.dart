import 'package:dashapp/models/mediationcontract.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/mediationcontract/mediationcontract_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediationContract extends StatelessWidget {
  //final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<MediationContractItem>>.value(
      initialData: null,
      value: DatabaseService().getmediationcontracts(user),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: MediationContractList(),
      ),
    );
  }
}
