import 'package:flutter_app_advance/screens/bottomnav/about_screen.dart';
import 'package:flutter_app_advance/screens/bottomnav/home_screen.dart';
import 'package:flutter_app_advance/screens/bottomnav/notification_screen.dart';
import 'package:flutter_app_advance/screens/bottomnav/person_screen.dart';
import 'package:flutter_app_advance/screens/bottomnav/setting_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class DashboradScreen extends StatefulWidget {
  @override
  _DashboradScreenState createState() => _DashboradScreenState();
}

class _DashboradScreenState extends State<DashboradScreen> {
  //ส้รางตัวแปลแบบ List ไว้เก็บรายการของtab bottom
  int _currentIndex = 2;
  // String _title = 'หน้าหลัก';
  String _title = 'flutter app advance';
  Widget _actionWidgetAppbar;
  final List<Widget> _children = [
    PersonScreen(), // ข้อมูลบุคคล
    SettingScreen(), // ตั้งค่า
    HomeScreen(), // หน้าหลัก
    NotificationScreen(), // แจ้งเตือน
    AboutScreen() // เกี่ยวกับ
  ];

  // สร้าง widget action สำหรับไว้แยกแสดงผล Appbar
  Widget _homeActionBar() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/qrcode');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          children: [Icon(Icons.center_focus_strong), Text('Scan')],
        ),
      ),
    );
  }

  Widget _notificationActionBar() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          children: [Icon(Icons.add), Text('Add news')],
        ),
      ),
    );
  }

  // สร้างฟังก์ชั่นเพื่อใช้ในการเปลี่ยนหน้า
  void onTabChange(int index) {
    setState(() {
      _currentIndex = index;

      // เปลี่ยน title ไปตาม tab ที่เลือก
      switch (index) {
        case 0:
          _title = 'ข้อมูลบุคคล';
          _actionWidgetAppbar = Container();
          break;
        case 1:
          _title = 'ตั้งค่า';
          _actionWidgetAppbar = Container();
          break;
        case 2:
          _title = 'หน้าหลัก';
          _actionWidgetAppbar = _homeActionBar();
          break;
        case 3:
          _title = 'แจ้งเตือน';
          _actionWidgetAppbar = _notificationActionBar();
          break;
        case 4:
          _title = 'เกี่ยวกับ';
          _actionWidgetAppbar = Container();
          break;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _actionWidgetAppbar = _homeActionBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Time Attendance demo'),
        title: Text('$_title'), //ไม่จัดกึ่งหลาง
        // title: Center(child: Text('$_title')),
        // actions: [
        //   Icon(Icons.qr_code),
        // ],
        actions: [
          _actionWidgetAppbar,
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: onTabChange,
      //   currentIndex: _currentIndex,
      //   backgroundColor: Colors.teal,
      //   type:  BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person ,color:  Colors.white,),
      //       title: Text('ข้อมูลบุคคล', style: TextStyle(color: Colors.white),)
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings ,color:  Colors.white,),
      //       title: Text('ตั้งค่า', style: TextStyle(color: Colors.white),)
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home,color:  Colors.white,),
      //       title: Text('หน้าหลัก', style: TextStyle(color: Colors.white),)
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notifications ,color:  Colors.white,),
      //       title: Text('แจ้งเตือน', style: TextStyle(color: Colors.white),)
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.info ,color:  Colors.white,),
      //       title: Text('เกี่ยวกับ', style: TextStyle(color: Colors.white),)
      //     ),
      //   ]
      // ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white, // สีพื้นหลังเมนู
        color: Colors.teal, // สีพื้นเมนู
        buttonBackgroundColor: Colors.teal, // สีปุ่มกด
        height: 60,
        animationDuration: Duration(milliseconds: 200),
        index: _currentIndex,
        animationCurve: Curves.bounceOut,
        items: [
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ), // ข้อมูลบุคคล
          Icon(
            Icons.settings,
            size: 30,
            color: Colors.white,
          ), // ตั้งค่า
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ), // หน้าหลัก
          Icon(
            Icons.notifications,
            size: 30,
            color: Colors.white,
          ), // แจ้งเตือน
          Icon(
            Icons.info,
            size: 30,
            color: Colors.white,
          ), // เกี่ยวกับ
        ],
        onTap: onTabChange,
      ),
      body: _children[_currentIndex],
    );
  }
}
