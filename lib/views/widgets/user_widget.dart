import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/insta/story_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/data/user_service.dart' as UserService;
import 'package:inveat/views/Profile_screen.dart';
import 'package:inveat/utilities/constants/api.dart' as api;
import '../../models/address_post.dart';
import '../../models/user_model.dart';

class UserWidget extends StatefulWidget {
  User user;
  Address address_post;
  PageController controller;

  @override
  _UserWidgetState createState() => _UserWidgetState();

  UserWidget({
    this.user,
    this.address_post,
    this.controller,
  });
}
void showProfile(controller,context,User user)async {
  final CurrentUser = await UserService.GetCurrentUser();
  if (CurrentUser.id == user.id) {
    controller.animateToPage(
        1, duration: Duration(milliseconds: 500), curve: Curves.ease);
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              UserProfile(user: user)),
    );
  }
}
class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
      return Container(
        margin: EdgeInsets.only(left: 10.0,right: 10.0),
        child:
        GestureDetector(
          onTap: ()async{
            await showProfile(widget.controller,context,widget.user);
          },
          child: Row(
            children: [
              SizedBox(
                width: 50.0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      StoryButton(
                        size: 40,
                        onPressed: () {
                          showProfile(widget.controller,context,widget.user);
                        },
                        child: CachedNetworkImage(
                          imageUrl: api.BASE_URL +
                              widget.user.image_user.url,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user.first_name != null
                            ? widget.user.first_name +
                            " " +
                            widget.user.last_name
                            : "",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        widget.address_post != null
                            ? widget.address_post.city +
                            "," +
                            widget.address_post
                                .governerate +
                            "," +
                            widget.address_post.country
                            : "",
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
        )

      );
  }

}