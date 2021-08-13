import 'dart:ffi';

import 'package:flutter_app_advance/models/NewDetailModel.dart';
import 'package:flutter_app_advance/services/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_advance/models/NewsModel.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
          child: Text(
            'ข่าวประกาศล่าสุด',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.30,
          child: FutureBuilder(
              future: CallAPI().getLastNews(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<NewsModel>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('มีข้อผิดพลาด ${snapshot.error.toString()}'),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<NewsModel> news = snapshot.data;
                  return _listViewLastNews(news);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15.0, bottom: 15.0),
          child: Text(
            'ข่าวประกาศทั้งหมด',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.28,
          child: FutureBuilder(
              future: CallAPI().getAllNews(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<NewsModel>> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('มีข้อผิดพลาด ${snapshot.error.toString()}'),
                  );
                } else if (snapshot.connectionState == ConnectionState.done) {
                  List<NewsModel> news = snapshot.data;
                  return _listViewAllNews(news);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        )
      ],
    ));
  }

  // สร้างชุด ListView สำหรับแสดงข่าวล่าสุด
  Widget _listViewLastNews(List<NewsModel> news) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: news.length,
        itemBuilder: (context, index) {
          // โหลด model
          NewsModel newsModel = news[index];
          return Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/newsdetail',
                    arguments: {'id': newsModel.id});
              },
              child: Card(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 125.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                // image: NetworkImage('https://www.itgenius.co.th/assets/frondend/images/picarticle/genius-41614494834724466.jpg'), // รูปข่าว
                                image: NetworkImage(newsModel.imageurl),
                                fit: BoxFit.fitHeight,
                                alignment: Alignment.topCenter)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              // 'หัวข้อข่าว', //หัวข้อข่าว
                              newsModel.topic,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              // 'เนื่อหาข่าว', // เนื่อหาข่าว
                              newsModel.detail,
                              style: TextStyle(fontSize: 16.0),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  // สร้างชุด ListView สำหรับแสดงข่าวทั้งหมด
  Widget _listViewAllNews(List<NewsModel> news) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: news.length,
        itemBuilder: (context, index) {
          // โหลด model
          NewsModel newsModel = news[index];
          return ListTile(
            leading: Icon(Icons.pages),
            title: Text(
              newsModel.topic,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              // _launcherInBrowser('https://www.youtube.com');
              _launcherInBrowser(newsModel.linkurl);
            },
          );
        });
  }

  // ฟังก์ชั่นสำหรับการ Launcher Web URL Screen
  Future<Void> _launcherInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false, forceWebView: false, // ให้เปิดที่ App เรา
          headers: <String, String>{'header_key': 'header_value'});
    } else {
      throw 'Could not launch $url';
    }
  }
}
