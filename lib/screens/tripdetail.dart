import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TripDetail extends StatelessWidget {
  final DocumentSnapshot trip;

  const TripDetail({Key key, this.trip}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(
          trip['tripColor'],
        ),
        title: Text(
          trip['title'],
          style: TextStyle(
            fontSize: 23.0,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
