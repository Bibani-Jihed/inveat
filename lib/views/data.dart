import 'package:inveat/models/story_model.dart';
import 'package:inveat/models/user_model.dart';

final User user = User(
  name: 'djo.bibani',
  profileImageUrl: 'https://yt3.ggpht.com/a/AATXAJxv-XL-jyFo4NhtQMEr-JcV_ie8D9osfPCQYShSvQ=s900-c-k-c0xffffffff-no-rj-mo',
);
final List<Story> stories = [
  Story(
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    media: MediaType.image,
    duration: const Duration(seconds: 10),
    user: user,
  ),
  Story(
    url: 'https://media.giphy.com/media/moyzrwjUIkdNe/giphy.gif',
    media: MediaType.image,
    user: User(
      name: 'djo.bibani',
      profileImageUrl: 'https://yt3.ggpht.com/a/AATXAJxv-XL-jyFo4NhtQMEr-JcV_ie8D9osfPCQYShSvQ=s900-c-k-c0xffffffff-no-rj-mo',
    ),
    duration: const Duration(seconds: 7),
  ),

  Story(
    url:
    'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
    media: MediaType.image,
    duration: const Duration(seconds: 5),
    user: user,
  ),

  Story(
    url: 'https://media2.giphy.com/media/M8PxVICV5KlezP1pGE/giphy.gif',
    media: MediaType.image,
    duration: const Duration(seconds: 8),
    user: user,
  ),
];