import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/lead.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/leads/lead_form_panel.dart';
import 'package:dashapp/screens/leads/prospecting/lead_prospecting_view_model.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeadProspectingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<LeadProspectingViewModel>(context, listen: false);
    return StreamBuilder<List<LeadItem>>(
        stream: viewModel.leadsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<LeadItem> leads = snapshot.data;
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
                              DatabaseService(
                                      uid: leads[index].createdby,
                                      docid: leads[index].id)
                                  .deleteLeadData();

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
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
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LeadFormPanel(
                                        leads[index].createdby,
                                        leads[index].id))),
                          )),
                    ),
                  );
                });
          }
          return Loading();
        });
  }
}
