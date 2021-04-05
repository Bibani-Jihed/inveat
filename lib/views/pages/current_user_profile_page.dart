import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/insta/story_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/models/image_posts_model.dart';
import 'package:inveat/models/user_model.dart';
import 'package:inveat/utilities/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../personal_information_screen.dart';
import 'package:inveat/data/user_service.dart' as UserService;
import 'package:inveat/data/post_service.dart' as PostService;
import 'package:inveat/utilities/constants/api.dart' as api;
import 'package:inveat/views/welcome_screen.dart';
import 'package:inveat/models/post_model.dart';
import 'package:inveat/views/post_screen.dart';
import 'package:inveat/utilities/data.dart';
import 'package:inveat/views/settings_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
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
    null,
    'Even the stars were jealous of the sparkle in her eyes',
    'Stress less and enjoy the best',
    null,
    'Get out there and live a little ',
    'I’m not high maintenance, you’re just low effort',
    'Life is better when you’re laughing',
    null,
    'Look for the magic in every moment',
    'A sass a day keeps the basics away',
  ];
  TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  PageController _pageController = PageController(
    initialPage: 0,
  );

  void changePage(int index) {
    _tabIndex = index;
    _tabController.index = _tabIndex;
    _tabController.animateTo(_tabIndex);
    _pageController.animateToPage(_tabIndex,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
  Future<List<Post>>_getUserPosts ({Map<String, dynamic> params})async{
    final user=await UserService.GetCurrentUser();
    final posts = await PostService.GetPosts(params);
    List<Post>user_posts=new List<Post>();
    for(var post in posts){
      if(post.user.id==user.id && post.image_posts.length>0){
        user_posts.add(post);
    }
    }
    return user_posts;
  }

  Widget buildFeedView() {
    return Container(
      margin: EdgeInsets.only(left: 12.0,right:12.0,bottom: 12.0),
      child:
      FutureBuilder<List<Post>>(
          future: _getUserPosts(),
          builder: (context, snapshot) {
            return  StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                shrinkWrap: false,
                mainAxisSpacing: 12,
                //physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data==null?0:snapshot.data.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PostScreen(
                                      post: snapshot.data[index])),
                        );
                      },
                      child: new Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          child: CachedNetworkImage(
                            imageUrl: api.BASE_URL+snapshot.data[index].image_posts[0].url,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Icon(Icons.error),
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

  Widget buildInfoView(User user) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: 60.0,
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: user==null?'':user.first_name),
                keyboardType: TextInputType.text,
                style: GoogleFonts.nunito(
                    color: Colors.white, fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  hintText: "Enter your firstname",
                  labelText: "Firstname",
                  hintStyle: GoogleFonts.nunito(
                      color: Colors.white70, fontWeight: FontWeight.w700),
                  labelStyle: new TextStyle(color: Colors.yellow),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 60.0,
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: user!=null?user.last_name:""),
                keyboardType: TextInputType.text,
                style: GoogleFonts.nunito(
                    color: Colors.white, fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  hintText: "Enter your lastname",
                  labelText: "Lastname",
                  hintStyle: GoogleFonts.nunito(
                      color: Colors.white70, fontWeight: FontWeight.w700),
                  labelStyle: new TextStyle(color: Colors.yellow),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 60.0,
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text:user!=null?user.email:""),
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.nunito(
                    color: Colors.white, fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  labelText: "Email",
                  hintStyle: GoogleFonts.nunito(
                      color: Colors.white70, fontWeight: FontWeight.w700),
                  labelStyle: new TextStyle(color: Colors.yellow),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PersonalInfoScreen()),
                  );
                },
                child: Text(
                  'Edit Profile',
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: MColors.black,
                  onPrimary: MColors.mc_start,
                  side: BorderSide(width: 2.0, color: Colors.white),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPageView(User user) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        changePage(index);
      },
      children: <Widget>[buildFeedView(), buildInfoView(user)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: UserService.GetCurrentUser(),
        builder: (context, snapshot) {
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 40.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 14.0, right: 14.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Spacer(),
                              SizedBox(
                                height: 40.0,
                                width: 40.0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  iconSize: 40.0,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                        builder: (context) => SettingsScreen()));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: NestedScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            headerSliverBuilder: (context, isScolled) {
                              return [
                                SliverAppBar(
                                  backgroundColor: MColors.black,
                                  collapsedHeight: 225,
                                  expandedHeight: 225,
                                  flexibleSpace: Container(
                                    child: Column(children: <Widget>[
                                      StoryButton(
                                        size: 140,
                                        onPressed: () {},
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot.data!=null?api.BASE_URL+snapshot.data.image_user.url:api.IMAGE_PLACEHODER,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => new CircularProgressIndicator(),
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
                                        snapshot.data!=null?(snapshot.data.first_name + ' ' + snapshot.data.last_name):'',
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
                                                    future:_getUserPosts(),
                                                    builder: (context,snapshot){
                                                  return Text(
                                                    snapshot.data!=null?snapshot.data.length.toString():"0",
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
                                SliverPersistentHeader(
                                  delegate: MyDelegate(TabBar(
                                    onTap: (index) {
                                      changePage(index);
                                    },
                                    controller: _tabController,
                                    tabs: [
                                      Tab(text: "Feed"),
                                      Tab(text: "Info"),
                                    ],
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ),
                                      color: Colors.yellow,
                                    ),
                                    labelColor: MColors.black,
                                    labelStyle: GoogleFonts.nunito(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                    unselectedLabelColor: Colors.yellow,
                                  )),
                                  floating: true,
                                  pinned: true,
                                )
                              ];
                            },
                            body: buildPageView(snapshot.data),
                          ),
                        )
                      ],
                    ),
                  )

                ]),
              ));
        });
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);

  final TabBar tabBar;
  Container container;

  Widget _builsTabBarContainer() {
    container = Container(
      height: 70.0,
      margin: EdgeInsets.only(left: 14.0, right: 120.0, top: 7.0, bottom: 7.0),
      child: tabBar,
    );
    return container;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Container(
      color: MColors.black,
      child: _builsTabBarContainer(),
    );
  }

  @override
  double get maxExtent => 70.0;

  @override
  double get minExtent => 70.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
