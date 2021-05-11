import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
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
import 'package:multi_image_picker/multi_image_picker.dart';

class Home extends StatefulWidget {
  PageController controller;
  @override
  _HomeState createState() => _HomeState();
  Home({
    this.controller,
  });
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =new GlobalKey<RefreshIndicatorState>();
    String comment;
    String dropdownValue = 'All';
    List<Post>posts=List.empty();
    Future<List<Post>> getPostsFuture;

    List<Asset> images = <Asset>[];
    String _error = 'No Error Dectected';


    Future<List<String>> getFileList() async {
      List<String>files=[];
      print("images length: "+images.length.toString());
      files.clear();
      for (int i = 0; i < images.length; i++) {
        var path = await FlutterAbsolutePath.getAbsolutePath(images[i].identifier);
        print(path);
        files.add(path);
      }
      print("files:"+files.length.toString());
      return files;
    }

    Future<void> loadAssets() async {
      List<Asset> resultList = <Asset>[];
      String error = 'No Error Detected';

      try {
        resultList = await MultiImagePicker.pickImages(
          maxImages: 10,
          enableCamera: true,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            statusBarColor: "#000000",
            actionBarColor: "#000000",
            actionBarTitle: "Select",
            allViewTitle: "All Photos",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
            selectionLimitReachedText: "You can't select any more.",
          ),
        );
      } on Exception catch (e) {
        error = e.toString();
      }

      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;

      if(resultList.isNotEmpty) {
        setState(() {
          images = resultList;
        });
        var files = await getFileList();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  PostSelection(callback: () {
                    Navigator.pop(context);
                    onRefresh();
                  }, files: files,)),
        );
      }

    }
    Future<List<Post>> GetPosts(String funName) async {
      print("funName: "+funName);
      _refreshIndicatorKey.currentState?.show();
      Map<String, String> params;
      if (dropdownValue == "All") {
        params = null;
      }else if(dropdownValue == "Nearby"){
        params= await PlaceService.GetInfoForNearbyPosts();
        print("params: "+params.toString());
      }

      posts=await PostService.GetPosts(params);
      print("sqdqsd"+posts.length.toString());
      if(posts.length==0){
        posts=null;
      }
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
    Widget _buildPosts(){
      return
      Container(
        child: FutureBuilder(
            future: getPostsFuture,
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

                        return PostWidget(post: snapshot.data[index],controller: widget.controller,);
                      }else{

                           return Container();
                      }
                    }
                    else {
                      print("else");
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
            }),
      );
  
    }
    @override
    void initState() {
      getPostsFuture=GetPosts("from init");
      super.initState();
    }
    void callBack(){
      onRefresh();
    }
    Future<List<Post>> onRefresh() async{

      setState(() {
        getPostsFuture=GetPosts("onRefresh");
      });
      return await getPostsFuture;
    }
    @override
    Widget build(BuildContext context) {
      super.build(context);
      return SafeArea(
        child: Stack(
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
                        _buildPosts(),
                        //Lets Sign
                      ],
                    ),
                  ),
                ),
                onRefresh: onRefresh,
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
                        GetPosts("DropdownButton");
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
                        onPressed: loadAssets,
                        /*onPressed: () {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostSelection(callback:(){
                                  Navigator.pop(context);
                                  onRefresh();
                                })),
                          );
                        },*/
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      );
    }

  @override
  bool get wantKeepAlive => true;
  

}
