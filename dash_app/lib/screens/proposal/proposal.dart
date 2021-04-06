import 'package:dashapp/models/proposal.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/proposal/proposal_list.dart';
import 'package:dashapp/service/database.dart';
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
      value: DatabaseService().getproposals(user),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: ProposalList(),
      ),
    );
  }
}
