import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/insta/story_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/models/image_posts_model.dart';
import 'package:inveat/models/user_model.dart';
import 'package:inveat/utilities/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inveat/data/post_service.dart' as PostService;
import 'package:inveat/utilities/constants/api.dart' as api;
import 'package:inveat/views/welcome_screen.dart';
import 'package:inveat/models/post_model.dart';
import 'package:inveat/views/post_screen.dart';
import 'package:inveat/utilities/data.dart';
import 'package:inveat/views/settings_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class UserProfile extends StatefulWidget {
  User user;

  @override
  _UserProfileState createState() => _UserProfileState();

  UserProfile({
    this.user,
  });
}

class _UserProfileState extends State<UserProfile> {
  TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  PageController _pageController = PageController(
    initialPage: 0,
  );

  Future<List<Post>> _getUserPosts(
      {Map<String, dynamic> params, User user}) async {
    final posts = await PostService.GetPosts(params);
    List<Post> user_posts = new List<Post>();
    for (var post in posts) {
      if (post.user.id == user.id && post.image_posts.length > 0) {
        user_posts.add(post);
      }
    }
    print("length: " + user_posts.length.toString());
    return user_posts;
  }

  Widget buildFeedView(User user) {
    return Container(
      margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
      child: FutureBuilder<List<Post>>(
          future: _getUserPosts(user: user),
          builder: (context, snapshot) {
            return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                shrinkWrap: true,
                mainAxisSpacing: 12,
                //physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PostScreen(post: snapshot.data[index])),
                        );
                      },
                      child: new Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: CachedNetworkImage(
                            imageUrl: api.BASE_URL +
                                snapshot.data[index].image_posts[0].url,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                staggeredTileBuilder: (index) {
                  return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Stack(children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: MColors.black,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 24.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 90.0,
          ),
          child: NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: MColors.black,
                  collapsedHeight: 225,
                  expandedHeight: 225,
                  flexibleSpace: Container(
                    child: Column(children: <Widget>[
                      StoryButton(
                        size: 140,
                        onPressed: () {},
                        child: CachedNetworkImage(
                          imageUrl: widget.user != null
                              ? api.BASE_URL + widget.user.image_user.url
                              : api.IMAGE_PLACEHODER,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          width: 125,
                          height: 125,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        strokeWidth: 1.5,
                        radius: 120,
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
                        widget.user != null
                            ? (widget.user.first_name +
                                ' ' +
                                widget.user.last_name)
                            : '',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        child: Row(children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                FutureBuilder(
                                    future: _getUserPosts(user: widget.user),
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data != null
                                            ? snapshot.data.length.toString()
                                            : "0",
                                        style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      );
                                    }),
                                Text(
                                  "Posts",
                                  style: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  "73.3k",
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Followers",
                                  style: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Text(
                                  "21",
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Following",
                                  style: GoogleFonts.nunito(
                                    color: Colors.white70,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                ),
              ];
            },
            body: buildFeedView(widget.user),
          ),
        ),
      ]),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
