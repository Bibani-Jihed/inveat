import 'package:inveat/models/user_model.dart';
import 'package:meta/meta.dart';

class Comment {
  int id;
  String comment;
  String created_at;
  User user;
  String user_id;

  Comment({
    @required this.id,
    @required this.comment,
    @required this.created_at,
    @required this.user,
    @required this.user_id,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    print(json['user'].toString());
    return Comment(
      id: json['id'],
      comment: json['comment'],
      created_at: json['created_at']==null?json['createdAt']:json['created_at'],
      user: json['user']!=null? User.fromJson(json['user']):null,
      user_id: json['user_id'].toString().isNotEmpty?json['user_id'].toString():null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['created_at'] = this.created_at;
    data['user'] = this.user;
    data['user_id'] = this.user_id;
    return data;
  }
}
