import 'package:flutter/material.dart';
import 'package:trip_manager/constants.dart';
import 'package:trip_manager/helpers/triptype.dart';

class AddTripScreen extends StatefulWidget {
  @override
  _AddTripScreenState createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> {
  String _currentType = 'Car';
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
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(),
                            value: _currentType,
                            items: tripType.map(
                              (type) {
                                return DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                );
                              },
                            ).toList(),
                            onChanged: (value) => setState(
                              () => _currentType = value,
                            ),
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
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Start Date:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextFormField(),
                            ],
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'End Date:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextFormField(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
                    ),
                    SizedBox(height: size.height * 0.03),
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
}
