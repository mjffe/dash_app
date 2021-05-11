import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/proposal.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/proposal/proposal_list.dart';
import 'package:dashapp/screens/proposal/proposal_view_model.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Proposal extends StatelessWidget {
  Proposal({this.uData});
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return Provider<ProposalViewModel>(
      create: (_) => ProposalViewModel(uData: uData),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: ProposalList(),
      ),
    );
  }
}

class ProposalFiltred extends StatelessWidget {
  ProposalFiltred({this.uData});
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    return Provider<ProposalViewModel>(
      create: (_) => ProposalViewModel(uData: uData),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar: customAppBar(AppLocalizations.of(context).translate('proposal'))
            .bar(),
        body: ProposalList(),
      ),
    );
  }
}
