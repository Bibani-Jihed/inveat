import 'package:inveat/models/image_user_model.dart';
import 'package:inveat/models/story_model.dart';
import 'package:inveat/models/user_model.dart';

final List<User> users = [
  User(
    first_name: 'Houcem',
    last_name: 'sanai',
    image_user: ImageUser(name: 'name', url: 'https://cdn4.iconfinder.com/data/icons/avatars-xmas-giveaway/128/batman_hero_avatar_comics-512.png'),

  ),
  User(
  first_name: 'judo.valley',
    image_user:  ImageUser(name: 'name', url: 'https://cdn.pixabay.com/photo/2013/07/18/20/25/man-164962_1280.jpg'),

  ),
  User(
    first_name: 'squirrel',
    image_user:  ImageUser(name: 'name', url: 'https://cdn.pixabay.com/photo/2015/09/02/13/24/girl-919048_1280.jpg'),

  ),
  User(
    first_name: 'legolascow',
    image_user:  ImageUser(name: 'name', url: 'https://cdn.pixabay.com/photo/2018/03/06/22/57/portrait-3204843_1280.jpg'),

  ),
  User(
    first_name: 'lego_lascow',
    image_user:  ImageUser(name: 'name', url: 'https://cdn.pixabay.com/photo/2015/08/05/04/25/people-875617_960_720.jpg'),

  ),
  User(
    first_name: 'ketchuprye',
    image_user:  ImageUser(name: 'name', url: 'https://cdn.pixabay.com/photo/2016/02/19/10/56/man-1209494_1280.jpg'),
  ),
  User(
    first_name: 'harpryered',
    image_user:  ImageUser(name: 'name', url: 'https://cdn.pixabay.com/photo/2017/08/12/18/31/male-2634974_960_720.jpg'),

  ),
  User(
    first_name: 'owlgiraffe',
    image_user:  ImageUser(name: 'name', url: 'https://cdn.pixabay.com/photo/2014/01/03/01/13/woman-237871_960_720.jpg'),

  ),
];
final List<Story> stories = [
  Story(
    url:
    'https://images.unsplash.com/photo-1534103362078-d07e750bd0c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    media: MediaType.image,
    duration: const Duration(seconds: 10),
  ),
  Story(
    url: 'https://media.giphy.com/media/moyzrwjUIkdNe/giphy.gif',
    media: MediaType.image,
    duration: const Duration(seconds: 7),
  ),
  Story(
    url:
    'https://images.unsplash.com/photo-1531694611353-d4758f86fa6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=564&q=80',
    media: MediaType.image,
    duration: const Duration(seconds: 5),
  ),
  Story(
    url: 'https://media2.giphy.com/media/M8PxVICV5KlezP1pGE/giphy.gif',
    media: MediaType.image,
    duration: const Duration(seconds: 8),
  ),
];