import 'package:dashapp/XDDash.dart';
import 'package:dashapp/helppers/app_icons.dart';
import 'package:flutter/material.dart';
import '../XDLead.dart';
import '../testSnippet.dart';

class dMenu extends StatelessWidget {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 90.0,
              child: DrawerHeader(
                decoration: BoxDecoration(color: const Color(0xff4169e1)),
                child: Container(
                  child: Text(
                    'Menu',
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
              title: Text('Dashboard'),
              selected: _selectedDestination == 0,
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Dash())),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Leads'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => XDLead())),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Raising'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => XDLead())),
            ),
            ListTile(
              leading: Icon(AppIcoons.vendas),
              title: Text('Sales'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => XDLead())),
            ),
            // ListTile(
            //   leading: Icon(Icons.settings),
            //   title: Text('Fundraising'),
            // ),
            ListTile(
              leading: Icon(AppIcoons.escrituras),
              title: Text('Scriptures'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => XDLead())),
            ),
            ListTile(
              leading: Icon(AppIcoons.apresentacaoservico),
              title: Text('Service Presentation'),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyHomePage(title: 'Flutter Demo Home Page'))),
            ),
            ListTile(
              leading: Icon(AppIcoons.contratomediacao),
              title: Text('Mediation Contract'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => XDLead())),
            ),
            ListTile(
              leading: Icon(AppIcoons.proposta),
              title: Text('Proposal'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => XDLead())),
            ),
            ListTile(
              leading: Icon(AppIcoons.promecacompravenda),
              title: Text('Promise to Buy and Sell'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => XDLead())),
            ),
            ListTile(
              leading: Icon(AppIcoons.tempoprospecao),
              title: Text('Prospecting Time'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => XDLead())),
            ),
            ListTile(
              leading: Icon(AppIcoons.faturacao),
              title: Text('Invoicing'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => XDLead())),
            ),
            ListTile(
              leading: Icon(AppIcoons.vendas),
              title: Text('Sales'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => XDLead())),
            ),
            Divider(
              height: 5,
              thickness: 5,
            ),
            ListTile(
              leading: Icon(AppIcoons.objetivo),
              title: Text('Objectives'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => XDLead())),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => XDLead())),
            ),
          ],
        ),
      ),
    );
  }

  void selectDestination(int index) {
    // setState(() {
    //   _selectedDestination = index;
    // });
  }
}

//BoxDecoration(color: const Color(0xff6495ed))
