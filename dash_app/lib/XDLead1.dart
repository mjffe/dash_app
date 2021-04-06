import 'package:dashapp/widgets/drawerMenu.dart';
import 'package:flutter/material.dart';
import './XDInput.dart';
import './XDLead.dart';

class XDLead1 extends StatelessWidget {
  XDLead1({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
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
            offset: Offset(0.0, 0.0),
            child:
                // Adobe XD layer: 'Input' (component)
                SizedBox(
              width: 360.0,
              height: 64.0,
              child: XDInput(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 62.0),
            child:
                // Adobe XD layer: 'Input' (component)
                SizedBox(
              width: 360.0,
              height: 64.0,
              child: XDInput(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 126.0),
            child:
                // Adobe XD layer: 'Input' (component)
                SizedBox(
              width: 360.0,
              height: 64.0,
              child: XDInput(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 190.0),
            child:
                // Adobe XD layer: 'Input' (component)
                SizedBox(
              width: 360.0,
              height: 64.0,
              child: XDInput(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 254.0),
            child:
                // Adobe XD layer: 'Input' (component)
                SizedBox(
              width: 360.0,
              height: 64.0,
              child: XDInput(),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 318.0),
            child:
                // Adobe XD layer: 'Input' (component)
                SizedBox(
              width: 360.0,
              height: 64.0,
              child: XDInput(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: () {},
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => XDLead()));
        },
        backgroundColor: Colors.blue[400],
        child: Icon(
          Icons.save,
          size: 46,
        ),
      ),
    );
  }
}

const String _svg_ghdnu6 =
    '<svg viewBox="-6.0 -4.0 369.0 55.0" ><path transform="translate(-6.0, -4.0)" d="M 0 0 L 369 0 L 369 55 L 0 55 L 0 0 Z" fill="#4169e1" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_8k9utw =
    '<svg viewBox="4.5 4.5 31.4 31.4" ><path transform="translate(0.0, 0.0)" d="M 32.38476181030273 35.87035751342773 L 7.985595226287842 35.87035751342773 C 6.060553550720215 35.87035751342773 4.5 34.30980682373047 4.5 32.38476181030273 L 4.5 7.985594749450684 C 4.5 6.060553073883057 6.060555458068848 4.499999046325684 7.985596179962158 4.499999523162842 L 27.1563720703125 4.499999523162842 L 35.87035751342773 13.21398830413818 L 35.87035751342773 32.38476181030273 C 35.87035751342773 34.30980682373047 34.30980682373047 35.87035751342773 32.38476181030273 35.87035751342773 Z" fill="none" stroke="#6751f1" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_s0xs1k =
    '<svg viewBox="11.5 21.9 17.4 13.9" ><path transform="translate(0.97, 2.43)" d="M 27.92797470092773 33.44237899780273 L 27.92797470092773 19.5 L 10.5 19.5 L 10.5 33.44237899780273" fill="none" stroke="#6751f1" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
const String _svg_ag82ch =
    '<svg viewBox="11.5 4.5 13.9 8.7" ><path transform="translate(0.97, 0.0)" d="M 10.5 4.5 L 10.5 13.21398830413818 L 24.4423828125 13.21398830413818" fill="none" stroke="#6751f1" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" /></svg>';
