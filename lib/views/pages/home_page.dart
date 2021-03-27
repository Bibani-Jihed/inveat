import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/insta/story_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/lib/utilities/constants/colors.dart' as mColors;
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/views/story_screen.dart';
import 'package:like_button/like_button.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/data.dart';
import 'package:inveat/data/post_service.dart' as PostService;


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
    'https://cdn.pixabay.com/photo/2016/11/29/11/38/blur-1869227_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/03/09/12/07/dinner-1246287_1280.jpg',
  ];

  void GetPosts(Map<String, String> params) async{
    final res_code=await PostService.GetPosts(params);
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: mColors.black,
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    title: new Text(
                      "Report...",
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () => {}),
                new ListTile(
                  title: new Text(
                "Turn on Post Notification",
                style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                ),
                ),
                  onTap: () => {},
                ),
                new ListTile(
                  title: new  Text(
          "About This Account",
          style: GoogleFonts.nunito(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          ),
          ),
                  onTap: () => {},
                ),
                new ListTile(
                  title: new Text(
                    "Unfollow",
                    style: GoogleFonts.nunito(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
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
                            pageBuilder: (context, animation, secondaryAnimation) => StoryScreen(stories: stories,user: users[i]),

                          ),
                        );

                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StoryScreen(stories: stories)),
                        );*/
                      },
                      child: CachedNetworkImage(
                        imageUrl: users[i].profileImageUrl,
                        fit: BoxFit.cover,
                        width: 62,
                        height: 62,
                        errorWidget:
                            (context, url, error) =>
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
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 60.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            height: 40.0,
                            width: 40.0,
                            child:
                            IconButton(
                              icon: Image.asset("assets/images/shutter.png"),
                              iconSize: 40.0,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                            width: 40.0,
                            child:
                            IconButton(
                              icon: Image.asset("assets/images/send.png"),
                              iconSize: 10.0,
                              onPressed: () {},
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

                  for (var i = 0; i < imageList.length; i++)
                    Container(
                      child: Column(
                        children: [
                          //Post Header
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 50.0,
                                        child: Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: <Widget>[
                                              StoryButton(
                                                size: 40,
                                                onPressed: () {},
                                                child: CachedNetworkImage(
                                                  imageUrl:users[0].profileImageUrl,
                                                  fit: BoxFit.cover,
                                                  width: 35,
                                                  height: 35,
                                                  errorWidget: (context, url, error) =>
                                                      Icon(Icons.error),
                                                ),
                                                strokeWidth: 1.5,
                                                radius: 60,
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    Colors.yellow,
                                                    Colors.orange,
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      ),
                                      Container(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                              users[0].first_name,
                                                textAlign: TextAlign.start,
                                               style: GoogleFonts.nunito(
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                "djerba",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.nunito(
                                                  color: Colors.white70,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.more_vert,
                                      color: Colors.white),
                                  iconSize: 20,
                                  onPressed: () {
                                    _settingModalBottomSheet(
                                        context);
                                  },
                                ),
                              ],
                            ),
                          ),
                          //Post Image
                          Container(
                            child: Container(
                              height: 250.0,
                              alignment: Alignment.center,
                              child: PinchZoomImage(
                                image: CachedNetworkImage(
                                  imageUrl: imageList[i].toString(),
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      CircularProgressIndicator(valueColor:AlwaysStoppedAnimation<Color>(Colors.yellow),),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                                zoomedBackgroundColor:
                                    Color.fromRGBO(240, 240, 240, 1.0),
                                hideStatusBarWhileZooming: true,
                                onZoomStart: () {
                                  print('Zoom started');
                                },
                                onZoomEnd: () {
                                  print('Zoom finished');
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Row(
                              children: [
                                LikeButton(
                                  size: 30,
                                  circleColor: CircleColor(
                                      start: Colors.yellow, end: Colors.yellow),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: Colors.yellow,
                                    dotSecondaryColor: Colors.yellow,
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      Icons.whatshot,
                                      color: isLiked
                                          ? Colors.yellow
                                          : Colors.white,
                                      size: 30,
                                    );
                                  },
                                  likeCount: 0,
                                  countBuilder:
                                      (int count, bool isLiked, String text) {
                                    var color =
                                        isLiked ? Colors.yellow : Colors.white;
                                    Widget result;
                                    if (count == 0) {
                                      result = Text(
                                        "0",
                                        style: TextStyle(color: color),
                                      );
                                    } else
                                      result = Text(
                                        text,
                                        style: TextStyle(color: color),
                                      );
                                    return result;
                                  },
                                ),
                                SizedBox( width: 15.0,),
                                SizedBox(
                                    height: 25.0,
                                    width: 25.0,
                                    child: new IconButton(
                                      padding: new EdgeInsets.all(0.0),
                                      icon: Image.asset("assets/images/commentary.png"),
                                    )
                                ),
                                Spacer(),
                                LikeButton(
                                  size: 25,
                                  circleColor: CircleColor(
                                      start: Colors.yellow, end: Colors.yellow),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: Colors.yellow,
                                    dotSecondaryColor: Colors.yellow,
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    return Image.asset("assets/images/bookmark.png", color: isLiked
                                        ? Colors.yellow
                                        : Colors.white,
                                    );

                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0,)

                        ],
                      ),
                    ),
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
