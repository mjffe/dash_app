import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/mediationcontract.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/mediationcontract/mediationcontract_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
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
      value: DatabaseService().getmediationcontracts(user.uid),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: MediationContractList(user.uid),
      ),
    );
  }
}

class MediationContractFiltred extends StatelessWidget {
  MediationContractFiltred(this.userId);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<MediationContractItem>>.value(
      initialData: null,
      value: DatabaseService().getmediationcontracts(userId),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar: customAppBar(
                AppLocalizations.of(context).translate('mediation_contract'))
            .bar(),
        body: MediationContractList(userId),
      ),
    );
  }
}
