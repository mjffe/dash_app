import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/helppers/app_icons.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/authenticate/sign_out.dart';
import 'package:dashapp/screens/invoicing/invoicing.dart';
import 'package:dashapp/screens/leads/lead.dart';
import 'package:dashapp/screens/mediationcontract/mediationcontract.dart';
import 'package:dashapp/screens/promisebuysell/promisebuysell.dart';
import 'package:dashapp/screens/proposal/proposal.dart';
import 'package:dashapp/screens/prospectingtime/prospectingtime.dart';
import 'package:dashapp/screens/raisings/raising.dart';
import 'package:dashapp/screens/sales/sale.dart';
import 'package:dashapp/screens/scriptures/scripture.dart';
import 'package:dashapp/screens/service_presentation/servicepresentation.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/screens/home/floatingaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    String _screenName =
        AppLocalizations.of(context).translate('dashboard'); //'Home';

    _onSelectItem(int index) {
      setState(() => _selectedIndex = index);
      Navigator.of(context).pop();
    }

    String _getScreenName(int index) {
      switch (index) {
        case 0:
          {
            return AppLocalizations.of(context).translate('dashboard');
          }
          break;
        case 1:
          {
            return AppLocalizations.of(context).translate('leads');
          }
          break;
        case 2:
          {
            return AppLocalizations.of(context).translate('raising');
          }
          break;
        case 3:
          {
            return AppLocalizations.of(context).translate('sales');
          }
          break;
        case 4:
          {
            return AppLocalizations.of(context).translate('scriptures');
          }
          break;
        case 5:
          {
            return AppLocalizations.of(context)
                .translate('service_presentation');
          }
          break;
        case 6:
          {
            return AppLocalizations.of(context).translate('mediation_contract');
          }
          break;
        case 7:
          {
            return AppLocalizations.of(context).translate('proposal');
          }
          break;
        case 8:
          {
            return AppLocalizations.of(context).translate('promise_buy_sell');
          }
          break;
        case 9:
          {
            return AppLocalizations.of(context).translate('prospecting_time');
          }
          break;
        case 10:
          {
            return AppLocalizations.of(context).translate('invoicing');
          }
          break;
        case 20:
          {
            return AppLocalizations.of(context).translate('objectives');
          }
          break;
        case 21:
          {
            return AppLocalizations.of(context).translate('settings');
          }
          break;
        default:
          return AppLocalizations.of(context).translate('dashboard');
      }
    }

    _getDrawerItem(int pos) {
      switch (pos) {
        case 0:
          return Text("Tela 1");
        case 1:
          return Lead();
        case 2:
          return Raising();
        case 3:
          return Sale();
        case 4:
          return Scriptures();
        case 5:
          return ServicePresentation();
        case 6:
          return MediationContract();
        case 7:
          return Proposal();
        case 8:
          return PromiseBuySell();
        case 9:
          return ProspectingTime();
        case 10:
          return Invoicing();
        // case 11:
        //   return Text("Tela 2");
        case 20:
          return Text("Tela 2");
        case 21:
          return SignOut();
      }
    }

    return Container(
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar: customAppBar(_getScreenName(_selectedIndex)).bar(),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 90.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: const Color(0xff4169e1)),
                  child: Container(
                    child: Text(
                      AppLocalizations.of(context).translate('menu'),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              ListTile(
                  leading: Icon(AppIcoons.dashboard),
                  title:
                      Text(AppLocalizations.of(context).translate('dashboard')),
                  selected: 0 == _selectedIndex,
                  //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Dash())),
                  onTap: () {
                    _onSelectItem(0);
                  }),
              ListTile(
                  leading: Icon(Icons.people),
                  title: Text(AppLocalizations.of(context).translate('leads')),
                  selected: 1 == _selectedIndex,
                  //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => XDLead())),
                  onTap: () {
                    _onSelectItem(1);
                  }),
              ListTile(
                  leading: Icon(Icons.home),
                  title:
                      Text(AppLocalizations.of(context).translate('raising')),
                  selected: 2 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(2);
                  }),
              ListTile(
                  leading: Icon(AppIcoons.vendas),
                  title: Text(AppLocalizations.of(context).translate('sales')),
                  selected: 3 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(3);
                  }),
              ListTile(
                  leading: Icon(AppIcoons.escrituras),
                  title: Text(
                      AppLocalizations.of(context).translate('scriptures')),
                  selected: 4 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(4);
                  }),
              ListTile(
                  leading: Icon(AppIcoons.apresentacaoservico),
                  title: Text(AppLocalizations.of(context)
                      .translate('service_presentation')),
                  selected: 5 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(5);
                  }),
              ListTile(
                  leading: Icon(AppIcoons.contratomediacao),
                  title: Text(AppLocalizations.of(context)
                      .translate('mediation_contract')),
                  selected: 6 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(6);
                  }),
              ListTile(
                  leading: Icon(AppIcoons.proposta),
                  title:
                      Text(AppLocalizations.of(context).translate('proposal')),
                  selected: 7 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(7);
                  }),
              ListTile(
                  leading: Icon(AppIcoons.promecacompravenda),
                  title: Text(AppLocalizations.of(context)
                      .translate('promise_buy_sell')),
                  selected: 8 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(8);
                  }),
              ListTile(
                  leading: Icon(AppIcoons.tempoprospecao),
                  title: Text(AppLocalizations.of(context)
                      .translate('prospecting_time')),
                  selected: 9 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(9);
                  }),
              ListTile(
                  leading: Icon(AppIcoons.faturacao),
                  title:
                      Text(AppLocalizations.of(context).translate('invoicing')),
                  selected: 10 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(10);
                  }),
              // ListTile(
              //     leading: Icon(AppIcoons.vendas),
              //     title: Text('Sales'),
              //     selected: 11 == _selectedIndex,
              //     onTap: () {
              //       _onSelectItem(11);
              //     }),
              Divider(
                height: 5,
                thickness: 5,
              ),
              ListTile(
                  leading: Icon(AppIcoons.objetivo),
                  title: Text(
                      AppLocalizations.of(context).translate('objectives')),
                  selected: 20 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(0);
                  }),
              ListTile(
                  leading: Icon(Icons.settings),
                  title:
                      Text(AppLocalizations.of(context).translate('settings')),
                  selected: 21 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(21);
                  }),
            ],
          ),
        ),
        body: _getDrawerItem(_selectedIndex),
        floatingActionButton: FoatingAction.setActionButton_Home(
            _selectedIndex, user.uid, context),
      ),
    );
  }
}
