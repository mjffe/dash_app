import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/mediationcontract/mediationcontract_list.dart';
import 'package:dashapp/screens/mediationcontract/mediationcontract_view_model.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MediationContract extends StatelessWidget {
  //final AuthService _auth = AuthService();
  MediationContract({this.uData});
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<FirebaseUser>(context);

    return Provider<MediationContractViewModel>(
      create: (_) => MediationContractViewModel(uData: uData),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: MediationContractList(),
      ),
    );
  }
}

class MediationContractFiltred extends StatelessWidget {
  MediationContractFiltred({this.uData});
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    return Provider<MediationContractViewModel>(
      create: (_) => MediationContractViewModel(uData: uData),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar: customAppBar(
                AppLocalizations.of(context).translate('mediation_contract'))
            .bar(),
        body: MediationContractList(),
      ),
    );
  }
}
