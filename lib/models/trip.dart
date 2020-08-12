import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Trip {
  final String title;
  final String tripId;
  final double budget;
  final String tripType;
  final String location;
  final Timestamp timestamp;
  final String tripDescription;
  final DateTime startTripDate;
  final DateTime endTripDate;

  Trip({
    this.title,
    this.budget,
    this.tripId,
    this.location,
    this.tripType,
    this.timestamp,
    this.endTripDate,
    this.startTripDate,
    this.tripDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'tripId': tripId,
      'budget': budget,
      'location': location,
      'tripType': tripType,
      'timestamp': timestamp,
      'endTripDate': endTripDate,
      'startTripDate': startTripDate,
      'tripDescription': tripDescription,
    };
  }
}
