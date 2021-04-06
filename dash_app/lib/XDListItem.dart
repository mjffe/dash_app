import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XDListItem extends StatelessWidget {
  XDListItem({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 360.0, 68.0),
          size: Size(260.0, 68.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xff707070)),
            ),
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 76.0, 68.0),
          size: Size(360.0, 68.0),
          pinLeft: true,
          pinTop: true,
          pinBottom: true,
          fixedWidth: true,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 1.0, color: Colors.transparent),
            ),
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(10.8, 16.7, 54.5, 34.7),
          size: Size(360.0, 68.0),
          pinLeft: true,
          pinTop: true,
          pinBottom: true,
          fixedWidth: true,
          child:
              // Adobe XD layer: 'Icon material-people' (shape)
              SvgPicture.string(
            _svg_xrfkfa,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(83.0, 6.0, 90.0, 21.0),
          size: Size(360.0, 68.0),
          pinTop: true,
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            'Mário Filipe',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 16,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(68.0, 23.0, 130.0, 21.0),
          size: Size(360.0, 68.0),
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            'mario@gmail.com',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 16,
              color: const Color(0xff000000),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(83.0, 41.0, 78.0, 21.0),
          size: Size(360.0, 68.0),
          pinBottom: true,
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            '919965361',
            style: TextStyle(
              fontFamily: 'Segoe UI',
              fontSize: 16,
              color: const Color(0xff000000),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

const String _svg_xrfkfa =
    '<svg viewBox="10.8 16.7 54.5 34.7" ><path transform="translate(9.25, 9.16)" d="M 38.65909194946289 22.3636360168457 C 42.7713623046875 22.3636360168457 46.06613922119141 19.04409027099609 46.06613922119141 14.93181800842285 C 46.06613922119141 10.81954574584961 42.7713623046875 7.499999523162842 38.65909194946289 7.499999523162842 C 34.54681777954102 7.499999523162842 31.22727203369141 10.81954574584961 31.22727203369141 14.93181800842285 C 31.22727203369141 19.04409027099609 34.54681777954102 22.3636360168457 38.65909194946289 22.3636360168457 Z M 18.84090995788574 22.3636360168457 C 22.95318222045898 22.3636360168457 26.24795532226563 19.04409027099609 26.24795532226563 14.93181800842285 C 26.24795532226563 10.81954574584961 22.95318222045898 7.499999523162842 18.84090995788574 7.499999523162842 C 14.72863578796387 7.499999523162842 11.40909004211426 10.81954574584961 11.40909004211426 14.93181800842285 C 11.40909004211426 19.04409027099609 14.72863578796387 22.3636360168457 18.84090995788574 22.3636360168457 Z M 18.84090995788574 27.31818008422852 C 13.06886291503906 27.31818008422852 1.5 30.21658706665039 1.5 35.9886360168457 L 1.5 42.18181610107422 L 36.18181991577148 42.18181610107422 L 36.18181991577148 35.9886360168457 C 36.18181991577148 30.21659088134766 24.61295509338379 27.31818008422852 18.84090995788574 27.31818008422852 Z M 38.65909194946289 27.31818008422852 C 37.94068145751953 27.31818008422852 37.1231803894043 27.36772918701172 36.25613784790039 27.44204711914063 C 39.1297721862793 29.52295684814453 41.1363639831543 32.32227325439453 41.1363639831543 35.9886360168457 L 41.1363639831543 42.18181610107422 L 56 42.18181610107422 L 56 35.9886360168457 C 56 30.21659088134766 44.43113327026367 27.31818008422852 38.65909194946289 27.31818008422852 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
