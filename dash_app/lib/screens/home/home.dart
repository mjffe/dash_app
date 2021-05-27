import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/main.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/authenticate/sign_out.dart';
import 'package:dashapp/screens/dashboard/dashboard.dart';
import 'package:dashapp/screens/invoicing/invoicing.dart';
import 'package:dashapp/screens/leads/lead.dart';
import 'package:dashapp/screens/mediationcontract/mediationcontract.dart';
import 'package:dashapp/screens/objective/objective.dart';
import 'package:dashapp/screens/proposal/proposal.dart';
import 'package:dashapp/screens/prospectingtime/prospectingtime.dart';
import 'package:dashapp/screens/raisings/raising.dart';
import 'package:dashapp/screens/sales/sale.dart';
import 'package:dashapp/screens/service_presentation/servicepresentation.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/app_icons.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/screens/home/floatingaction.dart';
import 'package:dashapp/shared/test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  // Home({Key key}) : super(key: key);
  Home(this.uData);
  final UserData uData;

  @override
  _HomeState createState() => _HomeState(uData);
}

class _HomeState extends State<Home> {
  _HomeState(this.uData);
  final UserData uData;
  int _selectedIndex = 0;
  DateTimeRange dateRange;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    String menuItemsthisYear =
        AppLocalizations.of(context).translate('thisYear'); //'Settings';
    const String thisYear = 'thisYear';
    String menuItemslastyear =
        AppLocalizations.of(context).translate('lastyear'); //'Share';
    const String lastyear = 'lastyear';
    String menuItemstimeRange =
        AppLocalizations.of(context).translate('timeRange'); //'Logout';
    const String timeRange = 'timeRange';
    String menuItemsQuarter = AppLocalizations.of(context).translate('quarter');
    List<MenuItem> menuItemsText;

    setMenuItem() {
      bool tyear = false;
      bool lyear = false;
      bool orther = false;
      bool quarter = false;
      if (uData.filterDateRangeStart ==
              new DateTime(DateTime.now().year, 1, 1) &&
          uData.filterDateRangeEnd == new DateTime(DateTime.now().year, 12, 31))
        tyear = true;
      else if (uData.filterDateRangeStart ==
              new DateTime(DateTime.now().year - 1, 1, 1) &&
          uData.filterDateRangeEnd ==
              new DateTime(DateTime.now().year - 1, 12, 31))
        lyear = true;
      else if (uData.filterDateRangeStart ==
              new DateTime(DateTime.now().year, 1, 1) &&
          uData.filterDateRangeEnd == new DateTime(DateTime.now().year, 3, 31))
        quarter = true;
      else if (uData.filterDateRangeStart ==
              new DateTime(DateTime.now().year, 4, 1) &&
          uData.filterDateRangeEnd == new DateTime(DateTime.now().year, 6, 30))
        quarter = true;
      else if (uData.filterDateRangeStart ==
              new DateTime(DateTime.now().year, 7, 1) &&
          uData.filterDateRangeEnd == new DateTime(DateTime.now().year, 9, 30))
        quarter = true;
      else if (uData.filterDateRangeStart ==
              new DateTime(DateTime.now().year, 10, 1) &&
          uData.filterDateRangeEnd == new DateTime(DateTime.now().year, 12, 31))
        quarter = true;
      else
        orther = true;

      return <MenuItem>[
        MenuItem('lastyear', menuItemslastyear, lyear),
        MenuItem('thisYear', menuItemsthisYear, tyear),
        MenuItem('quarter', menuItemsQuarter, quarter),
        MenuItem('timeRange', menuItemstimeRange, orther),
      ];
    }

    menuItemsText = setMenuItem();

    _onSelectItem(int index) {
      setState(() => _selectedIndex = index);
      Navigator.of(context).pop();
    }

