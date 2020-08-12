import 'package:flutter/material.dart';

const kAccentColor = Color(0xffeca836);
const kTripCardColor = Color(0xffe4ebf5);
const kBlackColor = Color(0xff454140);

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.w600,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15.0),
    ),
    borderSide: BorderSide(
      color: kBlackColor,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15.0),
    ),
    borderSide: BorderSide(
      color: Color(0xfff3c67c),
    ),
  ),
);

const kAddTripTextFieldDeco = InputDecoration(
  labelText: '',
  labelStyle: TextStyle(
    fontSize: 17.0,
    letterSpacing: 1.0,
    color: Colors.black,
    fontWeight: FontWeight.w800,
  ),
  border: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
    ),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
    ),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.black,
    ),
  ),
);
