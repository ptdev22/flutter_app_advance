import 'dart:convert';

import 'package:flutter_app_advance/screens/components/passwordwidget.dart';
import 'package:flutter_app_advance/services/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // กำหนดตัวแปลสำหรับเก็บอีเมลและรหัสผ่าน
  String _email, _password;

  // สร้างคีย์สำหรับเก็บสถานะของฟอร์ม
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: GestureDetector(
        onTap: () {
          // ยกเลิกการ focus ช่อง input
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
              key: formKey,
              child: ListView(
                children: [
                  TextFormField(
                    autofocus: false,
                    keyboardType: TextInputType
                        .emailAddress, // TextInputType กรอกค่าอะไรได้บ้าง number, email
                    style: TextStyle(fontSize: 20, color: Colors.teal),
                    decoration: InputDecoration(
                        icon: Icon(Icons.email), labelText: 'อีเมล'),
                    maxLength: 100, // กำหนดค่าสูงสุด
                    // initialValue: 'samit@gmail.com', // กำหนดค่าเริ่มต้นค่า input
                    initialValue:
                        'pongsit@gmail.com', // กำหนดค่าเริ่มต้นค่า input
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'กรุณากรอกอีเมล';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (String value) {
                      setState(() {
                        this._email = value;
                      });
                    },
                    onSaved: (value) {
                      this._email = value.trim();
                    },
                  ),
                  PasswordField(
                    helperText: 'ไม่เกิน 6 หลัก',
                    labelText: 'กรอกรหัสผ่าน',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'กรุณากรอกอีเมล';
                      } else if (value.length != 6) {
                        return 'กรุณาป้อนรหัสผ่าน 6 หลัก';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (String value) {
                      setState(() {
                        this._password = value;
                      });
                    },
                    onSaved: (value) {
                      this._password = value.trim();
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        print("email : " + _email + ' Password : ' + _password);
                        var userData = {"email": _email, "password": _password};
                        _loinProcess(userData);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    color: Colors.green,
                  )
                ],
              )),
        ),
      ),
    );
  }

  // ฟังก์ชันเซ็คการล็อกอิน login
  void _loinProcess(userData) async {
    try {
      var response = await CallAPI().loginAPI(userData);
      var body = json.decode(response.body);

      print(body['message']);
      // เซ็คว่าถ้า login สำเร็จ
      if (body['status'] == 'success') {
        print('user status : ' + body['data']['status']);
        print(body);
        if (body['data']['status'] == '1') {
          // สร้าง Object แบบ SharedPreferences
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          // เก็บค่าลงตัวแปลแบบ SharedPreferences
          sharedPreferences.setInt('appStep', 2);
          sharedPreferences.setString(
              'storeFullname',
              body['data']['prename'] +
                  body['data']['firstname'] +
                  ' ' +
                  body['data']['lastname']);
          sharedPreferences.setString('storeAvatar', body['data']['avatar']);
          sharedPreferences.setString('storeEmail', body['data']['email']);
          sharedPreferences.setString('storePassword', _password);
          Navigator.pushReplacementNamed(context, '/dashboard');
        } else {
          _showDialog('แจ้งเตือน', 'สถานะของผู้ใช้ไม่ปกติ');
        }
      } else {
        _showDialog('แจ้งเตือน', 'ข้อมูลไม่ถูกต้อง ลองใหม่');
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "พบข้อผิดพลาดการโหลดข้อมูล",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void _showDialog(title, msg) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('close'))
            ],
          );
        });
  }
}
