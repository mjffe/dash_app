import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/helppers/app_icons.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/authenticate/sign_out.dart';
import 'package:dashapp/screens/leads/lead.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/floatingaction.dart';
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
      switch (index) {
        case 0:
          {
            setState(() => _screenName = 'Dashboard');
          }
          break;
        case 1:
          {
            setState(() => _screenName = 'Leads');
          }
          break;
        case 2:
          {
            setState(() => _screenName = 'Raising');
          }
          break;
        case 3:
          {
            setState(() => _screenName = 'Sales');
          }
          break;
        case 4:
          {
            setState(() => _screenName = 'Scriptures');
          }
          break;
        case 5:
          {
            setState(() => _screenName = 'Service Presentation');
          }
          break;
        case 6:
          {
            setState(() => _screenName = 'Mediation Contract');
          }
          break;
        case 7:
          {
            setState(() => _screenName = 'Proposal');
          }
          break;
        case 8:
          {
            setState(() => _screenName = 'Promise to Buy and Sell');
          }
          break;
        case 9:
          {
            setState(() => _screenName = 'Prospecting Time');
          }
          break;
        case 10:
          {
            setState(() => _screenName = 'Invoicing');
          }
          break;
        case 11:
          {
            setState(() => _screenName = 'Sales');
          }
          break;
        case 20:
          {
            setState(() => _screenName = 'Objectives');
          }
          break;
        case 21:
          {
            setState(() => _screenName = 'Settings');
          }
          break;
      }
      Navigator.of(context).pop();
    }

    _getDrawerItem(int pos) {
      switch (pos) {
        case 0:
          return Text("Tela 1");
        case 1:
          return Lead();
        case 2:
          return Text(AppLocalizations.of(context).translate('first_string'));
        case 3:
          return Text("Tela 2");
        case 4:
          return Text("Tela 2");
        case 5:
          return Text("Tela 2");
        case 5:
          return Text("Tela 2");
        case 6:
          return Text("Tela 2");
        case 7:
          return Text("Tela 2");
        case 8:
          return Text("Tela 2");
        case 9:
          return Text("Tela 2");
        case 10:
          return Text("Tela 2");
        case 11:
          return Text("Tela 2");
        case 20:
          return Text("Tela 2");
        case 21:
          return SignOut();
      }
    }

    return Container(
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar: customAppBar(_screenName).bar(),
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
