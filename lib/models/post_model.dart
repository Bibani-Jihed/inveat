import 'dart:convert';

import 'package:inveat/models/address_post.dart';
import 'package:inveat/models/comment_model.dart';
import 'package:inveat/models/image_posts_model.dart';
import 'package:inveat/models/user_model.dart';
import 'package:meta/meta.dart';

import 'like_model.dart';

class Post {
   int id;
   String content;
   String type;
   String title;
   String created_at;
   User user;
   Address address_post;
   List <ImagePosts> image_posts;
   List <Comment> comments;
   List <Like> likes;

   Post({
    @required this.id,
    @required this.content,
    @required this.type,
    @required this.title,
    @required this.created_at,
     @required this.user,
     @required this.address_post,
     @required this.comments,
     @required this.likes,
     @required this.image_posts,

  });

   factory Post.fromJson(Map<String, dynamic> json) {
       return Post(
         id: json['id'],
         content: json['content'],
         type: json['type'],
         created_at: json['created_at'],
         user: User.fromJson(json['user']),
         address_post: Address.fromJson(json['address_post']),
         image_posts: (json['image_posts'] as List)
             .map((data) => new ImagePosts.fromJson(data))
             .toList(),
         comments: (json['comments'] as List)
             .map((data) => new Comment.fromJson(data))
             .toList(),
         likes: (json['likes'] as List)
             .map((data) => new Like.fromJson(data))
             .toList(),
       );
   }
   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['id'] = this.id;
     data['content'] = this.content;
     data['created_at'] = this.created_at;
     data['user'] = this.user;
     return data;
   }
}