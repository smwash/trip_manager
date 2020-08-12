import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    Key key,
    this.onTap,
    @required this.icon,
    @required this.iconColor,
    @required this.borderColor,
  }) : super(key: key);

  final Function onTap;
  final IconData icon;
  final Color iconColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(
          size.height * 0.007,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor,
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: size.height * 0.04,
        ),
      ),
      onTap: onTap,
    );
  }
}
