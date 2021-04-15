import 'package:dashapp/models/user.dart';
import 'package:dashapp/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class dashtest extends StatelessWidget {
  const dashtest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    // return MultiProvider(
    //   providers: [
    //    DatabaseService().getleads(user)
    //   ],
    //   child: MaterialApp(
    //     home: Home(),
    //   ),
    // );
    //   return StreamProvider<List<LeadItem>>.value(
    //     initialData: null,
    //     value: DatabaseService().getleads(user),
    //     child: Scaffold(
    //       backgroundColor: MyColors.appBarBackgroundColor,
    //       body: LeadList(),
    //     ),
    //   );
  }
}
