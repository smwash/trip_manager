import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:trip_manager/widgets/homepage/notaskadded.dart';
import '../helpers/loading.dart';
import '../models/trip.dart';
import '../models/user.dart';
import '../services/database.dart';
import '../widgets/homepage/tripcard.dart';
import '../widgets/homepage/tripsList.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<User>(context);

    return Scaffold(
      body: user == null
          ? Loader()
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  expandedHeight: size.height * 0.2,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Trips',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    background: Stack(
                      children: [
                        Image.asset(
                          'assets/images/3617762.jpg',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black87,
                              ],
                              stops: [0.65, 2.0],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('trips')
                        .document(user.userId)
                        .collection('usertrips')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Loader();
                      }

                      var trips = snapshot.data.documents;
                      return trips.length == 0
                          ? NoTasksAdded()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: trips.length,
                              itemBuilder: (context, index) {
                                return TripCard(
                                  trip: trips[index],
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
