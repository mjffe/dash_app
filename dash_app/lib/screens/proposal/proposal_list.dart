import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/proposal.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/proposal/proposal_form.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_icons.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProposalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final proposal = Provider.of<List<ProposalItem>>(context) ?? [];

    //return Text('sdfsdf');
    return ListView.builder(
        itemCount: proposal.length,
        itemBuilder: (context, index) {
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
                    DatabaseService(uid: user.uid, docid: proposal[index].id)
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
                    backgroundColor: MyColors.appBarBackgroundColor,
                    child: Icon(
                      AppIcoons.proposta,
                      size: 40,
                    ),
                  ),
                  title: Text(proposal[index].name),
                  subtitle: Text(
                      '${AppLocalizations.of(context).translate('value')}:${proposal[index].value} '),
                  onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60),
                          child: ProposalForm(user.uid,
                              proposal[index].id), //SettingsForm(userid),
                        );
                      }),
                ),
              ),
            ),
          );
        });
  }
}
