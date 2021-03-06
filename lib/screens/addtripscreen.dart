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
import 'package:trip_manager/widgets/circleButton.dart';
import 'package:uuid/uuid.dart';

class AddTripScreen extends StatefulWidget {
  @override
  _AddTripScreenState createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  final _formKey = GlobalKey<FormState>();
  var uuid = Uuid();
  String _budget;

  String _location;
  Color _taskColor;
  String _tripTitle;
  String _description;
  DateTime _endTripdate;
  DateTime _startTripDate;
  //DateTimeRange _datePicked;
  String _currentType = 'Car';

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
          _startTripDate = datesPicked.start;
          _endTripdate = datesPicked.end;
        });
      }
      if (datesPicked == null) {
        setState(() {
          _startTripDate = DateTime.now();
          _endTripdate = DateTime.now();
        });
      }
    } catch (error) {}
  }

  _handleSubmitTrip() async {
    final user = Provider.of<User>(context, listen: false);
    final _db = Database();
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();

    try {
      if (isValid) {
        _formKey.currentState.save();
        var trip = Trip(
          tripId: uuid.v4(),
          isFavorite: false,
          title: _tripTitle,
          location: _location,
          tripColor: _taskColor,
          tripType: _currentType,
          timestamp: Timestamp.now(),
          budget: int.parse(_budget),
          tripDescription: _description ?? '',
          endTripDate: _endTripdate ?? DateTime.now(),
          startTripDate: _startTripDate ?? DateTime.now(),
        );
        await _db.addTrip(trip: trip, userId: user.userId);
        print('Added to firebase');
        Navigator.pop(context);
      } else if (!isValid) return null;
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: kAccentColor.withOpacity(0.9),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Create New Trip',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: size.height * 0.24,
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02,
                  horizontal: size.width * 0.09,
                ),
                decoration: BoxDecoration(
                  color: kAccentColor.withOpacity(0.9),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      cursorColor: Colors.black,
                      enableSuggestions: true,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: kAddTripTextFieldDeco.copyWith(
                          labelText: 'Trip Title'),
                      validator: (value) =>
                          Validator().tripTitleValidator(value),
                      onSaved: (value) => _tripTitle = value,
                    ),
                    SizedBox(height: size.height * 0.015),
                    Row(
                      children: [
                        Text(
                          'Trip Type:',
                          style: TextStyle(
                            fontSize: 17.0,
                            letterSpacing: 1.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.09,
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
                              setState(() {
                                _currentType = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Start Date:',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: size.width * 0.08),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              suffixIcon: Container(
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
                                    MdiIcons.calendarClock,
                                    color: Colors.black,
                                  ),
                                  onPressed: _handleShowCalendar,
                                ),
                              ),
                              hintText: _startTripDate != null
                                  ? DateFormat()
                                      .add_yMMMd()
                                      .format(_startTripDate)
                                  : 'Pick Date',
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.5,
                                color: Colors.black,
                              ),
                            ),
                            //onTap: _handleShowCalendar,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'End Date:',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: size.width * 0.09),
                        Expanded(
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: _endTripdate != null
                                  ? DateFormat()
                                      .add_yMMMd()
                                      .format(_endTripdate)
                                  : '',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Budget',
                              labelStyle: TextStyle(
                                fontSize: 17.0,
                                letterSpacing: 1.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            validator: (value) =>
                                Validator().tripbudgetValidator(value),
                            onSaved: (value) => _budget = value,
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.023,
                        ),
                        Expanded(
                          child: TextFormField(
                            enableSuggestions: true,
                            textCapitalization: TextCapitalization.words,
                            decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Location',
                              labelStyle: TextStyle(
                                fontSize: 17.0,
                                letterSpacing: 1.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            validator: (value) =>
                                Validator().triplocationValidator(value),
                            onSaved: (value) => _location = value,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      maxLines: 2,
                      enableSuggestions: true,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          fontSize: 17.0,
                          letterSpacing: 1.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      onSaved: (value) => _description = value,
                    ),
                    SizedBox(height: size.height * 0.015),
                    Row(
                      children: [
                        Text(
                          'Pick Trip Color:',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: _taskColor,
                        ),
                        SizedBox(width: size.width * 0.03),
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
                              MdiIcons.palette,
                              color: Colors.black,
                            ),
                            onPressed: _showColorPicker,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.015),
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
                          color: kAccentColor,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Create Trip',
                          style: TextStyle(
                            fontSize: 18.0,
                            letterSpacing: 1.1,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      onTap: _handleSubmitTrip,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
