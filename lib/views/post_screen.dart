import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/insta/insta_love_button.dart';
import 'package:flutter_button/insta/story_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inveat/utilities/constants/colors.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/constants/colors.dart'
    as mColors;
import 'package:inveat/utilities/constants/strings.dart' as Strings;
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/views/story_screen.dart';
import 'package:inveat/views/welcome_screen.dart';
import 'package:like_button/like_button.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:inveat/models/post_model.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/data.dart';

class PostScreen extends StatefulWidget {
  final Post post;

  const PostScreen({@required this.post});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<PostScreen> {
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: MColors.black,
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
                  title: new Text(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: MColors.black,
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
                    child: Column(
                      children: [
                        //Post Header
                        Container(
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Colors.white,
                              ),
                              Text(
                                "Post",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:15.0),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10.0,bottom: 10.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 50.0,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            StoryButton(
                                              size: 40,
                                              onPressed: () {},
                                              child: CachedNetworkImage(
                                                imageUrl: widget.post.user.profileImageUrl,
                                                fit: BoxFit.cover,
                                                width: 35,
                                                height: 35,
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
                                          ]),
                                    ),
                                    Container(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.post.user.first_name,
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
                                icon:
                                    Icon(Icons.more_vert, color: Colors.white),
                                iconSize: 20,
                                onPressed: () {
                                  _settingModalBottomSheet(context);
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
                                imageUrl: widget.post.imageurl,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.yellow),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
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
                          padding: EdgeInsets.only(left: 5.0,top: 8.0),
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
                                    color:
                                        isLiked ? Colors.yellow : Colors.white,
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
                              SizedBox(
                                width: 15.0,
                              ),
                              SizedBox(
                                  height: 25.0,
                                  width: 25.0,
                                  child: new IconButton(
                                    padding: new EdgeInsets.all(0.0),
                                    icon: Image.asset(
                                        "assets/images/commentary.png"),
                                  )),
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
                                  return Image.asset(
                                    "assets/images/bookmark.png",
                                    color:
                                        isLiked ? Colors.yellow : Colors.white,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        )
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
