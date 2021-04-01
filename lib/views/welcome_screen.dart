import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inveat/utilities/constants/colors.dart';
import 'package:inveat/views/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Welcome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        child: Text(
          'CONTINUE',
          style: GoogleFonts.nunito(
            color: MColors.mc_start,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: MColors.mc_start,
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
        ),
      ),
    );
  }
  double _sigmaX = 2.0; // from 0-10
  double _sigmaY = 2.0; // from 0-10
  double _opacity = 0.4;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
         /* Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: MColors.black,
            ),
          ),*/
          Container(
              height: double.infinity,
              width: double.infinity,
              child:
              Image.asset('assets/images/welcome_background.jpeg',fit: BoxFit.cover,)
          ),
          Container(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
              child: Container(
                color: Colors.black.withOpacity(_opacity),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.transparent,
                  Colors.black
                ],
              ),
            ),
          ),
          Container(
            padding: new EdgeInsets.all(10.0),
            height: double.infinity,
            width: double.infinity,
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Center(
                  child: Text(
                    'invEat',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 15.0,),
                Center(

                  child:
                  Text(
                    "If you've ever snapped a picture of your dinner, invEat is for you. ",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 50.0,),
                _buildContinueButton(),

              ],
            ),
          ),

        ],
      ),
    );
  }
}