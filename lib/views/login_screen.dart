import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/lib/utilities/constants/colors.dart'
    as mColors;
import 'package:inveat/utilities/constants/strings.dart' as Strings;
import 'package:inveat/views/forget_password.dart';
import 'package:inveat/views/signup_screen.dart';
import 'package:inveat/views/widgets/complete_profile_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';
import 'navigation_screen.dart';
import 'package:inveat/data/user_service.dart' as UserService;
import 'package:inveat/utilities/helpers/email_validator.dart' as Validator;


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email='';
  String password='';
  bool _passwordVisible = false;
  bool isFieldError=false;
  bool isPasswordError=false;
  final TextEditingController controller = TextEditingController();
  LiquidController liquidController;
  int page = 0;




  @override
  void initState() {
    _passwordVisible = false;
    liquidController = LiquidController();
  }
  void Login() async{

    EasyLoading.show(status: 'loading...');
    final Map<String, String> form = {'email':email,'password':password,};
    final res_code=await UserService.Login(form);
    EasyLoading.dismiss();
    if(res_code==200){
      final user=await UserService.GetCurrentUser();
      print(user.first_name);
      if(user.first_name==null){
        liquidController.animateToPage(
            page: liquidController.currentPage + 1, duration: 600);
      }
      else {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            Navigation()), (Route<dynamic> route) => false);
      }
    }
    else{
      setState(() {
        isFieldError=true;
      });
      Toast.show("Incorrect email or password", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    }
  }
  /********** Building Widgets ***********/
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
                color: isFieldError? Colors.red: mColors.mc_end, // set border color
                width: 2.0), // set border width
            borderRadius: BorderRadius.all(
                Radius.circular(20.0)), // set rounded corner radius
          ),
          child: TextField(
            onChanged: (text){
              email=text;
              setState(() {
                isFieldError=!Validator.isValid(text);
              });
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
                color: isPasswordError? Colors.red:mColors.mc_end, // set border color
                width: 2.0), // set border width
            borderRadius: BorderRadius.all(
                Radius.circular(20.0)), // set rounded corner radius
          ),
          child: TextField(
            onChanged: (text){
              password=text;
              setState(() {
                isFieldError=false;
                isPasswordError=false;
              });
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

          if(email==null||!Validator.isValid(email)){
            print(Validator.isValid(email)==false);
            setState(() {
              isFieldError=true;
            });
            return;
          }
          if(password==null || password.isEmpty){
            setState(() {
              isPasswordError=true;
            });
            return;
          }
          print("login");
          Login();
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
  /********** Building Widgets ***********/



  /********** Building Login View Pages  ***********/
  Widget _buildMainLoginView(){
    return Container(
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
              child:
              GestureDetector(
                child: Text(
                  "Forget password?",
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgetPassword()),
                  );
                },
              )

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
    );
  }
  /********** Building Login View Pages  ***********/

  /********** Building Main Pager View   ***********/
  Widget _buildLoginView(){
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: mColors.black,
          ),
        ),
        _buildMainLoginView(),
      ],
    );
  }
  Widget _buildAccountInfoView() {
    return CompleteProfile();
  }
  /********** Building Pager View  ***********/

  pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Builder(
          builder: (context) => LiquidSwipe(
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              ignoreUserGestureWhileAnimating: true,
              disableUserGesture: true,
              //onPageChangeCallback: pageChangeCallback,
              pages: [
                _buildLoginView(),
                _buildAccountInfoView(),
              ])),


    ));
  }
}
