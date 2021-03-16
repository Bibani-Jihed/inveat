import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inveat/views/login_screen.dart';
import 'package:inveat/views/pages/home.dart';
import 'package:inveat/views/pages/profile.dart';
import 'package:inveat/views/signup_screen.dart';
import 'package:inveat/views/welcome_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/constants/colors.dart'
    as mColors;
import 'package:inveat/utilities/constants/strings.dart' as Strings;

class Navigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex;
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildPageView() {
    return PageView(
      controller: _controller,
      onPageChanged: (index) {
        changePage(index);
      },
      children: <Widget>[
        Home(),
        Profile(),
      ],
    );
  }

  Widget _buildBottombar(BuildContext context) {
    return Container(
      color: mColors.black,
      padding: const EdgeInsets.only(left: 0.0,right: 120.0),
      child: BubbleBottomBar(
        backgroundColor: mColors.black,
        opacity: 1,
        currentIndex: currentIndex,
        onTap: (index) {
          bottomTapped(index);
        },
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 1,
        fabLocation: BubbleBottomBarFabLocation.end,
        //new
        hasNotch: true,
        //new
        hasInk: false,
        //new, gives a cute ink effect
        inkColor: Colors.yellow,
        //optional, uses theme color if not specified
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
            backgroundColor: Colors.yellow,
            icon: Icon(
              Icons.dashboard,
              color: Colors.yellow,
            ),
            activeIcon: Icon(
              Icons.dashboard,
              color: mColors.black,
            ),
            title: Text(
              'Feed',
              style: GoogleFonts.nunito(
                  color: mColors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0),
            ),
          ),
          BubbleBottomBarItem(
            backgroundColor: Colors.yellow,
            icon: Icon(
              Icons.menu,
              color: Colors.yellow,
            ),
            activeIcon: Icon(
              Icons.menu,
              color: mColors.black,
            ),
            title: Text(
              'Profile',
              style: GoogleFonts.nunito(
                  color: mColors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      changePage(index);
      _controller.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildPageView(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottombar(context),
          ),
        ],
      ),
    );
  }
}
