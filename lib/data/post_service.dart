import 'dart:convert';

import 'package:http/http.dart';
import 'package:inveat/models/comment_model.dart';
import 'package:inveat/models/post_model.dart';
import 'package:inveat/utilities/constants/api.dart' as api;
import 'package:http/http.dart' as http;
import 'package:inveat/data/user_service.dart' as UserService;

Future<List<Post>> GetPosts(Map<String, String> params) async {
  print("GetPosts");
  final response = await HttpGet(params, api.POSTS);
  print(response.body);
  final Map bodyRes = jsonDecode(response.body);


  var posts = (bodyRes["data"]["data"] as List)
      .map((value) => Post.fromJson(value))
      .toList();
  return posts;
}
Future<Post> AddPost(file,Map<String, String> body) async {
  final token=await UserService.GetToken();
  var request = http.MultipartRequest('POST', Uri.parse(api.POST));
  request.headers["Authorization"]="jwt "+token;
  request.headers["Content-Type"]="multipart/form-data";
  request.files.add(await http.MultipartFile.fromPath('file', file.path));
  request.fields['title']=body['title'];
  request.fields['content']=body['content'];
  request.fields['type']=body['type'];
  http.Response response = await http.Response.fromStream(await request.send());
  return Post.fromJson(jsonDecode(response.body));
}
Future<Comment> AddComment(Map<String, String> body) async {
  final response= await HttpPost(body, Uri.parse(api.COMMENT));
  final Map bodyRes = jsonDecode(response.body);
  final comment=Comment.fromJson(bodyRes);

  return comment;
}
Future<int> RemoveComment(int comment_id) async {
  Map<String,String>body={};
  final response= await HttpDelete(body, Uri.parse(api.COMMENT+"/"+comment_id.toString()));
  if (response.statusCode == 200) {

  } else {
    //throw Exception('Failed to load');
  }
  return response.statusCode;
}
Future<int> LikeOrDislike(int post_id) async {
  Map<String,String>body={};
  final response= await HttpPost(body, Uri.parse(api.LIKE+'/'+post_id.toString()));
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
Future<Response> HttpDelete(Map<String, String> body,Uri uri)  async{
  final token =await UserService.GetToken();
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'jwt '+token,
  };
  final response = await http.delete(uri,
      body: jsonEncode(body), headers: headers);
  return response;
}

