import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({required this.url, this.body});

  final Uri url;
  final Object? body;

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> postData(String? authToken, {context}) async {
    log("Authorization Request: $authToken");
    http.Response response = await http.post(url,
        headers: {"Accept": "application/json", "Authorization" : "$authToken"}, body: body);

/*    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "Response_StatusCode>>>>>>>>> ${response.statusCode} ${response.body}")));*/

    print("Response_StatusCode>>>>>>>>> ${response.statusCode}");
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }
}
