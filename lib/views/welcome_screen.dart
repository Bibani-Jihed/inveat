import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inveat/views/login_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/constants/colors.dart' as mColors;
import 'package:inveat/utilities/constants/strings.dart' as Strings;

class Welcome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 70.0,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
        child: Text(
          'CONTINUE',
          style: GoogleFonts.nunito(
            color: mColors.mc_start,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: mColors.mc_start,
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
        ),
      ),
    );
  }

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
            padding: EdgeInsets.all(60.0),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Lottie.asset('assets/jsons/food.json'),
                SizedBox(height: 30.0,),
                Align(
                  alignment: Alignment.center,
                    child:
                    Text(
                      'Lorem ipsum dolor sit amet',
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900,
                      ),
                )
                ),
                SizedBox(height: 15.0,),

                Align(
                  alignment: Alignment.center,
                  child:
                  Text(
                  'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium',
                  style: GoogleFonts.nunito(
                    color: Colors.white70,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                )
            ],
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
                _buildContinueButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}