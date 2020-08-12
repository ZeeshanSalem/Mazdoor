import 'package:client_mazdoor/Screens/custom_map.dart';
import 'package:client_mazdoor/Screens/dashboard.dart';
import 'package:client_mazdoor/Screens/profile.dart';
import 'package:client_mazdoor/Screens/showAddress.dart';
import 'package:client_mazdoor/Screens/sign_In.dart';
import 'package:client_mazdoor/Screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //splashColor: Colors.orangeAccent,
        primaryColor: Colors.green[200],
        accentColor: Colors.blue[800],
      ),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => DashBoard(),
        '/SignIn': (BuildContext context) => SignIn(),
        '/SplashScreen': (BuildContext context) => SplashScreen(),
        '/Registration': (BuildContext context) => UserProfile(),
        '/UserLocation': (BuildContext context) => UserLocation(),
        '/userMap': (BuildContext context) => CustomMap(),
      },
      home: DashBoard(),
    );
  }
}
