import 'package:inveat/models/user_model.dart';
import 'package:meta/meta.dart';

class ImageUser {
   String name;
   String url;

   ImageUser({
    @required this.name,
    @required this.url,
  });

  factory ImageUser.fromJson(Map<String, dynamic> json) {
    try {
      return ImageUser(
        name: json['name'],
        url: json['url'],
      );
    }catch(e){
      return null;
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}