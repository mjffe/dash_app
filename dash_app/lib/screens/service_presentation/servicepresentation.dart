import 'package:dashapp/models/servicepresentation.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/service_presentation/servicepresentation_list.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicePresentation extends StatelessWidget {
  //final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<ServicePresentationItem>>.value(
      initialData: null,
      value: DatabaseService().getservicepresentations(user),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: ServicePresentationList(),
      ),
    );
  }
}
