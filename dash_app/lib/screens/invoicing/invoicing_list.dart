import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/invoicing.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/invoicing/invoicing_form_panel.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_icons.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvoicingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final invoicing = Provider.of<List<InvoicingItem>>(context) ?? [];

    //return Text('sdfsdf');
    return ListView.builder(
        itemCount: invoicing.length,
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
                    print('name:${invoicing[index].name} ');
                    DatabaseService(uid: user.uid, docid: invoicing[index].id)
                        .deleteInvoicingData();

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
                      AppIcoons.faturacao,
                      size: 40,
                    ),
                  ),
                  title: Text(invoicing[index].name),
                  subtitle: Text(
                      '${AppLocalizations.of(context).translate('value')}:${invoicing[index].value} '),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvoicingFormPanel(
                              user.uid, invoicing[index].id))),
                ),
              ),
            ),
          );
        });
  }
}
