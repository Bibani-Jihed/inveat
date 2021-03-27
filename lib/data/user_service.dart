import 'dart:convert';

import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart';
import 'package:inveat/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:inveat/utilities/constants/api.dart' as api;

Future<int> Signup(Map<String, String> body) async {
  final response= await HttpPost(body, Uri.parse(api.USER));

  //Save User and token

  if (response.statusCode == 200) {
    final Map bodyRes = jsonDecode(response.body);
    final user=User.fromJson(bodyRes["data"]);
    await FlutterSession().set('signed_user', user);
  } else {
    //throw Exception('Failed to load');
  }

  return response.statusCode;
}
Future<int> Login(Map<String, String> body) async {
  final response= await HttpPost(body, Uri.parse(api.LOGIN));
  //Save User and token
  if (response.statusCode == 200) {
    final Map bodyRes = jsonDecode(response.body);

    final user=User.fromJson(bodyRes["data"]);
    await FlutterSession().set('signed_user', user);
  } else {
    //throw Exception('Failed to load');
  }
  return response.statusCode;
}
Future<int>UpdateUser(Map<String, String> body) async{
  final response= await HttpPatch(body, Uri.parse(api.USER));
  return response.statusCode;
}
Future<int>DeleteUser(int id) async{
  final response= await HttpDelete(Uri.parse(api.USER+'/'+id.toString()));
  return response.statusCode;
}
Future<Response> HttpPost(Map<String, String> body,Uri uri)  async{
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final response = await http.post(uri,
      body: jsonEncode(body), headers: headers);
  print(response.body);
  return response;
}
Future<Response> HttpGet(Map<String, String> body,Uri uri)  async{

}
Future<Response> HttpPatch(Map<String, String> body,Uri uri)  async{
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final response = await http.patch(uri,
      body: jsonEncode(body), headers: headers);
  print(response.body);
  return response;
}
Future<Response> HttpDelete(Uri uri)  async{
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final response = await http.delete(uri, headers: headers);
  print(response.body);
  return response;
}

