import 'package:flutter/material.dart';

class TripsRichText extends StatelessWidget {
  final String titleLabel;
  final String titleDescription;

  const TripsRichText({
    Key key,
    this.titleLabel,
    this.titleDescription,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: titleLabel,
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: titleDescription,
            style: TextStyle(
              fontSize: 15.5,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
