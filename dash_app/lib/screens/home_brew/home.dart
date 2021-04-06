import 'package:dashapp/models/brew.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/home_brew/brew_list.dart';
import 'package:dashapp/screens/home_brew/settings_form.dart';
import 'package:dashapp/service/auth.dart';
import 'package:dashapp/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    print(user.uid);

    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(user.uid),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      initialData: null,
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text(
            'Home',
            // style: TextStyle(
            //   //fontFamily: 'Segoe UI',
            //   fontSize: 35,
            //   color: Colors.white,
            //   letterSpacing: 1,
            // ),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: const Color(0xff4169e1),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('logout')),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings),
                label: Text(''))
          ],
        ),
        //drawer: dMenu(),
        body: BrewList(),
      ),
    );
  }
}
