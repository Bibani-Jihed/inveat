import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/lib/utilities/constants/colors.dart'
    as mColors;
import 'package:inveat/utilities/constants/strings.dart' as Strings;
import 'package:inveat/views/welcome_screen.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:inveat/models/post_model.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/data.dart';
import 'package:inveat/views/personal_information_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 40.0, left: 12.0),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account',
                                style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PersonalInfoScreen()),
                                  );
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.account_circle_sharp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        'Personal Information',
                                        style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: mColors.black,
                                  onPrimary: mColors.mc_start,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.archive,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        'Saved Posts',
                                        style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: mColors.black,
                                  onPrimary: mColors.mc_start,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.whatshot,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        'Liked Posts',
                                        style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: mColors.black,
                                  onPrimary: mColors.mc_start,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.history,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        'Search History',
                                        style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: mColors.black,
                                  onPrimary: mColors.mc_start,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Privacy',
                                style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.lock_outline_rounded,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        'Password',
                                        style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: mColors.black,
                                  onPrimary: mColors.mc_start,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                child: Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.email_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Text(
                                        'Email',
                                        style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: mColors.black,
                                  onPrimary: mColors.mc_start,
                                ),
                              ),
                            ],
                          ),
                        )
                        //Post Header
                      ],
                    ),
                  ),
                  //Lets Sign
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
            child:
             Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                ),
                Text(
                  "Settings",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            )
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              ElevatedButton(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                    crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                  children: [

                    Text(
                      "Log out",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.nunito(
                        color: Colors.red,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                     SizedBox(
                       width: 10.0,
                     ),
                     Icon(Icons.logout,color: Colors.red,),

                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: mColors.black,
                  onPrimary: mColors.mc_start,
                ),
                onPressed: () async{
                  await SharedPreferences.getInstance().then((value) => value.remove("user"));
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      Welcome()), (Route<dynamic> route) => false);
                },
              ),
              SizedBox(height: 20.0,),

            ],
          )
        ],
      ),
    );
  }
}
