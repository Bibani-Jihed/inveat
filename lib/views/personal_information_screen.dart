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
import 'package:like_button/like_button.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:inveat/models/post_model.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/data.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfoScreen> {
  /********** Image Picker ***********/
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  /********** Image Picker ***********/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: MColors.black,
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 150.0,left: 20.0,right: 20.0),
                child: Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child:
                        CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 12.0,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 15.0,
                                  color: Color(0xFF404040),
                                ),
                              ),
                            ),
                            radius: 38.0,
                            backgroundImage: NetworkImage(users[0].profileImageUrl),
                          ),
                        ),
                        /*SizedBox(
                            width: 100,
                            height: 100,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 52,
                                  backgroundColor: mColors.mc_end,
                                  child: _image != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      _image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                      : Container(
                                      decoration: BoxDecoration(
                                          color: mColors.black,
                                          borderRadius: BorderRadius.circular(50)),
                                      width: 100,
                                      height: 100,
                                      child:ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: CachedNetworkImage(
                                          imageUrl: users[0].profileImageUrl,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),
                                      )
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child:IconButton(icon: Icon(Icons.email_outlined,color: Colors.white,), onPressed: (){})
                                  ,
                                )
                              ],
                            )
                          )*/

                      ),
                    ),
                    SizedBox(height: 40.0,),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: MColors.black,
                        border: Border.all(
                            color: MColors.mc_end, // set border color
                            width: 2.0), // set border width
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        // set rounded corner radius
                      ),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.nunito(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                          hintText: 'Enter your Phone Number',
                          hintStyle: GoogleFonts.nunito(
                              color: Colors.white70, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: MColors.black,
                        border: Border.all(
                            color: MColors.mc_end, // set border color
                            width: 2.0), // set border width
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        // set rounded corner radius
                      ),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.nunito(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        controller: TextEditingController(text: "Male"),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                          hintText: 'Enter your Gender',
                          hintStyle: GoogleFonts.nunito(
                              color: Colors.white70, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: MColors.black,
                        border: Border.all(
                            color: MColors.mc_end, // set border color
                            width: 2.0), // set border width
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        // set rounded corner radius
                      ),
                      child: TextField(
                        controller: TextEditingController(text: "Sep 3, 1995"),
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.nunito(
                            color: Colors.white, fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                          hintText: 'Enter your Birthday',
                          hintStyle: GoogleFonts.nunito(
                              color: Colors.white70, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Save',
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
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
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
                    "Personal Information",
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
          ],
        ),
      )
    );
  }
}
