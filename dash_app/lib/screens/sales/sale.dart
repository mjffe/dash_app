import 'package:dashapp/models/sale.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/sales/sales_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Sale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<SaleItem>>.value(
      initialData: null,
      value: DatabaseService().getsales(user),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: SaleList(),
      ),
    );
  }
}
