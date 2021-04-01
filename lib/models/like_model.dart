import 'package:inveat/models/user_model.dart';
import 'package:meta/meta.dart';

class Like {
   int id;
   int like;
   String created_at;
   User user;

   Like({
    @required this.id,
    @required this.like,
    @required this.created_at,
    @required this.user,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'],
      like: json['like'],
      created_at: json['created_at'],
      user: User.fromJson(json['user']) ,
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.like;
    data['created_at'] = this.created_at;
    data['user'] = this.user;
    return data;
  }
}