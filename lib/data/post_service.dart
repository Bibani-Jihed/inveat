import 'dart:convert';

import 'package:http/http.dart';
import 'package:inveat/models/comment_model.dart';
import 'package:inveat/models/post_model.dart';
import 'package:inveat/utilities/constants/api.dart' as api;
import 'package:http/http.dart' as http;
import 'package:inveat/data/user_service.dart' as UserService;
import 'package:toast/toast.dart';

Future<List<Post>> GetPosts(Map<String, String> params) async {
  final response = await HttpGet(params, api.POSTS);
 // print(response.body);
  if(response.statusCode==200){
    final Map bodyRes = jsonDecode(response.body);
    var posts = (bodyRes["data"]["data"] as List)
        .map((value) => Post.fromJson(value))
        .toList();
    return posts;
  }
  else return null;

}
Future<int> AddPost(selectedItems,Map<String, dynamic> body) async {
  final token=await UserService.GetToken();
  print("Add Post: "+jsonEncode(body['address']));
  var request = http.MultipartRequest('POST', Uri.parse(api.POST));
  request.headers["Authorization"]="jwt "+token;
  request.headers["Content-Type"]="multipart/form-data";
  for(var file in selectedItems){
    print(file);
    request.files.add(await http.MultipartFile.fromPath('file', file));
  }
  request.fields['title']=body['title'];
  request.fields['content']=body['content'];
  request.fields['type']=body['type'];
  request.fields['address']=jsonEncode(body['address']);
  http.Response response = await http.Response.fromStream(await request.send());
  print(response.body);
  if(response.body=="Unauthorized"){
    return -1;
  }
  else return response.statusCode;
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
Future<Response> HttpGet(Map<String, dynamic> params, String uri) async {
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

