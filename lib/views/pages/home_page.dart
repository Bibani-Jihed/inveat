import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/insta/story_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/lib/utilities/constants/colors.dart' as mColors;
import 'package:inveat/models/image_posts_model.dart';
import 'package:inveat/models/post_model.dart';
import 'package:inveat/views/new_post_selection_screen.dart';
import 'package:inveat/views/widgets/post_widget.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/views/story_screen.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/data.dart';
import 'package:inveat/data/post_service.dart' as PostService;
import 'package:inveat/utilities/constants/api.dart' as api;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2014/11/05/15/57/salmon-518032_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/09/02/12/43/meal-918639_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/03/09/15/30/breakfast-1246686_1280.jpg',
    'https://cdn.pixabay.com/photo/2018/07/18/19/12/spaghetti-3547078_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/01/22/02/13/meat-1155132_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/18/19/00/breads-1836411_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/03/27/13/54/bread-2178874_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/03/09/12/07/dinner-1246287_1280.jpg',
  ];
  List<String> captions = [
    'Whatever is good for your soul, do that',
    'Even the stars were jealous of the sparkle in her eyes',
    'Stress less and enjoy the best',
    'Get out there and live a little ',
    'I’m not high maintenance, you’re just low effort',
    'I’m not gonna sugar coat the truth, I’m not Willy Wonka ',
    'Life is better when you’re laughing',
    'Look for the magic in every moment',
    'A sass a day keeps the basics away',
  ];
  String comment;

  Future<List<Post>> GetPosts({Map<String, String> params}) async {
    final posts = await PostService.GetPosts(params);
    return posts;
  }

  Widget _buildStories() {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            for (var i = 0; i < users.length; i++)
              SizedBox(
                width: 85.0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      StoryButton(
                        size: 72,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              opaque: false, // set to false
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  StoryScreen(stories: stories, user: users[i]),
                            ),
                          );

                          /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StoryScreen(stories: stories)),
                        );*/
                        },
                        child: CachedNetworkImage(
                          imageUrl: users[i].image_user.url,
                          fit: BoxFit.cover,
                          width: 62,
                          height: 62,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        strokeWidth: 1.5,
                        radius: 50,
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.yellow,
                            Colors.orange,
                          ],
                        ),
                      ),
                      Text(
                        users[i].first_name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
              ),
            //Lets Sign
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: mColors.black,
            ),
          ),
          Container(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 60.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                            width: 40.0,
                            child: IconButton(
                              icon: Image.asset("assets/images/shutter.png"),
                              iconSize: 40.0,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostSelection()),
                                );
                              },
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Trending",
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        //Lets Sign
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildStories(),
                  Divider(
                    color: Colors.white10,
                  ),
                  FutureBuilder<List<Post>>(
                      future: GetPosts(),
                      builder: (context, snapshot) {
                        return  ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data != null
                                ? snapshot.data.length
                                : 10,
                            itemBuilder: (context, index) {
                              if(snapshot.hasData && snapshot.data!=null)
                                if(snapshot.data[index].image_posts_list.length>=1)
                                  return PostWidget(post: snapshot.data[index]);
                                else
                                  return Container();
                            });
                      }),
                  //Lets Sign
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
