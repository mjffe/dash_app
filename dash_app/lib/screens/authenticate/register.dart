import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/service/auth.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  //Register({Key key, void Function() toggleView}) : super(key: key);
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  //text field state
  String name = '';
  String email = '';
  String password = '';
  String error = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: customAppBar('Novo Registo').bar(),
            // AppBar(
            //   title: Text(
            //     'Novo Registo',
            //     style: TextStyle(
            //       //fontFamily: 'Segoe UI',
            //       fontSize: 35,
            //       color: Colors.white,
            //       letterSpacing: 1,
            //     ),
            //   ),
            //   centerTitle: true,
            //   backgroundColor: MyColors.appBarBackgroundColor,
            //   actions: <Widget>[
            //     FlatButton.icon(
            //         onPressed: () {
            //           widget.toggleView();
            //         },
            //         icon: Icon(Icons.person),
            //         label: Text('Sign In'))
            //   ],
            // ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Name',
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Name' : null,
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Email',
                          ),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
                          ),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Enter a passwort 6+ chars long'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                            color: MyColors.buttonColor,
                            child: Text(
                              'Registar',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() {
                                  _loading = true;
                                });
                                dynamic result =
                                    await _auth.registerWithEmailPassword(
                                        name, email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'please supply a valid email';
                                    _loading = false;
                                  });
                                }
                              }
                            }),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          error,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ))
                // RaisedButton(
                //   child: Text('sign in anon'),
                //   onPressed: () async {
                //     dynamic result = await _auth.signInAnon();
                //     if (result == null) {
                //       print('error signing in');
                //     } else {
                //       print('signed in');
                //       print(result);
                //     }
                //   },
                // ),
                ),
          );
  }
}
