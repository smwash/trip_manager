import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_manager/models/trip.dart';
import 'package:trip_manager/models/user.dart';

class Database {
  final _db = Firestore.instance;

  //add user to firestore
  Future<void> addUser(User user) async {
    return await _db
        .collection('users')
        .document(user.userId)
        .setData(user.toMap());
  }

  //fetcuserdata:
  Stream<User> getUserData(String userId) {
    return _db
        .collection('users')
        .document(userId)
        .snapshots()
        .map((document) => User.fromFirestore(document.data));
  }

  Future updateUserData(User user) async {
    return await _db
        .collection('users')
        .document(user.userId)
        .updateData(user.toMap());
  }

  //create user trip:
  Future addTrip({
    @required Trip trip,
    @required String userId,
  }) async {
    return await _db
        .collection('trips')
        .document(userId)
        .collection('usertrips')
        .document(trip.tripId)
        .setData(trip.toMap());
  }

  Future updateTrip({
    @required String userId,
    @required Trip trip,
  }) async {
    return await _db
        .collection('trips')
        .document(userId)
        .collection('usertrips')
        .document(trip.tripId)
        .updateData(trip.toMap());
  }

  Future deleteTrip({
    @required String userId,
    @required String tripId,
  }) async {
    return await _db
        .collection('trips')
        .document(userId)
        .collection('usertrips')
        .document(tripId)
        .delete();
  }
}
