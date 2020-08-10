import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  const CustomButton({
    Key key,
    this.label,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RaisedButton(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.017,
        horizontal: size.width * 0.1,
      ),
      color: kAccentColor,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
