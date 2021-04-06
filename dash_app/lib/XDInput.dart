import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

class XDInput extends StatelessWidget {
  XDInput({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 360.0, 64.0),
          size: Size(360.0, 64.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 1.0, color: Colors.transparent),
            ),
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(8.0, 2.0, 54.0, 21.0),
          size: Size(360.0, 64.0),
          pinLeft: true,
          pinTop: true,
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            'Nome: ',
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
          bounds: Rect.fromLTWH(8.0, 27.0, 342.0, 32.0),
          size: Size(360.0, 64.0),
          pinLeft: true,
          pinRight: true,
          pinBottom: true,
          fixedHeight: true,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xff707070)),
            ),
          ),
        ),
      ],
    );
  }
}
