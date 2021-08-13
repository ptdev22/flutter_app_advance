import 'dart:ffi';

import 'package:flutter_app_advance/models/LoginModel.dart';
import 'package:flutter_app_advance/services/rest_api.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  SharedPreferences sharedPreferences;

  // เรียกใช้งาน LoginModel
  LoginModel _dataProfile;
  String _birthdate;
  // การอ่าน API User profile
  readUserProfile() async {
    //เซ้คว่าเครื่องผู้ใช้ Online หรือ Offline
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      Fluttertoast.showToast(
          msg: "คุณไม่ได้เชื่อมต่ออินเตอร์เน็ต",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      // อ่านข้อมูลจาก SharedPreferences
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var _email = sharedPreferences.getString('storeEmail').toString();
      var _password = sharedPreferences.getString('storePassword').toString();
      print("email : " + _email + ' Password : ' + _password);
      var userData = {"email": _email, "password": _password};
      // var userData = {
      //   "email": 'pongsit@gmail.com',
      //   "password": '123456'
      // };
      try {
        var response = await CallAPI().getProfile(userData);
        print(response);
        print(response.data.firstname);

        setState(() {
          _dataProfile = response;
          _birthdate = DateFormat("dd-MM-yyy")
              .format(DateTime.parse(response.data.birthdate.toString()));
        });
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  Void initState() {
    super.initState();
    readUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลผู้ใช้'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text('ชื่อ-สกุล'),
            subtitle: Text('${_dataProfile?.data?.firstname ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('รหัสผู้ใช้'),
            subtitle: Text('${_dataProfile?.data?.empid ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text('เพศ'),
            subtitle: Text('${_dataProfile?.data?.gender ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('ตำแหน่ง'),
            subtitle: Text('${_dataProfile?.data?.position ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text('สังกัด'),
            subtitle: Text('${_dataProfile?.data?.department ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('เงินเดือน'),
            subtitle: Text('${_dataProfile?.data?.salary ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.cake),
            title: Text('วันเกิด'),
            subtitle: Text('${_birthdate ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('E-mail'),
            subtitle: Text('${_dataProfile?.data?.email ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('โทรศัพท์'),
            subtitle: Text('${_dataProfile?.data?.tel ?? "..."}'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('ที่อยู่'),
            subtitle: Text('${_dataProfile?.data?.address ?? "..."}'),
          ),
        ],
      ),
    );
  }
}
