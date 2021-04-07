import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/servicepresentation.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/service_presentation/servicepresentation_form.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_icons.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicePresentationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final servicePresentation =
        Provider.of<List<ServicePresentationItem>>(context) ?? [];

    //return Text('sdfsdf');
    return ListView.builder(
        itemCount: servicePresentation.length,
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
                    print('name:${servicePresentation[index].name} ');
                    DatabaseService(
                            uid: user.uid, docid: servicePresentation[index].id)
                        .deleteServicePresentationData();

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
                      AppIcoons.apresentacaoservico,
                      size: 40,
                    ),
                  ),
                  title: Text(servicePresentation[index].name),
                  onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 60),
                          child: ServicePresentationForm(
                              user.uid,
                              servicePresentation[index]
                                  .id), //SettingsForm(userid),
                        );
                      }),
                ),
              ),
            ),
          );
        });
  }
}
