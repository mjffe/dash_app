import 'package:dashapp/models/user.dart';
import 'package:dashapp/screens/authenticate/authenticate.dart';
import 'package:dashapp/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'home/home.dart';

// class Wrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // return either the Home or Authenticate widget
//     final user = Provider.of<FirebaseUser>(context);
//     if (user == null)
//       return Authenticate();
//     else
//       return Home();
//   }
// }

class Wrapper extends StatefulWidget {
  //Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    if (user == null)
      return Authenticate();
    else
      return Home();
  }
}