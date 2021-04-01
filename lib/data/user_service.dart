import 'dart:convert';

import 'package:http/http.dart';
import 'package:inveat/models/image_user_model.dart';
import 'package:inveat/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:inveat/utilities/constants/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';

Future<void>ConfigUser(response) async {
  final Map bodyRes = jsonDecode(response.body);
  final user=User.fromJson(bodyRes["data"]["user"]);
  await UpdateCurrentUser(json.encode(user.toJson()));
  await UpdateToken(bodyRes["data"]["token"].toString());
}

Future<int>Signup(Map<String, String> body) async {
  final response= await HttpPost(body, Uri.parse(api.USER));
  print(response.body);

  if (response.statusCode == 200) {
    ConfigUser(response);
  } else {
    //throw Exception('Failed to load');
  }
  return response.statusCode;
}
Future<int>Login(Map<String, String> body) async {
  final response= await HttpPost(body, Uri.parse(api.LOGIN));
  //Save User and token
  if (response.statusCode == 200) {
    ConfigUser(response);
  } else {
    //throw Exception('Failed to load');
  }
  return response.statusCode;
}
Future<int>UpdateUser(Map<String, String> body) async{
  final user=await GetCurrentUser();
  final response= await HttpPatch(body, Uri.parse(api.USER+'/'+user.id.toString()));
  return response.statusCode;
}
Future<int>DeleteUser(int id) async{
  final response= await HttpDelete(Uri.parse(api.USER+'/'+id.toString()));
  return response.statusCode;
}
Future<int> UploadUserImage(file) async {
  final token=await GetToken();
  var request = http.MultipartRequest('POST', Uri.parse(api.UPLOAD));
  request.headers["Authorization"]="jwt "+token;
  request.headers["Content-Type"]="multipart/form-data";
  request.files.add(await http.MultipartFile.fromPath('file', file.path));
  http.Response response = await http.Response.fromStream(await request.send());

  if(response.statusCode==200) {
    print(response.body);
    final Map bodyRes = jsonDecode(response.body);
    User user = await GetCurrentUser();
    user.image_user =new ImageUser(url:bodyRes["data"]["url"],name:bodyRes["data"]["name"]);
    print(user.image_user.url);
    UpdateCurrentUser(json.encode(user));
  }
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
  final token=await GetToken();
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization' : 'jwt '+token
  };
  final response = await http.patch(uri,body: jsonEncode(body), headers: headers);
  print(response.body);
  final Map bodyRes = jsonDecode(response.body);
  final user=User.fromJson(bodyRes["data"]);
  user.image_user.url=bodyRes["data"]["image_user"]["url"].toString();
  await UpdateCurrentUser(json.encode(user.toJson()));
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


Future<User>GetCurrentUser() async{
  final prefs = await SharedPreferences.getInstance();
  return User.fromJson(json.decode(prefs.getString('user')));
}
Future<void>UpdateCurrentUser(String encoded_user) async{
  final prefs = await SharedPreferences.getInstance();
  print(encoded_user);
  prefs.setString("user", encoded_user);
}
Future<String>GetToken() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
Future<void>UpdateToken(String token) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
}

