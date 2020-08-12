import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trip_manager/constants.dart';
import 'package:trip_manager/models/trip.dart';

class TripCard extends StatelessWidget {
  final DocumentSnapshot trip;

  const TripCard({Key key, this.trip}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime startDate = DateTime.parse(
      trip['startTripDate'].toDate().toString(),
    );
    DateTime endDate = DateTime.parse(
      trip['endTripDate'].toDate().toString(),
    );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: kTripCardColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          // Container(
          //   width: size.height * 0.008,
          //   height: double.infinity,
          //   color: Colors.black,
          // ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TripsRichText(
                  titleLabel: 'Trip Title:  ',
                  titleDescription: trip['title'],
                ),
                SizedBox(height: size.height * 0.015),
                Row(
                  children: [
                    TripsRichText(
                      titleLabel: 'Trip Dates:  ',
                      titleDescription:
                          DateFormat().add_yMMMd().format(startDate),
                    ),
                    TripsRichText(
                      titleLabel: '  -  ',
                      titleDescription:
                          DateFormat().add_yMMMd().format(endDate),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.015),
                TripsRichText(
                  titleLabel: 'Budget:  ',
                  titleDescription: trip['budget'].toString(),
                ),
                SizedBox(height: size.height * 0.004),
                TripsRichText(
                  titleLabel: 'Location:  ',
                  titleDescription: trip['location'],
                ),
                SizedBox(height: size.height * 0.004),
                TripsRichText(
                  titleLabel: 'Form of transport:  ',
                  titleDescription: trip['tripType'],
                ),
                SizedBox(height: size.height * 0.004),
                TripsRichText(
                  titleLabel: 'Description:  ',
                  titleDescription: trip['tripDescription'],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TripsRichText extends StatelessWidget {
  final String titleLabel;
  final String titleDescription;

  const TripsRichText({
    Key key,
    this.titleLabel,
    this.titleDescription,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: titleLabel,
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: titleDescription,
            style: TextStyle(
              fontSize: 15.5,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
