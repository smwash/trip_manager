import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trip_manager/constants.dart';
import 'package:trip_manager/helpers/pageAnimation.dart';
import 'package:trip_manager/models/trip.dart';
import 'package:trip_manager/screens/tripdetail.dart';

import 'triprichtext.dart';

class TripCard extends StatefulWidget {
  final DocumentSnapshot trip;

  const TripCard({Key key, this.trip}) : super(key: key);

  @override
  _TripCardState createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  @override
  Widget build(BuildContext context) {
    int _dueTime;
    Size size = MediaQuery.of(context).size;
    DateTime startDate = DateTime.parse(
      widget.trip['startTripDate'].toDate().toString(),
    );
    DateTime endDate = DateTime.parse(
      widget.trip['endTripDate'].toDate().toString(),
    );
    _dueTime = endDate.difference(startDate).inDays;
    if (_dueTime == 0) {
      setState(() {
        _dueTime = endDate.difference(startDate).inHours;
      });
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: 10.0,
        left: 15.0,
        right: 15.0,
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: kTripCardColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: size.height * 0.007,
              width: double.infinity,
              color: Color(widget.trip['tripColor'])),
          SizedBox(height: size.height * 0.015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TripsRichText(
                titleLabel: 'Trip Title:  ',
                titleDescription: widget.trip['title'],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    MdiIcons.fileDocumentEdit,
                    color: Color(widget.trip['tripColor']),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      BouncyPageRoute(
                        page: TripDetail(
                          trip: widget.trip,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          TripsRichText(
            titleLabel: 'Due In:  ',
            titleDescription: '$_dueTime days',
          ),
          SizedBox(height: size.height * 0.012),
          Row(
            children: [
              TripsRichText(
                titleLabel: 'Trip Dates:  ',
                titleDescription: DateFormat().add_yMMMd().format(startDate),
              ),
              TripsRichText(
                titleLabel: '  -  ',
                titleDescription: DateFormat().add_yMMMd().format(endDate),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(height: size.height * 0.012),
          TripsRichText(
            titleLabel: 'Budget:  ',
            titleDescription:
                'Ksh.${NumberFormat('#,###', 'en_US').format(widget.trip['budget'])}',
          ),
          SizedBox(height: size.height * 0.004),
          TripsRichText(
            titleLabel: 'Location:  ',
            titleDescription: widget.trip['location'],
          ),
          SizedBox(height: size.height * 0.004),
          TripsRichText(
            titleLabel: 'Form of transport:  ',
            titleDescription: widget.trip['tripType'],
          ),
          SizedBox(height: size.height * 0.004),
          TripsRichText(
            titleLabel: 'Description:  ',
            titleDescription: widget.trip['tripDescription'],
          ),
        ],
      ),
    );
  }
}
