import 'dart:convert';

import 'package:http/http.dart';
import 'package:inveat/utilities/constants/api.dart' as api;
import 'package:http/http.dart' as http;

Future<int> GetPosts(Map<String, String> params) async {
  final response = await HttpGet(params, api.POSTS);
  return response.statusCode;
  //Save User and token
  /*return response.statusCode;
  if (response.statusCode == 200) {
    final Map bodyRes = jsonDecode(response.body);
    User.fromJson(bodyRes["data"]);
  } else {
    throw Exception('Failed to load');
  }*/
}

Future<Response> HttpGet(Map<String, String> params, String uri) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  String queryString = Uri(queryParameters: params).query;
  print(queryString);
  var requestUrl = uri.toString() + '?' + queryString;
  print(requestUrl);
  final response = await http.get(Uri.parse(requestUrl), headers: headers);
  print(response.body);
  return response;
}
