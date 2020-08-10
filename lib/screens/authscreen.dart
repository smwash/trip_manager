import 'package:flutter/material.dart';
import '../widgets/authform/authform.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Be Productive with a trip manager.',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: size.height * 0.04,
                    ),
                  ),
                  SizedBox(height: size.height * 0.017),
                  Text(
                    'Planning your daily trip has never\n been this easy.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: size.height * 0.02,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              AuthForm(),
            ],
          ),
        ),
      ),
    );
  }
}
