import 'package:dashapp/XDLead1.dart';
import 'package:dashapp/widgets/drawerMenu.dart';
import 'package:flutter/material.dart';
import './XDListItem.dart';

class XDLead extends StatefulWidget {
  @override
  _XDLeadState createState() => _XDLeadState();
}

class _XDLeadState extends State<XDLead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'Lead',
          style: TextStyle(
            //fontFamily: 'Segoe UI',
            fontSize: 35,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff4169e1),
      ),
      drawer: dMenu(),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(0.0, -6),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 51.0),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 119.0),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 187.0),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 255.0),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 323.0),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 391.0),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 459.0),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 527.0),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 595.0),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 663.0),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 799.0),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 731.0),
            child:
                // Adobe XD layer: 'ListItem' (component)
                SizedBox(
              width: 360.0,
              height: 68.0,
              child: XDListItem(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: () {},
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => XDLead1()));
        },
        backgroundColor: Colors.blue[400],
        child: Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }
}

const String _svg_ghdnu6 =
    '<svg viewBox="-6.0 -4.0 369.0 55.0" ><path transform="translate(-6.0, -4.0)" d="M 0 0 L 369 0 L 369 55 L 0 55 L 0 0 Z" fill="#4169e1" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_a4kuxh =
    '<svg viewBox="3.0 3.0 53.0 53.0" ><path  d="M 56.00732421875 29.503662109375 C 56.00732421875 44.14123153686523 44.14123153686523 56.00732421875 29.503662109375 56.00732421875 C 14.86609363555908 56.00732421875 3.000000238418579 44.14123153686523 3.000000238418579 29.503662109375 C 3.000000238418579 14.86609363555908 14.86609363555908 3.000000238418579 29.503662109375 3.000000238418579 C 44.14123153686523 3.000000238418579 56.00732421875 14.86609363555908 56.00732421875 29.503662109375 Z" fill="none" stroke="#6751f1" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_y76aad =
    '<svg viewBox="29.5 18.9 1.0 21.2" ><path transform="translate(11.5, 6.9)" d="M 18 12.00000095367432 L 18 33.20293045043945" fill="none" stroke="#6751f1" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_me5w4b =
    '<svg viewBox="18.9 29.5 21.2 1.0" ><path transform="translate(6.9, 11.5)" d="M 12.00000095367432 18 L 33.20293045043945 18" fill="none" stroke="#6751f1" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
