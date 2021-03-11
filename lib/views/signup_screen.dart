import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/constants/colors.dart'
    as mColors;
import 'package:inveat/utilities/constants/strings.dart' as Strings;
import 'package:inveat/views/navigation.dart';
import 'package:inveat/views/welcome_screen.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email = "";
  String password = "";
  final TextEditingController controller = TextEditingController();

  /********** Building View ***********/
  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 75.0,
          decoration: BoxDecoration(
            color: mColors.black,
            border: Border.all(
                color: mColors.mc_end, // set border color
                width: 2.0), // set border width
            borderRadius: BorderRadius.all(
                Radius.circular(20.0)), // set rounded corner radius
          ),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.nunito(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 14.0),
              hintText: 'Email or username',
              hintStyle: GoogleFonts.nunito(color: Colors.white70),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 75.0,
          decoration: BoxDecoration(
            color: mColors.black,
            border: Border.all(
                color: mColors.mc_end, // set border color
                width: 2.0), // set border width
            borderRadius: BorderRadius.all(
                Radius.circular(20.0)), // set rounded corner radius
          ),
          child: TextField(
            obscureText: true,
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 14.0),
              hintText: 'Password',
              hintStyle: GoogleFonts.nunito(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildConfirmPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 75.0,
          decoration: BoxDecoration(
            color: mColors.black,
            border: Border.all(
                color: mColors.mc_end, // set border color
                width: 2.0), // set border width
            borderRadius: BorderRadius.all(
                Radius.circular(20.0)), // set rounded corner radius
          ),
          child: TextField(
            obscureText: true,
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 14.0),
              hintText: 'Confirm Password',
              hintStyle: GoogleFonts.nunito(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildSignupButton() {
    return SizedBox(
      width: double.infinity,
      height: 70.0,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Navigation()),
          );
        },
        child: Text(
          'SIGN UP',
          style: GoogleFonts.nunito(
            color: mColors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: mColors.mc_start,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
        ),
      ),
    );
  }
  /********** Building View ***********/

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
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 60.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Image.asset("assets/images/back.png"),
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  /*Text(
                    Strings.LETS_SIGN_YOU_IN,
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),//Lets Sign
                  Text(
                    Strings.WELCOME_BACK,
                    style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ), //Welcome
                  Text(
                    Strings.YOUVE_BEEN_MISSED,
                    style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),//You've been Missed
                  */
                  SizedBox(height: 50.0),
                  Text(
                    "Join the community?",
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),//Lets Sign
                  Text(
                    "Create your account first",
                    style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: CircleAvatar(
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
                            :Container(
                                decoration: BoxDecoration(
                                    color: mColors.black,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white70,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.0),

                  _buildEmailTF(),
                  SizedBox(height: 8.0),
                  _buildPasswordTF(),
                  SizedBox(height: 8.0),
                  _buildConfirmPasswordTF(),
                ],
              ),
            ),
          ),
          Container(
            padding: new EdgeInsets.all(10.0),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                _buildSignupButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
