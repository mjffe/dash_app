import 'package:dashapp/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.darkBlue,
      child: Center(
        child: SpinKitWanderingCubes(
          color: MyColors.normalBlue,
          size: 50.0,
        ),
      ),
    );
  }
}
