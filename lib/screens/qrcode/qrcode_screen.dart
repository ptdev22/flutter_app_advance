import 'package:flutter_app_advance/screens/qrcode/mycode_screen.dart';
import 'package:flutter_app_advance/screens/qrcode/scanner_screen.dart';
import 'package:flutter/material.dart';

class QRCodeScreen extends StatefulWidget {
  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('คิวอาร์โค้ด'),
          bottom: TabBar(controller: controller, tabs: [
            Tab(
              text: 'ตัวสแกน',
            ),
            Tab(
              text: 'โค้ดของฉัน',
            ),
          ]),
        ),
        body: TabBarView(
            controller: controller,
            children: [ScannerScreen(), MyCodeScreen()]));
  }
}
