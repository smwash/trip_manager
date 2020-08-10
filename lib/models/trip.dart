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
  final DateTimeRange tripDates;

  Trip({
    this.timestamp,
    this.tripId,
    this.title,
    this.budget,
    this.tripType,
    this.location,
    this.tripDates,
    this.tripDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'tripId': tripId,
      'budget': budget,
      'tripType': tripType,
      'location': location,
      'timestamp': timestamp,
      'tripDescription': tripDescription,
      'tripDates': tripDates,
    };
  }

  Trip.fromFirestore(Map<String, dynamic> doc)
      : title = doc['title'],
        tripId = doc['tripId'],
        budget = doc['budget'],
        tripType = doc['tripType'],
        location = doc['location'],
        timestamp = doc['timestamp'],
        tripDescription = doc['tripDescription'],
        tripDates = doc['tripDates'];
}
