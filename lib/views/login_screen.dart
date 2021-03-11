import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file:///C:/Users/ASUS/AndroidStudioProjects/inveat/lib/utilities/constants/colors.dart' as mColors;
import 'package:inveat/utilities/constants/strings.dart' as Strings;
import 'package:inveat/views/signup_screen.dart';
import 'package:inveat/views/welcome_screen.dart';

import 'navigation.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<Login> {
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
                color: mColors.mc_end,// set border color
                width: 2.0),   // set border width
            borderRadius: BorderRadius.all(
                Radius.circular(20.0)), // set rounded corner radius
          ),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.white,
            style: GoogleFonts.nunito(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 14.0),
              hintText: 'Email or username',
              hintStyle: GoogleFonts.nunito(
                color: Colors.white70
              ),
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
                color: mColors.mc_end,// set border color
                width: 2.0),   // set border width
            borderRadius: BorderRadius.all(
                Radius.circular(20.0)), // set rounded corner radius
          ),
          child: TextField(
            obscureText: true,
            cursorColor: Colors.white,
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
  Widget _buildSigninButton() {
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
          'SIGN IN',
          style: GoogleFonts.nunito(
            color: mColors.black,
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
  /********** Building View ***********/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:<Widget> [
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
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Image.asset("assets/images/back.png"),
                      iconSize: 30.0,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                  ),
                  SizedBox(height: 50.0),
                  Text(
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
                  SizedBox(height: 80.0),
                  _buildEmailTF(),
                  SizedBox(height: 8.0),
                  _buildPasswordTF(),
                  SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Forget password?",
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )

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
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: GoogleFonts.nunito(
                            color: Colors.white70,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8.00,),
                        TextButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Signup()),
                              );
                            },
                            child:
                            Text(
                              'Register',
                              style:GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 5.00,),
                  _buildSigninButton(),
                ],
            ),

          ),
        ],
      ),
    );
  }

}