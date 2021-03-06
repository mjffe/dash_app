import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/proposal.dart';
import 'package:dashapp/screens/proposal/proposal_form_panel.dart';
import 'package:dashapp/screens/proposal/proposal_view_model.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_icons.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProposalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProposalViewModel>(context, listen: false);
    return StreamBuilder<List<ProposalItem>>(
        stream: viewModel.proposalStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProposalItem> proposal = snapshot.data;
            return ListView.builder(
                itemCount: proposal.length,
                itemBuilder: (context, index) {
                  Color circle = MyColors.appBarBackgroundColor;

                  return //LeadTile(brew: brews[index]);
                      Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Card(
                      margin: EdgeInsets.fromLTRB(2, 1, 2, 0),
                      child: Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          if (direction == DismissDirection.endToStart) {
                            print('name:${proposal[index].name} ');
                            DatabaseService(
                                    uid: proposal[index].createdby,
                                    docid: proposal[index].id)
                                .deleteProposalData();

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(AppLocalizations.of(context)
                                    .translate('data_deleted'))));
                          }
                        },
                        background: Container(
                          padding: EdgeInsets.only(right: 20.0),
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundColor: proposal[index].state == '0'
                                ? MyColors.appBarBackgroundColor
                                : (proposal[index].state == '1'
                                    ? MyColors.lightRed
                                    : MyColors.lightGreen),
                            child: Icon(
                              AppIcoons.proposta,
                              size: 40,
                            ),
                          ),
                          title: Text(proposal[index].name),
                          subtitle: Text(
                              '${AppLocalizations.of(context).translate('value')}:${proposal[index].value} '),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProposalForm(
                                      proposal[index].createdby,
                                      proposal[index].id))),
                        ),
                      ),
                    ),
                  );
                });
          }
          return Loading();
        });
  }
}
