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
import 'package:inveat/views/widgets/post_widget.dart';
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
                        PostWidget(post: widget.post)
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
