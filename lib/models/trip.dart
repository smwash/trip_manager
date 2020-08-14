import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Trip {
  bool isFavorite;
  final int budget;
  final String title;
  final String tripId;
  final Color tripColor;
  final String tripType;
  final String location;
  final Timestamp timestamp;
  final DateTime endTripDate;
  final String tripDescription;
  final DateTime startTripDate;

  Trip({
    this.title,
    this.budget,
    this.tripId,
    this.location,
    this.tripType,
    this.timestamp,
    this.tripColor,
    this.endTripDate,
    this.startTripDate,
    this.tripDescription,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'tripId': tripId,
      'budget': budget,
      'location': location,
      'tripType': tripType,
      'timestamp': timestamp,
      'isFavorite': isFavorite,
      'endTripDate': endTripDate,
      'tripColor': tripColor.value,
      'startTripDate': startTripDate,
      'tripDescription': tripDescription,
    };
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
