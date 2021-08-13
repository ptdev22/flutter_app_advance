import 'package:flutter_app_advance/screens/dashborad/dashborad_screen.dart';
import 'package:flutter_app_advance/screens/lockscreen/lock_screen.dart';
import 'package:flutter_app_advance/screens/login/login_screen.dart';
import 'package:flutter_app_advance/screens/newsdetail/newsdetail_screen.dart';
import 'package:flutter_app_advance/screens/qrcode/qrcode_screen.dart';
import 'package:flutter_app_advance/screens/userprofile/userprofile_screen.dart';
import 'package:flutter_app_advance/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/dashboard": (BuildContext context) => DashboradScreen(),
  "/lockscreen": (BuildContext context) => LockScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/userprofile": (BuildContext context) => UserProfileScreen(),
  "/newsdetail": (BuildContext context) => NewsDetailScreen(),
  "/qrcode": (BuildContext context) => QRCodeScreen(),
};
