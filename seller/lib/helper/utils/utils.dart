import 'dart:convert';

import 'package:http/http.dart';

import 'console.dart';

class Requests {
  static String authority = '192.168.10.11:8080';
  static Map<String, dynamic> content = {'en': {}};

  static Future post(String key) async {
    var client = Client();
    try {
      var uri = Uri.http(authority, '/seller/post', {'key': key});
      Response response = await client.get(uri);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return body;
      }
    } catch (err) {
      console.log(err);
    }
  }

  static Future get() async {
    var client = Client();
    try {
      var uri = Uri.http(authority, '/seller/get', {});
      Response response = await client.get(uri);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return body;
      }
    } catch (err) {
      console.log(err);
    }
  }
}
