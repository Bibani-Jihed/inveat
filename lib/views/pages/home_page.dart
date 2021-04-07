import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/insta/story_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/lib/utilities/constants/colors.dart' as mColors;
import 'package:inveat/data/place_service.dart' as PlaceService;
import 'package:inveat/models/post_model.dart';
import 'package:inveat/utilities/constants/colors.dart';
import 'package:inveat/views/new_post_selection_screen.dart';
import 'package:inveat/views/widgets/post_widget.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/views/story_screen.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/data.dart';
import 'package:inveat/data/post_service.dart' as PostService;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamController _postsController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  String comment;
  String dropdownValue = 'All';
  List<Post>posts=List.empty();
  Future<List<Post>> GetPosts() async {
    _refreshIndicatorKey.currentState?.show();
    Map<String, String> params;
    if (dropdownValue == "All") {
      params = null;
    }else if(dropdownValue == "Nearby"){
      params= await PlaceService.GetInfoForNearbyPosts();
      print("params: "+params.toString());
    }

    final tmp=await PostService.GetPosts(params);
    setState(() {
      posts=tmp;
    });
    if(posts.length==0){
      posts=null;
    }
    _postsController.add(posts);
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
  Widget _buildPostsStream(){
    return
      StreamBuilder(
          stream: _postsController.stream,
          builder: (context, snapshot) {
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data != null ? snapshot.data.length : 1,
                itemBuilder: (context, index) {
                  if (snapshot.hasData && snapshot.data != null) {
                    if (snapshot.data[index].image_posts.length >= 1)
                    {
                      return PostWidget(post: snapshot.data[index]);
                    }
                  }
                  else {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/shutter.png',
                            height: 120.0,
                            color: Colors.white.withOpacity(0.1),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'No Posts Yet',
                            style: GoogleFonts.nunito(
                              color: Colors.white.withOpacity(0.1),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                });
          });

  }
  @override
  void initState() {
    _postsController = new StreamController();
    GetPosts();
    super.initState();
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
            margin: EdgeInsets.only(top: 25.0),
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              color: Colors.yellow,
              backgroundColor: MColors.black,
              child: Container(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    bottom: 60.0,
                    top: 35.0
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[

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

                      //_buildPosts(),
                      _buildPostsStream(),
                      //Lets Sign
                    ],
                  ),
                ),
              ),
              onRefresh: GetPosts,
            ),
          ),

          Container(
            color: MColors.black,
            padding: EdgeInsets.only(top: 8.0,right: 10.0),
            height: 60.0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  DropdownButton<String>(
                    icon: Image.asset("assets/images/filter.png"),
                    dropdownColor: Colors.black,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                      GetPosts();
                    },
                    underline: Container(
                      height: 0,
                      color: MColors.black,
                    ),
                    items: <String>['All', 'Nearby']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 8.0,),
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

        ],
      ),
    );
  }
}
