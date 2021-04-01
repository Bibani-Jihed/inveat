import 'package:inveat/models/user_model.dart';
import 'package:meta/meta.dart';

class ImagePosts {
   int id;
   String url;
   String name;

   ImagePosts({
    @required this.id,
    @required this.url,
    @required this.name,
  });

  factory ImagePosts.fromJson(Map<String, dynamic> json) {
    try {
      return ImagePosts(
        id: json['id'],
        url: json['url'],
        name: json['name'],
      );
    }catch(e){
      return null;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}