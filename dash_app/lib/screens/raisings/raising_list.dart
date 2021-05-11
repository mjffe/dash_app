import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/raising.dart';
import 'package:dashapp/screens/raisings/raising_form.dart';
import 'package:dashapp/screens/raisings/raising_view_model.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RaisingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RaisingViewModel>(context, listen: false);

    return StreamBuilder<List<RaisingItem>>(
        stream: viewModel.raisingsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<RaisingItem> raisings = snapshot.data;
            return ListView.builder(
                itemCount: raisings.length,
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
                            print('name:${raisings[index].name} ');
                            DatabaseService(
                                    uid: raisings[index].createdby,
                                    docid: raisings[index].id)
                                .deleteRaisingsData();

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
                              Icons.home,
                              size: 40,
                            ),
                          ),
                          title: Text(raisings[index].name),
                          onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 60),
                                  child: RaisingForm(
                                      raisings[index].createdby,
                                      raisings[index]
                                          .id), //SettingsForm(userid),
                                );
                              }),
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