    Future pickDateRange(BuildContext context) async {
      //origin from
      //https://www.youtube.com/watch?v=a_fGsywyL90
      dateRange = new DateTimeRange(
          start: uData.filterDateRangeStart, end: uData.filterDateRangeEnd);

      final initialDateRange = DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(hours: 24 * 3)),
      );
      final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDateRange: dateRange ?? initialDateRange,
      );

      if (newDateRange == null) return;

      //print(newDateRange);
      await DatabaseService(uid: uData.uid).updateUserInfo(
        uData.role,
        uData.name,
        uData.consultants,
        newDateRange.start,
        newDateRange.end,
      );

      setState(() => dateRange = newDateRange);
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
          return Dash(uData: uData);
        case 1:
          return Lead(uData: uData);
        case 2:
          return Raising(uData: uData);
        case 3:
          return Sale(uData: uData);
        // case 4:
        //   return Scriptures();
        case 5:
          return ServicePresentation(uData: uData);
        case 6:
          return MediationContract(uData: uData);
        case 7:
          return Proposal(uData: uData);
        // case 8:
        //   return PromiseBuySell();
        case 9:
          return ProspectingTime(uData: uData);
        case 10:
          return Invoicing(uData: uData);
        // case 11:
        //   return Text("Tela 2");
        case 20:
          return Objective();
        case 21:
          return Setings();
      }
    }

    _getAppbarActions(int pos) {
      if (pos == 0) {
        return [
          PopupMenuButton<String>(
            onSelected: (value) async {
              switch (value) {
                case thisYear:
                  await DatabaseService(uid: uData.uid).updateUserInfo(
                    uData.role,
                    uData.name,
                    uData.consultants,
                    new DateTime(DateTime.now().year, 1, 1),
                    new DateTime(DateTime.now().year, 12, 31),
                  );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainApp()));
                  break;
                case lastyear:
                  await DatabaseService(uid: uData.uid).updateUserInfo(
                    uData.role,
                    uData.name,
                    uData.consultants,
                    new DateTime(DateTime.now().year - 1, 1, 1),
                    new DateTime(DateTime.now().year - 1, 12, 31),
                  );
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainApp()));
                  break;
                case timeRange:
                  await pickDateRange(context);
                  //Utils.showSnackbar(context, 'Selected: Logout');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainApp()));
                  break;
                // case 'quarter':
                //   break;
              }
            },
            itemBuilder: (context) => menuItemsText
                .map((item) => PopupMenuItem<String>(
                      value: item.key,
                      child: item.key == 'quarter'
                          ? SubMenu(uData, item.value)
                          : Text(item.value),
                      textStyle: TextStyle(
                        color:
                            item.checked ? MyColors.normalBlue : Colors.black,
                      ),
                    ))
                .toList(),
            icon: Icon(
              Icons.filter_list,
              size: 40,
            ),
          ),
        ];
      }
      return null;
    }

    return Container(
      child: Scaffold(
        backgroundColor: MyColors.appBarBackgroundColor,
        appBar: AppBar(
          title: Text(
            _getScreenName(_selectedIndex),
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          actions: _getAppbarActions(_selectedIndex),
          centerTitle: true,
          backgroundColor: const Color(0xff4169e1),
        ),
        //customAppBar(_getScreenName(_selectedIndex)).bar(),
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
                  leading: Icon(Icons.home),
                  title:
                      Text(AppLocalizations.of(context).translate('raising')),
                  selected: 2 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(2);
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
                  leading: Icon(AppIcoons.tempoprospecao),
                  title: Text(AppLocalizations.of(context)
                      .translate('prospecting_time')),
                  selected: 9 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(9);
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
                  leading: Icon(AppIcoons.vendas),
                  title: Text(AppLocalizations.of(context).translate('sales')),
                  selected: 3 == _selectedIndex,
                  onTap: () {
                    _onSelectItem(3);
                  }),
              // ListTile(
              //     leading: Icon(AppIcoons.escrituras),
              //     title: Text(
              //         AppLocalizations.of(context).translate('scriptures')),
              //     selected: 4 == _selectedIndex,
              //     onTap: () {
              //       _onSelectItem(4);
              //     }),

              // ListTile(
              //     leading: Icon(AppIcoons.promecacompravenda),
              //     title: Text(AppLocalizations.of(context)
              //         .translate('promise_buy_sell')),
              //     selected: 8 == _selectedIndex,
              //     onTap: () {
              //       _onSelectItem(8);
              //     }),

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
                    _onSelectItem(20);
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
        floatingActionButton:
            FoatingAction.setActionButton_Home(_selectedIndex, uData, context),
      ),
    );
  }
}

class MenuItem {
  MenuItem(this.key, this.value, this.checked);
  String key;
  String value;
  bool checked;
}

enum Quarter { quarter1, quarter2, quarter3, quarter4 }

