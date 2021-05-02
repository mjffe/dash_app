import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/proposal.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/proposal/proposal_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Proposal extends StatelessWidget {
  //final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<ProposalItem>>.value(
      initialData: null,
      value: DatabaseService().getproposals(user.uid),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: ProposalList(user.uid),
      ),
    );
  }
}

class ProposalFiltred extends StatelessWidget {
  ProposalFiltred(this.userId);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<ProposalItem>>.value(
      initialData: null,
      value: DatabaseService().getproposals(userId),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar: customAppBar(AppLocalizations.of(context).translate('proposal'))
            .bar(),
        body: ProposalList(userId),
      ),
    );
  }
}
