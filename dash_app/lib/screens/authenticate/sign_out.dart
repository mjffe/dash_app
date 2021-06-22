import 'package:dashapp/app_localizations.dart';
import 'package:dashapp/main.dart';
import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/home/home.dart';
import 'package:dashapp/screens/wrapper.dart';
import 'package:dashapp/service/auth.dart';
import 'package:dashapp/service/database.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setings extends StatefulWidget {
  Setings({Key key}) : super(key: key);

  @override
  _SetingsState createState() => _SetingsState();
}

class _SetingsState extends State<Setings> {
  final AuthService _auth = AuthService();

  String _role = '';
  final _formkey = GlobalKey<FormState>();
  final List<String> _roles = [
    '0',
    '1',
    '2',
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    String _getRoleTypeName(String index) {
      switch (index) {
        case '0':
          {
            return AppLocalizations.of(context).translate('direction');
          }
          break;
        case '1':
          {
            return AppLocalizations.of(context)
                .translate('commercialdirection');
          }
          break;
        case '2':
          {
            return AppLocalizations.of(context).translate('consultant');
          }
          break;
        default:
          return '';
      }
    }
    // return StreamProvider<UserData>.value(
    //   initialData: null,
    //   value: DatabaseService().userInfo(user.uid),
    //   child: Scaffold(
    //       backgroundColor: MyColors.appBarBackgroundColor, body: SignOut()),
    // );

    return StreamBuilder<UserData>(
        stream: DatabaseService().userInfo(user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData data = snapshot.data;
            return Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text("${data.name}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      value: data.role,
                      //decoration: textInputDecoration,
                      decoration: textInputDecoration.copyWith(
                        hintText:
                            AppLocalizations.of(context).translate('lead_type'),
                      ),
                      items: _roles.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(_getRoleTypeName(type)),
                        );
                      }).toList(),
                      // validator: (val) => val == null
                      //     ? AppLocalizations.of(context)
                      //         .translate('validleadtype')
                      //     : null,
                      onChanged: (val) => setState(() => _role = val),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                        color: MyColors.lightBlue,
                        child: Text(
                          AppLocalizations.of(context).translate('update'),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            await DatabaseService(uid: data.uid).updateUserInfo(
                              _role ?? '',
                              data.name,
                              data.consultants,
                              data.leadtypes,
                              data.filterDateRangeStart,
                              data.filterDateRangeEnd,
                            );
                            // Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainApp()));
                          }
                        }),
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RaisedButton.icon(
                          //padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 80.0),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          icon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          color: Colors.red,
                          label: Text(
                            'Logout',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          onPressed: () async {
                            await _auth.signOut();
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
