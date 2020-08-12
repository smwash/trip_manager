import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<User> getUserData(String userId) async {
    return await _db
        .collection('users')
        .document(userId)
        .get()
        .then((document) => User.fromFirestore(document.data));
  }

  //create user trip:
  Future addTrip(Trip trip) async {
    return _db
        .collection('trips')
        .document(trip.tripId)
        .collection('usertrips')
        .add(trip.toMap());
  }

  // Stream<List<Trip>> getUserTrips(String userID) {
  //   return _db
  //       .collection('trips')
  //       .document(userID)
  //       .collection('usertrips')
  //       .snapshots()
  //       .map((query) => query.documents
  //           .map((snapshot) => Trip.fromFirestore(snapshot.data))
  //           .toList());
  // }
}
