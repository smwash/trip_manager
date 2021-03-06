import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_manager/helpers/loading.dart';
import 'package:trip_manager/models/user.dart';
import 'package:trip_manager/providers/themechanger.dart';
import 'package:trip_manager/services/authService.dart';
import './screens/authscreen.dart';
import './screens/homescreen.dart';
import './widgets/bottomnav.dart';
import 'services/database.dart';

void main() {
  WidgetsFlutterBinding();
  runApp(
    //WidgetsFlutterBinding(),

    MultiProvider(providers: [
      ChangeNotifierProvider<ThemeProvider>(
        create: (context) => ThemeProvider(
          ThemeData.dark(),
        ),
      ),
      StreamProvider<User>.value(
        value: AuthService().user,
      ),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Mangaer',
      theme: ThemeData(
        fontFamily: 'Mulish',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          } else if (snapshot.hasData) {
            return BottomNav();
          }
          return AuthScreen();
        },
      ),
    );
  }
}
