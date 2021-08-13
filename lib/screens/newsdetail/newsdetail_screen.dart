import 'package:flutter_app_advance/models/NewDetailModel.dart';
import 'package:flutter_app_advance/services/rest_api.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  @override
  _NewsDetailScreenState createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  // สร้างตัวแปลไว้เก็บเลข id
  String newsId;
  // โหลด Model NewsDetailModel
  NewsDetailModel _dataNews;

  String _createdAt;
  // สร้างฟังก์ชันอ่านรายละเอียดข่าว
  readNewsDetail() async {
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
      try {
        var response = await CallAPI().getNewsDetail(newsId);
        setState(() {
          _dataNews = response;
          _createdAt = DateFormat("dd-MM-yyy")
              .format(DateTime.parse(response.data.createdAt.toString()));
        });
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    readNewsDetail();
  }

  @override
  Widget build(BuildContext context) {
    // รับค่า id จาก arguments หน้า notification_screen.dart
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    print(arguments['id'].toString());
    newsId = arguments['id'].toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('${_dataNews?.data?.topic ?? "..."}'),
      ),
      body: ListView(
        children: [
          Container(
            height: 200.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(_dataNews?.data?.imageurl ?? "..."),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter)),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('${_dataNews?.data?.detail ?? "..."}'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Text('Creeat: ${_createdAt ?? "..."}'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 20.0),
            child: Text('Status: ${_dataNews?.data?.status ?? "..."}'),
          )
        ],
      ),
    );
  }
}
