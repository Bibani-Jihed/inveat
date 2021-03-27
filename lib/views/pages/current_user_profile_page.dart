import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/insta/story_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inveat/utilities/constants/colors.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/constants/colors.dart'
    as mColors;
import 'package:inveat/utilities/constants/strings.dart' as Strings;
import 'package:inveat/utilities/data.dart' as Data;
import 'package:inveat/views/welcome_screen.dart';
import 'package:inveat/models/post_model.dart';
import 'package:inveat/views/post_screen.dart';
import 'package:inveat/utilities/data.dart';
import 'package:transparent_image/transparent_image.dart';
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
    'https://cdn.pixabay.com/photo/2016/11/29/11/38/blur-1869227_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/03/09/12/07/dinner-1246287_1280.jpg',
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
    print(index);
    _tabIndex = index;
    _tabController.index = _tabIndex;
    _tabController.animateTo(_tabIndex);
    _pageController.animateToPage(_tabIndex,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  Widget buildFeedView() {
    return Container(
      margin: EdgeInsets.all(12.0),
      child: StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          shrinkWrap: false,
          mainAxisSpacing: 12,
          //physics: NeverScrollableScrollPhysics(),
          itemCount: imageList.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostScreen(
                            post: new Post(
                                imageurl: imageList[index], user: users[0]))),
                  );
                },
                child: new Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: CachedNetworkImage(
                      imageUrl: imageList[index],
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
          staggeredTileBuilder: (index) {
            return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
          }),
    );
  }

  Widget buildInfoView() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: 60.0,
              child: TextField(
                controller: TextEditingController(text: "Houcem Sanai"),
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.nunito(
                    color: Colors.white, fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  hintText: "Enter your Name",
                  labelText: "Name",
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
              height: 10.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 60.0,
              child: TextField(
                controller: TextEditingController(text: Data.users[0].first_name),
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.nunito(
                    color: Colors.white, fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  hintText: "Enter your Username",
                  labelText: "Username",
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
              height: 10.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 60.0,
              /*decoration: BoxDecoration(
                  color: mColors.black,
                  border: Border.all(
                      color: mColors.mc_end, // set border color
                      width: 2.0), // set border width
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  // set rounded corner radius
                ),*/
              child: TextField(
                controller: TextEditingController(text: "houcem@amitech.com"),
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
              ), /*TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.nunito(
                      color: Colors.white, fontWeight: FontWeight.w700),
                  controller: TextEditingController(text: "djo.bibani"),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                    hintText: 'Enter your Username',
                    hintStyle: GoogleFonts.nunito(
                        color: Colors.white70, fontWeight: FontWeight.w700),
                  ),
                ),*/
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 60.0,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.nunito(
                    color: Colors.white, fontWeight: FontWeight.w700),
                decoration: InputDecoration(
                  hintText: "Enter your Bio",
                  labelText: "Bio",
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
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () {},
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
                      "Settings",
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsScreen()),
                          )
                        }),
                new ListTile(
                  title: Text(
                    "Logout",
                    style: GoogleFonts.nunito(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () => {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Welcome())),
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        changePage(index);
      },
      children: <Widget>[buildFeedView(), buildInfoView()],
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
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 60.0,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 14.0, right: 14.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Data.users[0].first_name,
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
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
                          _settingModalBottomSheet(context);
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
                        collapsedHeight: 320,
                        expandedHeight: 320,
                        flexibleSpace: Container(
                          margin: EdgeInsets.only(top: 40.0),
                          child: Column(children: <Widget>[
                            StoryButton(
                              size: 140,
                              onPressed: () {},
                              child: CachedNetworkImage(
                                imageUrl:Data.users[0].profileImageUrl,
                                fit: BoxFit.cover,
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
                              "Houcem Sanai",
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
                                      Text(
                                        "301",
                                        style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
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
                  body: buildPageView(),
                ),
              )
            ],
          ),
        )
        /* Container(
          child: Column(
            children: [
              Expanded(
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
                                child: IconButton(
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  iconSize: 40.0,
                                  onPressed: () {},
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        child: Column(children: <Widget>[
                          StoryButton(
                            size: 140,
                            onPressed: () {},
                            child: Image.asset(
                              'assets/images/avatar.png',
                              height: 120,
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
                            "djo.bibani",
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
                                    Text(
                                      "301",
                                      style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
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
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 110.0),
                          child: TabBar(
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
                            labelColor: mColors.black,
                            labelStyle: GoogleFonts.nunito(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                            ),
                            unselectedLabelColor: Colors.yellow,
                          )),

                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: buildPageView(),
                      ),

                      //Lets Sign
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),*/
      ]),
    ));
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
