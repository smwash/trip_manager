import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    this.onsaved,
    this.hintText,
    this.validator,
    this.icon,
    this.obscureText = false,
    this.iconButton,
  }) : super(key: key);
  final IconData icon;
  final String hintText;
  final Function onsaved;
  final bool obscureText;
  final Widget iconButton;
  final Function validator;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFormField(
      cursorColor: kBlackColor,
      obscureText: obscureText,
      decoration: kTextFieldDecoration.copyWith(
        contentPadding: EdgeInsets.symmetric(
          vertical: size.height * 0.022,
          horizontal: size.width * 0.05,
        ),
        prefixIcon: Icon(
          icon,
        ),
        suffixIcon: iconButton,
        hintText: hintText,
      ),
      validator: validator,
      onSaved: onsaved,
    );
  }
}
