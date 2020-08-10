import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trip_manager/services/authService.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text('LogOut'),
                trailing: Icon(MdiIcons.logout),
                onTap: () {
                  AuthService().logOutUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
