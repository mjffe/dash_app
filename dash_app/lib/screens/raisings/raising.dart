import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/raisings/raising_list.dart';
import 'package:dashapp/screens/raisings/raising_view_model.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Raising extends StatelessWidget {
  //final AuthService _auth = AuthService();
  Raising({this.uData});
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    return Provider<RaisingViewModel>(
      create: (_) => RaisingViewModel(uData: uData),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        body: RaisingList(),
      ),
    );
  }
}

class RaisingFiltred extends StatelessWidget {
  //final AuthService _auth = AuthService();
  RaisingFiltred(this.uData);
  final UserData uData;

  @override
  Widget build(BuildContext context) {
    return Provider<RaisingViewModel>(
      create: (_) => RaisingViewModel(uData: uData),
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar: customAppBar(AppLocalizations.of(context).translate('raising'))
            .bar(),
        body: RaisingList(),
      ),
    );
  }
}
