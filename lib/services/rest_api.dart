import 'dart:convert';

import 'package:flutter_app_advance/models/LoginModel.dart';
import 'package:flutter_app_advance/models/NewDetailModel.dart';
import 'package:flutter_app_advance/models/NewsModel.dart';
import 'package:http/http.dart' as http;

class CallAPI {
  _setHeaders() =>
      {'Content-Type': 'application/json', 'Accept': 'application/json'};

  final String baseAPIURL =
      'https://www.itgenius.co.th/sandbox_api/flutteradvapi/public/api/';
  //Login API
  loginAPI(data) async {
    return await http.post(baseAPIURL + 'login', //ของเดิม http: ^0.12.2
        // Uri.https(baseAPIURL, '/login', {'q': '{http}'}), //ของใหม่ http: ^0.13.0
        body: jsonEncode(data),
        headers: _setHeaders());
  }

  // Read User Profile
  Future<LoginModel> getProfile(data) async {
    final response = await http.post(
        baseAPIURL + 'login', //ของเดิม http: ^0.12.2
        // Uri.https(baseAPIURL, '/login', {'q': '{http}'}), //ของใหม่ http: ^0.13.0
        body: jsonEncode(data),
        headers: _setHeaders());
    if (response.statusCode == 200) {
      return loginModelFromJson(response.body);
    } else {
      return null;
    }
  }

  // Read Last news
  Future<List<NewsModel>> getLastNews() async {
    final response =
        await http.get(baseAPIURL + 'lastnews', //ของเดิม http: ^0.12.2
            headers: _setHeaders());
    if (response.body != null) {
      return newsModelFromJson(response.body);
    } else {
      return null;
    }
  }

  // Read All News
  Future<List<NewsModel>> getAllNews() async {
    final response = await http.get(baseAPIURL + 'news', //ของเดิม http: ^0.12.2
        headers: _setHeaders());
    if (response.body != null) {
      return newsModelFromJson(response.body);
    } else {
      return null;
    }
  }

  // Read News Detail By ID
  Future<NewsDetailModel> getNewsDetail(id) async {
    final response =
        await http.get(baseAPIURL + 'news/' + id, //ของเดิม http: ^0.12.2
            headers: _setHeaders());
    if (response.body != null) {
      return newsDetailModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
