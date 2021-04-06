import 'package:flutter/material.dart';

// class customAppBar extends StatelessWidget {
//   //const customAppBar({Key key}) : super(key: key);
//   customAppBar(this.apptext);
//   final String apptext;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(
//         apptext,
//         style: TextStyle(
//           fontSize: 35,
//           color: Colors.white,
//           letterSpacing: 1,
//         ),
//       ),
//       centerTitle: true,
//       backgroundColor: const Color(0xff4169e1),
//     );
//   }
// }

class customAppBar {
  customAppBar(this.apptext);
  final String apptext;

  AppBar bar() {
    return AppBar(
      title: Text(
        apptext,
        style: TextStyle(
          fontSize: 35,
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
      centerTitle: true,
      backgroundColor: const Color(0xff4169e1),
    );
  }
}
