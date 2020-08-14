import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trip_manager/constants.dart';
import 'package:trip_manager/helpers/triptype.dart';
import 'package:trip_manager/helpers/validators.dart';
import 'package:trip_manager/models/trip.dart';
import 'package:trip_manager/models/user.dart';
import 'package:trip_manager/services/database.dart';
import 'package:trip_manager/widgets/homepage/triprichtext.dart';

class TripDetail extends StatefulWidget {
  final DocumentSnapshot trip;

  const TripDetail({Key key, this.trip}) : super(key: key);

  @override
  _TripDetailState createState() => _TripDetailState();
}

class _TripDetailState extends State<TripDetail> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isFavorite = false;
  Color _taskColor;
  String _updatedBudget;
  String _updatedLocation;
  String _currentType;
  String _updateddesc;
  DateTime _startDate;
  DateTime _endDate;
  //DateTimeRange _dateTimeRange;

  Future _handleShowCalendar() async {
    FocusScope.of(context).unfocus();
    try {
      final datesPicked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
      );
      if (datesPicked != null) {
        setState(() {
          _startDate = datesPicked.start;
          _endDate = datesPicked.end;
          //_dateTimeRange = datesPicked;
        });
      }
      if (datesPicked == null) {
        setState(() {
          _startDate = DateTime.now();
          _endDate = DateTime.now();
        });
      }
    } catch (error) {}
  }

  DateTime previousstartdate() {
    return DateTime.parse(
      widget.trip['startTripDate'].toDate().toString(),
    );
  }

  DateTime previousendDate() {
    return DateTime.parse(
      widget.trip['endTripDate'].toDate().toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _currentType = widget.trip['tripType'];

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _taskColor ??
            Color(
              widget.trip['tripColor'],
            ),
        actions: [
          IconButton(
            icon: _isFavorite
                ? Icon(Icons.favorite, color: Colors.red)
                : Icon(Icons.star_border),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: _showColorPicker,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.trip['title'],
                      style: TextStyle(
                        fontSize: 23.0,
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    RaisedButton.icon(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.red[100],
                      icon: Icon(MdiIcons.deleteForever),
                      label: Text(
                        'Delete Trip',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      onPressed: () async {
                        try {
                          await _handleDeleteTrip();
                        } catch (err) {
                          print(err);
                        }

                        print('deleted');
                      },
                    )
                  ],
                ),
                Divider(),
                SizedBox(
                  height: size.height * 0.05,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Row(
                  children: [
                    Text(
                      'Budget:',
                      style: kTitleTextStyle,
                    ),
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.trip['budget'].toString(),
                        // '${NumberFormat('#,###', 'en_US').format(widget.trip['budget'])}',
                        decoration: kTripDetailField.copyWith(
                          prefix: Text('Ksh:      '),
                        ),
                        validator: (value) =>
                            Validator().tripbudgetValidator(value),
                        onSaved: (value) => _updatedBudget = value,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Dates:',
                        style: kTitleTextStyle,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    DateFormat()
                                            .add_yMMMd()
                                            .format(previousstartdate()) ??
                                        DateFormat()
                                            .add_yMMMd()
                                            .format(_startDate),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    '  -  ${DateFormat().add_yMMMd().format(previousendDate()) ?? DateFormat().add_yMMMd().format(_endDate)}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: size.width * 0.11,
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: _handleShowCalendar,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Row(
                  children: [
                    Text(
                      'Location:',
                      style: kTitleTextStyle,
                    ),
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    Expanded(
                      child: TextFormField(
                        //textAlign: TextAlign.center,
                        initialValue: widget.trip['location'],
                        decoration: kTripDetailField,
                        validator: (value) =>
                            Validator().triplocationValidator(value),
                        onSaved: (value) => _updatedLocation = value,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Row(
                  children: [
                    TripsRichText(
                      titleLabel: 'Mode Of Transport:   ',
                    ),
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _currentType,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        items: tripType.map(
                          (type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            );
                          },
                        ).toList(),
                        onSaved: (value) {
                          _currentType = value;
                        },
                        onChanged: (value) {
                          setState(
                            () {
                              _currentType = value;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  'Trip Description:',
                  style: kTitleTextStyle,
                ),
                SizedBox(
                  height: size.height * 0.015,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: _taskColor ??
                          Color(
                            widget.trip['tripColor'],
                          ),
                      width: 2,
                    ),
                  ),
                  child: TextFormField(
                    initialValue: widget.trip['tripDescription'],
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    onSaved: (value) => _updateddesc = value,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                GestureDetector(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    decoration: BoxDecoration(
                      color: _taskColor ??
                          Color(
                            widget.trip['tripColor'],
                          ),
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Update Trip',
                      style: TextStyle(
                        fontSize: 18.0,
                        letterSpacing: 1.1,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onTap: _handleUpdateTrip,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _handleUpdateTrip() async {
    final user = Provider.of<User>(context, listen: false);
    final _db = Database();
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    try {
      if (isValid) {
        _formKey.currentState.save();
        var trip = Trip(
          timestamp: Timestamp.now(),
          title: widget.trip['title'],
          tripId: widget.trip['tripId'],
          tripType: _currentType ?? widget.trip['tripType'],
          endTripDate: _endDate ?? widget.trip['endTripDate'],
          isFavorite: _isFavorite ?? widget.trip['isFavorite'],
          location: _updatedLocation ?? widget.trip['location'],
          tripColor: _taskColor ?? Color(widget.trip['tripColor']),
          startTripDate: _startDate ?? widget.trip['startTripDate'],
          budget: int.parse(_updatedBudget) ?? widget.trip['budget'],
          tripDescription: _updateddesc ?? widget.trip['tripDescription'],
        );
        await _db.updateTrip(
          userId: user.userId,
          trip: trip,
        );
        print('Added to firebase');
        Navigator.pop(context);
      } else if (!isValid) {
        return null;
      }
    } catch (error) {
      print(error);
    }
  }

  Future _showColorPicker() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick Favorite Color'),
          content: MaterialColorPicker(
            selectedColor: _taskColor,
            allowShades: false,
            onMainColorChange: (color) {
              setState(() => _taskColor = color);
            },
          ),
          actions: [
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              child: Text('Submit'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }

  Future _handleDeleteTrip() async {
    final user = Provider.of<User>(context, listen: false);
    final _db = Database();
    try {
      await _db.deleteTrip(
        userId: user.userId,
        tripId: widget.trip['tripId'],
      );
      var snackbar = SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        behavior: SnackBarBehavior.floating,
        content: Text('Trip Deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () async {
            // var trip = Trip(
            //   title: widget.trip['title'],
            //   tripId: widget.trip['tripId'],
            //   location: widget.trip['location'],
            //   tripColor: Color(widget.trip['tripColor']),
            //   tripType: widget.trip['tripType'],
            //   timestamp: Timestamp.now(),
            //   budget: widget.trip['budget'],
            //   tripDescription: widget.trip['tripDescription'],
            //   endTripDate: widget.trip['endTripDate'],
            //   startTripDate: widget.trip['startTripDate'],
            // );
            // await _db.addTrip(
            //   userId: user.userId,
            //   trip: trip,
            // );
          },
        ),
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);
      Timer(
        Duration(seconds: 3),
        () {
          Navigator.pop(context);
        },
      );
    } catch (error) {
      print(error);
    }
  }
}
