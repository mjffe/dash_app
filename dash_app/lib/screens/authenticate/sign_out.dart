import 'package:dashapp/service/auth.dart';
import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';

class SignOut extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
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
                color: MyColors.lightBlue,
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
    );
  }
}
