import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_button/insta/story_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/models/comment_model.dart';
import 'package:inveat/models/post_model.dart';
import 'package:inveat/models/user_model.dart';
import 'package:inveat/utilities/constants/colors.dart';
import 'package:inveat/utilities/constants/api.dart' as api;
import 'package:inveat/data/post_service.dart' as PostService;
import 'package:inveat/data/user_service.dart' as UserService;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:like_button/like_button.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:inveat/views/widgets/user_widget.dart';


class PostWidget extends StatefulWidget {
  Post post;
  PageController controller;
  @override
  _PostWidgetState createState() => _PostWidgetState();

  PostWidget({
    this.post,
    this.controller,
  });
}

class _PostWidgetState extends State<PostWidget> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  String comment = '';
  bool isCommentError = false;
  bool isLikedDefault = true;
  final _commentController = TextEditingController();
  final pageController = PageController();

  Future<void> _sendComment() async {
    var tmp = comment;
    _commentController.text = "";
    Map<String, String> form = {
      "post_id": widget.post.id.toString(),
      "comment": tmp
    };
    final comment_res = await PostService.AddComment(form);
    widget.post.comments.add(comment_res);
    FocusScope.of(context).requestFocus(FocusNode());
  }

  String _getTimeDifferenceFromNow(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inSeconds < 5) {
      return "Just now";
    } else if (difference.inMinutes < 1) {
      return "${difference.inSeconds}s ago";
    } else if (difference.inHours < 1) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }

  void _buildSettingModalBottomSheet(context) {
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

  Widget _buildShowCommentsButton() {
    if (widget.post.comments.length > 0)
      return Container(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        child: GestureDetector(
          onTap: () {
            _buildCommentsView(context);
          },
          child: Text('View all ${widget.post.comments.length} comments',
              style: GoogleFonts.nunito(
                color: Colors.white.withOpacity(0.5),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              )),
        ),
      );
    return Container();
  }

  Widget _buildCommentTF() {
    return Container(
      height: 70,
      color: MColors.black,
      child: Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
        alignment: Alignment.centerLeft,
        height: 60.0,
        decoration: BoxDecoration(
          color: MColors.black,
          border: Border.all(
              color: isCommentError ? Colors.red : MColors.mc_end,
              // set border color
              width: 1.0), // set border width
          borderRadius: BorderRadius.all(
              Radius.circular(20.0)), // set rounded corner radius
        ),
        child: TextField(
          onChanged: (text) {
            setState(() {
              comment = text;
              isCommentError = false;
            });
          },
          controller: _commentController,
          maxLines: null,
          cursorColor: Colors.white,
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 30.0, top: 17.5),
            hintText: 'Write your comment...',
            hintStyle: GoogleFonts.nunito(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
            suffixIcon: Container(
              width: 40.0,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: IconButton(
                iconSize: 2,
                icon: Image.asset("assets/images/send.png"),
                onPressed: () {
                  if (comment == null || comment.isEmpty) {
                    isCommentError = true;
                  } else {
                    _sendComment();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentViewMainContent() {
    if (widget.post.comments.length > 0) {
      return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70.0,
            ),
            ListView.builder(
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.post.comments.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 20, bottom: 5),
                    child:
                        _buildCommentItem(widget.post.comments[index], index),
                  );
                }),
            SizedBox(
              height: 70.0,
            ),
          ],
        ),
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/conversation.png',
            height: 120.0,
            color: Colors.white.withOpacity(0.1),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'No Comments Yet',
            style: GoogleFonts.nunito(
              color: Colors.white.withOpacity(0.1),
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            'Be the first to comment',
            style: GoogleFonts.nunito(
              color: Colors.white.withOpacity(0.1),
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _buildCommentsView(context) {

    showModalBottomSheet(
        backgroundColor: MColors.black,
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
              height: MediaQuery.of(context).size.height-20,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Stack(
                  children: [
                    _buildCommentViewMainContent(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildCommentTF(),
                      ],
                    ),
                    Container(
                      height: 50.0,
                      color: MColors.black,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.whatshot,
                              color: Colors.yellow,
                              size: 25.0,
                            ),
                          ),
                          Text(
                            widget.post.likes.length.toString() + ' likes',
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 25.0,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget _buildCommentMainItem(Comment comment) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SizedBox(
            width: 30.0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  StoryButton(
                    size: 30,
                    onPressed: () {},
                    child: CachedNetworkImage(
                      imageUrl: api.BASE_URL + comment.user.image_user.url,
                      fit: BoxFit.cover,
                      width: 25,
                      height: 25,
                      errorWidget: (context, url, error) => Icon(Icons.error),
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
            padding: EdgeInsets.only(left: 40.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Wrap(
                children: [
                  if (widget.post.content != null)
                    RichText(
                        maxLines: null,
                        text: TextSpan(
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                          children: <TextSpan>[
                            new TextSpan(
                              text: comment.user.first_name +
                                  " " +
                                  comment.user.last_name,
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            new TextSpan(text: '  '),
                            new TextSpan(
                              text: comment.comment,
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ))
                ],
              ),
              Text(
                _getTimeDifferenceFromNow(DateTime.parse(comment.created_at)),
                textAlign: TextAlign.start,
                style: GoogleFonts.nunito(
                  color: Colors.white70,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentItem(Comment comment, int index) {
    return FutureBuilder<User>(
        future: UserService.GetCurrentUser(),
        builder: (context, snapshot) {
          print("isNull"+(snapshot.data==null).toString());
          if(snapshot.data!=null) {
            if (snapshot.data.id == widget.post.user.id ||
                snapshot.data.id == comment.user.id) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: _buildCommentMainItem(comment),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () async {
                      final res_code =
                      await PostService.RemoveComment(comment.id);
                      if (res_code == 201) {
                        setState(() {
                          widget.post.comments = List.from(widget.post.comments)
                            ..removeAt(index);
                        });
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            } else {
              return _buildCommentMainItem(comment);
            }
          }
          else{
            return Container();
          }
        });
  }

  Future<bool> _isCurrentUserLiked() async {
    final user = await UserService.GetCurrentUser();
    for (var like in widget.post.likes) {
      if (like.user.id == user.id) return true;
    }
    return false;
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    await PostService.LikeOrDislike(widget.post.id);

    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
              child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Post Header
                UserWidget(user:widget.post.user,address_post:widget.post.address_post,controller: widget.controller,),
                //Post Image
                Container(
                    padding: EdgeInsets.all(5.0),
                    constraints: BoxConstraints(minHeight: 100,maxHeight: 300),
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: widget.post.image_posts.length,
                      itemBuilder: (context, index) {
                        return Container(
                          alignment: Alignment.center,
                          child: PinchZoomImage(
                            image: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                              api.BASE_URL + widget.post.image_posts[index].url,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.yellow),
                                  ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            zoomedBackgroundColor:MColors.black,
                            hideStatusBarWhileZooming: true,
                            onZoomStart: () {
                              print('Zoom started');
                            },
                            onZoomEnd: () {
                              print('Zoom finished');
                            },
                          ),
                        );
                    },)),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5.0),
                  child: SingleChildScrollView(
                    child:
                    Stack(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                            crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                          children: [
                            widget.post.image_posts.length>1?
                            SizedBox(
                              height: 30,
                              child: SmoothPageIndicator(
                                controller: pageController,
                                count: widget.post.image_posts.length,
                                effect: WormEffect(
                                    activeDotColor: Colors.yellow,
                                    dotHeight: 7,
                                    dotWidth: 7
                                ),
                              ),
                            )
                            :Container()
                          ],
                        ),
                        Row(
                          children: [
                            FutureBuilder(
                                future: _isCurrentUserLiked(),
                                builder: (context, snapshot) {
                                  return LikeButton(
                                    isLiked: snapshot.data,
                                    onTap: onLikeButtonTapped,
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
                                    likeCount: widget.post.likes.length,
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
                                  );
                                }),
                            SizedBox(
                              width: 15.0,
                            ),
                            SizedBox(
                                height: 25.0,
                                width: 25.0,
                                child: new IconButton(
                                  padding: new EdgeInsets.all(0.0),
                                  icon: Image.asset("assets/images/commentary.png"),
                                  onPressed: () {
                                    _buildCommentsView(context);
                                  },
                                )),
                            Spacer(),
                          ],
                        ),
                      ],
                    )

                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Wrap(
                    children: [
                      if (widget.post.content != null)
                        RichText(
                            maxLines: null,
                            text: TextSpan(
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                                new TextSpan(
                                  text: widget.post.user.first_name,
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                new TextSpan(text: '  '),
                                new TextSpan(
                                  text: widget.post.content,
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                _buildShowCommentsButton(),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                      _getTimeDifferenceFromNow(
                          DateTime.parse(widget.post.created_at)),
                      style: GoogleFonts.nunito(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
