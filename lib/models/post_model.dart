import 'package:inveat/models/user_model.dart';
import 'package:meta/meta.dart';

class Post {
  final String imageurl;
  final User user;

  const Post({
    @required this.imageurl,
    @required this.user,
  });
}