import 'package:dashapp/screens/authenticate/register.dart';
import 'package:dashapp/shared/app_bar.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:dashapp/service/auth.dart';
import 'package:dashapp/shared/constants.dart';
import 'package:dashapp/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool _loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: customAppBar('Sign in').bar(),
            // AppBar(
            //   title: Text(
            //     'Sign in',
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
            //         label: Text('Registar'))
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
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                            hintText: 'Password',
                          ),
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
                              'Sign in',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() => _loading = true);
                                dynamic result = await _auth
                                    .signInWithEmailPassword(email, password);
                                if (result == null) {
                                  setState(() {
                                    error =
                                        'Could not sign in with those credentials';
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
                        ),
                        FlatButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                              //widget.toggleView();
                            },
                            icon: Icon(Icons.person),
                            label: Text('Registar'))
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
