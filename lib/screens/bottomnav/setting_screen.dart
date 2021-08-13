import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(

          ),
          RaisedButton(
            onPressed: () async {
              // สร้าง Object แบบ SharedPreferences
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              // เก็บค่าลงตัวแปลแบบ SharedPreferences
              sharedPreferences.setInt('appStep', 3);
              Navigator.pushReplacementNamed(context, '/lockscreen');
            },
            child: Text('ออกจากระบบ', style: TextStyle(color: Colors.white),),
          )
        ],
      )
      
    );
  }
}