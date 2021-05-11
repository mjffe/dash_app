import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/sale.dart';
import 'package:dashapp/screens/sales/promisebuysell/promisebuysell_view_model.dart';
import 'package:dashapp/screens/sales/sales_form_panel.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_icons.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromiseBuySellList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<PromiseBuySellViewModel>(context, listen: false);
    String _getStateName(String index) {
      switch (index) {
        case '0':
          {
            return AppLocalizations.of(context).translate('promise_buy_sell');
          }
          break;
        case '1':
          {
            return AppLocalizations.of(context).translate('scriptures');
          }
          break;
        default:
          return '';
      }
    }

    return StreamBuilder<List<SaleItem>>(
        stream: viewModel.promisebuysellStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<SaleItem> sales = snapshot.data;
            return ListView.builder(
                itemCount: sales.length,
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
                              DatabaseService(
                                      uid: sales[index].createdby,
                                      docid: sales[index].id)
                                  .deleteSaleData();

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
                                AppIcoons.vendas,
                                size: 40,
                              ),
                            ),
                            title: Text(sales[index].name),
                            subtitle: Text(
                                '${AppLocalizations.of(context).translate('value')}: ${sales[index].value} \n${AppLocalizations.of(context).translate('state')}: ${_getStateName(sales[index].state)}'),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SalesFormPanel(
                                        sales[index].createdby,
                                        sales[index].id))),
                          )),
                    ),
                  );
                });
          }
          return Loading();
        });
  }
}
