import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../helpers/loading.dart';
import '../helpers/pageAnimation.dart';
import '../models/user.dart';
import '../services/authService.dart';
import '../services/database.dart';
import '../screens/editprofilescreen.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            letterSpacing: 1.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
        ),
        child: SingleChildScrollView(
          child: StreamBuilder<User>(
            stream: Database().getUserData(user.userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loader();
              }
              var userData = snapshot.data;

              return Column(
                children: [
                  CircleAvatar(
                    radius: size.height * 0.045,
                    backgroundImage: userData.profilePic != null
                        ? CachedNetworkImageProvider(userData.profilePic)
                        : AssetImage(
                            'assets/images/undraw_profile_pic_ic5t.png',
                          ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    userData.userName,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    userData.userEmail,
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.008),
                  RaisedButton.icon(
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    color: kAccentColor.withOpacity(0.4),
                    icon: Icon(Icons.edit),
                    label: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        FadeRoute(
                          page: EditProfile(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(height: size.height * 0.01),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    tileColor: kTripCardColor.withOpacity(0.25),
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    tileColor: kTripCardColor.withOpacity(0.25),
                    title: Text(
                      'LogOut',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black,
                      ),
                    ),
                    trailing: Icon(
                      MdiIcons.logout,
                      color: Colors.black,
                    ),
                    onTap: () {
                      AuthService().logOutUser();
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
