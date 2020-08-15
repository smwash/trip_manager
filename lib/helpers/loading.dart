import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trip_manager/constants.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: kBlackColor,
    );
  }
}

Container linearProgress() {
  return Container(
    padding: EdgeInsets.only(
      bottom: 10.0,
    ),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        kBlackColor,
      ),
    ),
  );
}
