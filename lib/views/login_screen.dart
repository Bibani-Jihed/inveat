import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/lib/utilities/constants/colors.dart'
    as mColors;
import 'package:inveat/utilities/constants/strings.dart' as Strings;
import 'package:inveat/views/signup_screen.dart';
import 'navigation_screen.dart';
import 'package:inveat/data/user_service.dart' as UserService;


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  bool _passwordVisible = false;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
  }
  void Login() async{
    EasyLoading.show(status: 'loading...');
    final Map<String, String> form = {'email':email,'password':password,};
    final res_code=await UserService.Login(form);
    EasyLoading.dismiss();
    if(res_code==200){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Navigation()),
      );
    }
  }
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
            onChanged: (text){
              email=text;
            },
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.white,
            style: GoogleFonts.nunito(
                color: Colors.white, fontWeight: FontWeight.w700),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 30.0),
              hintText: 'Enter your Email',
              hintStyle: GoogleFonts.nunito(
                  color: Colors.white70, fontWeight: FontWeight.w700),
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
            onChanged: (text){
              password=text;
            },
            obscureText: !_passwordVisible,
            cursorColor: Colors.white,
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 30.0, top: 12.5),
              hintText: 'Enter your Password',
              hintStyle: GoogleFonts.nunito(
                color: Colors.white70,
                fontWeight: FontWeight.w700,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                // Based on passwordVisible state choose the icon
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

          Navigator.pushReplacement(
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
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0)),
        ),
      ),
    );
  }
  /********** Building View ***********/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.LETS_SIGN_YOU_IN,
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ), //Lets Sign
                        Text(
                          Strings.WELCOME_BACK,
                          style: GoogleFonts.nunito(
                            color: Colors.white70,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ), //Welcome
                        Text(
                          Strings.YOUVE_BEEN_MISSED,
                          style: GoogleFonts.nunito(
                            color: Colors.white70,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ), //You've been Missed
                  SizedBox(height: 40.0),
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
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(height: 80.0),
                  _buildSigninButton(),
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
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()),
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w800,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
