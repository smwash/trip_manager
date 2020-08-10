import 'package:flutter/material.dart';
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
      body: CustomScrollView(
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
            child: FutureBuilder<List<Trip>>(
              future: Database().getUserTrips(user.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loader();
                } else if (!snapshot.hasData) {
                  return NoTasksAdded();
                }
                final trips = snapshot.data;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return TripCard();
                    },
                    childCount: trips.length,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