class SubMenu extends StatefulWidget {
  final String title;
  final UserData uData;
  const SubMenu(this.uData, this.title);

  @override
  _SubMenuState createState() => _SubMenuState(uData);
}

class _SubMenuState extends State<SubMenu> {
  //https://stackoverflow.com/questions/60795584/flutter-web-need-menu-with-sub-menu
  _SubMenuState(this.uData);
  final UserData uData;
  Quarter _selection = Quarter.quarter1;

  @override
  Widget build(BuildContext context) {
//     print(rendBox.size.bottomRight);

    bool q1 = (uData.filterDateRangeStart ==
            new DateTime(DateTime.now().year, 1, 1) &&
        uData.filterDateRangeEnd == new DateTime(DateTime.now().year, 3, 31));

    bool q2 = (uData.filterDateRangeStart ==
            new DateTime(DateTime.now().year, 4, 1) &&
        uData.filterDateRangeEnd == new DateTime(DateTime.now().year, 6, 30));

    bool q3 = (uData.filterDateRangeStart ==
            new DateTime(DateTime.now().year, 7, 1) &&
        uData.filterDateRangeEnd == new DateTime(DateTime.now().year, 9, 30));

    bool q4 = (uData.filterDateRangeStart ==
            new DateTime(DateTime.now().year, 10, 1) &&
        uData.filterDateRangeEnd == new DateTime(DateTime.now().year, 12, 31));

    return PopupMenuButton<Quarter>(
      child: Row(
        children: <Widget>[
          Text(widget.title),
          //Spacer(),
          Icon(Icons.arrow_drop_down, size: 20.0, color: MyColors.lightBlue),
        ],
      ),
      onCanceled: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      onSelected: (Quarter result) async {
        switch (result) {
          case Quarter.quarter1:
            await DatabaseService(uid: uData.uid).updateUserInfo(
              uData.role,
              uData.name,
              uData.consultants,
              new DateTime(DateTime.now().year, 1, 1),
              new DateTime(DateTime.now().year, 3, 31),
            );
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainApp()));
            break;
          case Quarter.quarter2:
            await DatabaseService(uid: uData.uid).updateUserInfo(
              uData.role,
              uData.name,
              uData.consultants,
              new DateTime(DateTime.now().year, 4, 1),
              new DateTime(DateTime.now().year, 6, 30),
            );
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainApp()));
            break;
          case Quarter.quarter3:
            await DatabaseService(uid: uData.uid).updateUserInfo(
              uData.role,
              uData.name,
              uData.consultants,
              new DateTime(DateTime.now().year, 7, 1),
              new DateTime(DateTime.now().year, 9, 30),
            );
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainApp()));
            break;
          case Quarter.quarter4:
            await DatabaseService(uid: uData.uid).updateUserInfo(
              uData.role,
              uData.name,
              uData.consultants,
              new DateTime(DateTime.now().year, 10, 1),
              new DateTime(DateTime.now().year, 12, 31),
            );
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainApp()));
            break;
        }
      },
      // how much the submenu should offset from parent. This seems to have an upper limit.
      offset: Offset(300, 0),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Quarter>>[
        PopupMenuItem<Quarter>(
          value: Quarter.quarter1,
          child: Text(AppLocalizations.of(context).translate('1quarter')
              //'1º Quarter'
              ),
          textStyle: TextStyle(
            color: q1 ? MyColors.normalBlue : Colors.black,
          ),
        ),
        PopupMenuItem<Quarter>(
          value: Quarter.quarter2,
          child: Text(AppLocalizations.of(context).translate('2quarter')),
          textStyle: TextStyle(
            color: q2 ? MyColors.normalBlue : Colors.black,
          ),
        ),
        PopupMenuItem<Quarter>(
          value: Quarter.quarter3,
          child: Text(AppLocalizations.of(context).translate('3quarter')),
          textStyle: TextStyle(
            color: q3 ? MyColors.normalBlue : Colors.black,
          ),
        ),
        PopupMenuItem<Quarter>(
          value: Quarter.quarter4,
          child: Text(AppLocalizations.of(context).translate('4quarter')),
          textStyle: TextStyle(
            color: q4 ? MyColors.normalBlue : Colors.black,
          ),
        ),
      ],
    );
  }
}
