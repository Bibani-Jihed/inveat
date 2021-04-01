

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inveat/utilities/constants/colors.dart';
import 'package:inveat/views/navigation_screen.dart';
import 'package:inveat/data/user_service.dart' as UserService;

class CompleteProfile extends StatefulWidget {

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}
class _CompleteProfileState extends State<CompleteProfile>{

  /********** Image Picker ***********/
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,imageQuality: 5);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
  /********** Image Picker ***********/
  String first_name;
  String last_name;


  void Update() async{
    EasyLoading.show(status: 'loading...');
    final avatar_statusCode=await UserService.UploadUserImage(_image);
    Map<String,String>form={"first_name":first_name,"last_name":last_name};
    final profileInfo_statusCode=await UserService.UpdateUser(form);
    EasyLoading.dismiss();


    if(avatar_statusCode==200 && profileInfo_statusCode==201){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Navigation()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: MColors.black,
          ),
        ),
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 60.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50.0),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                      Text(
                        "One last step",
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Give life to your account",
                        style: GoogleFonts.nunito(
                          color: Colors.white70,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
                      backgroundColor: MColors.mc_end,
                      child: _image != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Container(
                        decoration: BoxDecoration(
                            color: MColors.black,
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                  EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: [

                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 60.0,
                        child: TextField(
                          onChanged: (text){
                            first_name=text;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                          decoration: InputDecoration(
                            hintText: "Enter your Firstname",
                            labelText: "Firstname",
                            hintStyle: GoogleFonts.nunito(
                                color: Colors.white70,
                                fontWeight: FontWeight.w700),
                            labelStyle: new TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
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
                          onChanged: (text){
                            last_name=text;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                          decoration: InputDecoration(
                            hintText: "Enter your Lastname",
                            labelText: "Lastname",
                            hintStyle: GoogleFonts.nunito(
                                color: Colors.white70,
                                fontWeight: FontWeight.w700),
                            labelStyle: new TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Update();
                            /*Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Navigation()),
                            );*/
                          },
                          child: Text(
                            'Continue',
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
                                borderRadius:
                                new BorderRadius.circular(20.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }

}