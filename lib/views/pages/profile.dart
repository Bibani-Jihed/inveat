import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/insta/story_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/constants/colors.dart'
    as mColors;
import 'package:inveat/utilities/constants/strings.dart' as Strings;
import 'package:inveat/views/welcome_screen.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
    'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
    'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
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

  PageController _controller = PageController(
    initialPage: 0,
  );
  void changePage(int index) {
    print(index);
    _tabIndex=index;
    _tabController.index = _tabIndex;
    _tabController.animateTo(_tabIndex);
    _controller.animateToPage(_tabIndex,duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
  Widget buildPageView() {
    return PageView(
      controller: _controller,
      onPageChanged: (index) {
        changePage(index);
      },
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(12.0),
          child: StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              shrinkWrap: false,
              mainAxisSpacing: 12,
              //physics: NeverScrollableScrollPhysics(),
              itemCount: imageList.length,
              itemBuilder: (BuildContext context,
                  int index) =>
                  GestureDetector(
                    onTap: () {
                      print("item clicked");
                    },
                    child: new Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                              Radius.circular(15))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(15)),
                        child: CachedNetworkImage(
                          imageUrl: imageList[index],
                          fit: BoxFit.cover,
                          errorWidget:
                              (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(
                    1, index.isEven ? 1.2 : 1.8);
              }),
        ),
        Text(
          'Page 1',
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: mColors.black,
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
               margin: EdgeInsets.only(left:14.0,right: 14.0,bottom: 10.0),
               child: Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: <Widget>[
                     Text(
                       "djo.bibani",
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
                         onPressed: () {},
                       ),
                     ),
                   ],),
             ),
             Expanded(child: NestedScrollView(
               physics: NeverScrollableScrollPhysics(),
               headerSliverBuilder: (context,isScolled){
                 return [
                   SliverAppBar(
                     backgroundColor: mColors.black,
                     collapsedHeight: 320,
                     expandedHeight: 320,
                     flexibleSpace: Container(
                       margin: EdgeInsets.only(top:40.0),
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
                           "Jihed Bibani",
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
                     delegate: MyDelegate(
                         TabBar(
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
                         )
                     ),
                     floating: true,
                     pinned: true,
                   )
                 ];
               },
               body: buildPageView(),
             ),)

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
    );
  }
}


class MyDelegate extends SliverPersistentHeaderDelegate{
  MyDelegate(this.tabBar);
  final TabBar tabBar;
  Container container;
  Widget _builsTabBarContainer(){
    container =Container(
      height: 70.0,
      margin: EdgeInsets.only(left:14.0, right: 120.0,top: 7.0,bottom: 7.0),
      child: tabBar,
    );
    return container;
  }
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: mColors.black,
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