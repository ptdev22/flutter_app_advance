import 'dart:ffi';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonScreen extends StatefulWidget {
  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
    // สร้างตัวแปลไว้เก็บชื่อ และรูปโปรไฟล์
    String _fullname, _avatar;
    SharedPreferences sharedPreferences;

    //อ่านข้อมูลผู้ใช้จาก sharedPreferences
    getProfile() async {
      sharedPreferences = await SharedPreferences.getInstance();
      setState(() {
        _fullname = sharedPreferences.getString('storeFullname');
        _avatar = sharedPreferences.getString('storeAvatar');
      });
    }
    // ฟังก์ชั่นเซ็คการเชื่อมต่อ network
    checkNetwork() async {
      var result = await Connectivity().checkConnectivity();
      if(result == ConnectivityResult.wifi){
        Fluttertoast.showToast(
            msg: "คุณกำลังเชื่อมต่อผ่าน  Wifi",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else if(result == ConnectivityResult.mobile){
        Fluttertoast.showToast(
            msg: "คุณกำลังเชื่อมต่อผ่าน mobile",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else if(result == ConnectivityResult.none){
        Fluttertoast.showToast(
            msg: "คุณไม่ได้เชื่อมต่ออินเตอร์เน็ต",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
    // ฟังก์ชันตอนเริ่มโหลดหน้าของแอพ ทำครั่งเดียว
    @override
    void initState(){
      super.initState();
      getProfile();
      checkNetwork();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 180.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/abstract-grunge-decorative-relief-navy-blue-stucco-wall-texture-wide-angle-rough-colored-background_1258-28311.jpg'),
                fit: BoxFit.cover
                )
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 46,
                      // backgroundImage: AssetImage('assets/images/FREE-PROFILE-AVATARS.png'),
                      backgroundImage: NetworkImage('$_avatar'),
                    ),
                    // child: _avatar!=null ? CircleAvatar(
                    //   radius: 46,
                    //   // backgroundImage: AssetImage('assets/images/FREE-PROFILE-AVATARS.png'),
                    //   backgroundImage: NetworkImage('$_avatar'),
                    // ): CircularProgressIndicator(),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  '$_fullname',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 1.0,
                        color: Colors.black
                      )
                    ]
                  ),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('ข้อมูลผู้ใช้'),
            onTap: (){
              Navigator.pushNamed(context, '/userprofile');
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('เปลี่ยนรหัสผ่าน'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('เปลี่ยนภาษา'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('ติดต่อ'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('ตั้งค่า'),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('ออกจากระบบ'),
            onTap: () async {
              // สร้าง Object แบบ SharedPreferences
              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
              // เก็บค่าลงตัวแปลแบบ SharedPreferences
              sharedPreferences.setInt('appStep', 3);
              Navigator.pushReplacementNamed(context, '/lockscreen');
            },
          ),
        ],
      )
      
    );
  }
}