import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/lead.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/leads/lead_form.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeadList extends StatelessWidget {
  const LeadList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final leads = Provider.of<List<LeadItem>>(context) ?? [];
    print('List of leads: ${leads}');
    //return Text('sdfsdf');
    return ListView.builder(
        itemCount: leads.length,
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
                    print(
                        'Email:${leads[index].email} \nPhone: ${leads[index].phone}');
                    DatabaseService(uid: user.uid, docid: leads[index].id)
                        .deleteLeadData();

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
                      Icons.people,
                      size: 40,
                    ),
                  ),
                  title: Text(leads[index].name),
                  subtitle: Text(
                      '${AppLocalizations.of(context).translate('email')}:${leads[index].email} \n${AppLocalizations.of(context).translate('phone')} : ${leads[index].phone}'),
                  onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60),
                          child: LeadForm(user.uid,
                              leads[index].id), //SettingsForm(userid),
                        );
                      }),
                ),
              ),
            ),
          );
        });
  }
}
