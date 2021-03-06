import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/invoicing/invoicing_form_panel.dart';
import 'package:dashapp/screens/leads/lead_form_panel.dart';
import 'package:dashapp/screens/mediationcontract/mediationcontract_form.dart';
import 'package:dashapp/screens/objective/objective_form.dart';
import 'package:dashapp/screens/promisebuysell/promisebuysell_form.dart';
import 'package:dashapp/screens/proposal/proposal_form_panel.dart';
import 'package:dashapp/screens/prospectingtime/prospectingtime_form.dart';
import 'package:dashapp/screens/raisings/raising_form.dart';
import 'package:dashapp/screens/sales/sales_form_panel.dart';
import 'package:dashapp/screens/scriptures/scripture_form.dart';
import 'package:dashapp/screens/service_presentation/servicepresentation_form.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';

class FoatingAction {
  static final Color bgcolor = MyColors.lightBlue2;
  static final Widget icon = Icon(
    Icons.add,
    size: 50,
  );

  static setActionButton_Home(int pos, UserData uData, BuildContext context) {
    switch (pos) {
      // case 0:
      //   //dashboard
      //   return FloatingActionButton(
      //     // onPressed: () => showModalBottomSheet(
      //     //     context: context,
      //     //     builder: (context) {
      //     //       return Container(
      //     //         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
      //     //         child: DashFormPanel(uData: uData), //SettingsForm(userid),
      //     //       );
      //     //     }),
      //     onPressed: () => Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => DashFormPanel(uData: uData))),
      //     backgroundColor: bgcolor,
      //     child: Icon(
      //       Icons.filter_list,
      //       size: 50,
      //     ),
      //   );
      case 1:
        return FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LeadFormPanel(uData.uid, ''))),
          backgroundColor: bgcolor,
          child: icon,
        );
      case 2:
        return FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: RaisingForm(uData.uid, ''), //SettingsForm(userid),
                );
              }),
          backgroundColor: bgcolor,
          child: icon,
        );
      case 3:
        return FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SalesFormPanel(uData.uid, ''))),
          backgroundColor: bgcolor,
          child: icon,
        );
      case 4:
        return FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: ScripturesForm(uData.uid, ''), //SettingsForm(userid),
                );
              }),
          backgroundColor: bgcolor,
          child: icon,
        );
      case 5:
        return FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: ServicePresentationForm(
                      uData.uid, ''), //SettingsForm(userid),
                );
              }),
          backgroundColor: bgcolor,
          child: icon,
        );
      case 6:
        return FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: MediationContractForm(
                      uData.uid, ''), //SettingsForm(userid),
                );
              }),
          backgroundColor: bgcolor,
          child: icon,
        );
      case 7:
        return FloatingActionButton(
          // onPressed: () => showModalBottomSheet(
          //     context: context,
          //     builder: (context) {
          //       return Container(
          //         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          //         child: ProposalForm(uData.uid, ''), //SettingsForm(userid),
          //       );
          //     }),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProposalForm(uData.uid, ''))),
          backgroundColor: bgcolor,
          child: icon,
        );
      case 8:
        return FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child:
                      PromiseBuySellForm(uData.uid, ''), //SettingsForm(userid),
                );
              }),
          backgroundColor: bgcolor,
          child: icon,
        );
      case 9:
        return FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: ProspectingTimeForm(
                      uData.uid, ''), //SettingsForm(userid),
                );
              }),
          backgroundColor: bgcolor,
          child: icon,
        );
      case 10:
        return FloatingActionButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InvoicingFormPanel(uData.uid, ''))),
          backgroundColor: bgcolor,
          child: icon,
        );

      case 20:
        return FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: ObjectiveForm(uData.uid, ''), //SettingsForm(userid),
                );
              }),
          backgroundColor: bgcolor,
          child: icon,
        );
      default:
        return null;
    }
  }
}
