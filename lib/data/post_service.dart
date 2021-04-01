import 'dart:convert';

import 'package:http/http.dart';
import 'package:inveat/models/comment_model.dart';
import 'package:inveat/models/post_model.dart';
import 'package:inveat/utilities/constants/api.dart' as api;
import 'package:http/http.dart' as http;
import 'package:inveat/data/user_service.dart' as UserService;

Future<List<Post>> GetPosts(Map<String, String> params) async {

  final response = await HttpGet(params, api.POSTS);

  final Map bodyRes = jsonDecode(response.body);


  var posts = (bodyRes["data"]["data"] as List)
      .map((value) => Post.fromJson(value))
      .toList();
  //print(response.body);
  return posts;
  //Save User and token
  /*return response.statusCode;
  if (response.statusCode == 200) {
    final Map bodyRes = jsonDecode(response.body);
    User.fromJson(bodyRes["data"]);
  } else {
    throw Exception('Failed to load');
  }*/
}
Future<int> AddPost(file,Map<String, String> body) async {
  final token=await UserService.GetToken();
  var request = http.MultipartRequest('POST', Uri.parse(api.POST));
  print(token);
  request.headers["Authorization"]="jwt "+token;
  request.headers["Content-Type"]="multipart/form-data";
  request.files.add(await http.MultipartFile.fromPath('file', file.path));
  request.fields['title']=body['title'];
  request.fields['content']=body['content'];
  request.fields['type']=body['type'];
  http.Response response = await http.Response.fromStream(await request.send());
  print(response.body);
  print(response.statusCode);
  return response.statusCode;
}
Future<Comment> AddComment(Map<String, String> body) async {
  final response= await HttpPost(body, Uri.parse(api.COMMENT));
  print(response.body);
  final Map bodyRes = jsonDecode(response.body);
  final comment=Comment.fromJson(bodyRes);

  return comment;
}
Future<int> AddLike(String post_id) async {
  Map<String,String>body={};
  final response= await HttpPost(body, Uri.parse(api.LIKE+'/'+post_id));
  //Save User and token
  if (response.statusCode == 200) {

  } else {
    //throw Exception('Failed to load');
  }
  return response.statusCode;
}
Future<Response> HttpGet(Map<String, String> params, String uri) async {
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  String queryString = Uri(queryParameters: params).query;
  var requestUrl = uri.toString() + '?' + queryString;
  final response = await http.get(Uri.parse(requestUrl), headers: headers);
  return response;
}
Future<Response> HttpPost(Map<String, String> body,Uri uri)  async{
  final token =await UserService.GetToken();
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'jwt '+token,
  };
  final response = await http.post(uri,
      body: jsonEncode(body), headers: headers);
  return response;
}

