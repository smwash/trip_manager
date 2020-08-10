import 'package:flutter/material.dart';

class NoTasksAdded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/undraw_loading_frh4.png'),
          SizedBox(
            height: size.height * 0.02,
          ),
          Text(
            'No Trips Added Yet',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
