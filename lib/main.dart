import 'package:flutter_app_advance/routers.dart';
import 'package:flutter_app_advance/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var appStep;
var initURL;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  appStep = sharedPreferences.getInt('appStep');
  if (appStep == 1) {
    initURL = '/login';
  } else if (appStep == 2) {
    initURL = '/dashboard';
  } else if (appStep == 3) {
    initURL = '/lockscreen';
  } else {
    initURL = '/welcome';
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(),
      //กำหนดหน้าแรกจาก routers.dart
      // initialRoute: '/dashboard',
      initialRoute: initURL,
      routes: routes,
    );
  }
}
