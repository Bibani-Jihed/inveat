import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/lib/utilities/constants/colors.dart' as mColors;
import 'package:lottie/lottie.dart';
import 'package:inveat/utilities/helpers/email_validator.dart' as Validator;
import 'package:inveat/data/user_service.dart' as UserService;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toast/toast.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool _passwordVisible = false;
  bool isPasswordError=false;
  bool isConfirmPasswordError=false;
  String password;
  bool _confirmPasswordVisible = false;
  String confirm_password;

  bool isFieldError = false;
  bool isCodeError = false;
  String email = '';
  String codeFieldValue = '';
  String code;
  PageController _controller = PageController(
    initialPage: 0,
  );

  void animatedToIndex(int index) {
    _controller.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  void Send() async {
    EasyLoading.show(status: 'loading...');
    final Map<String, String> form = {
      'email': email,
    };
    final res_body = await UserService.SendVerificationCode(form);
    Map<String, dynamic> responseJson = json.decode(res_body);
    EasyLoading.dismiss();
    setState(() {
      isFieldError = false;
    });
    if (responseJson["code"].toString() == "400") {
      setState(() {
        isFieldError = true;
      });
      Toast.show("Account not found", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      code = responseJson["code"].toString();
      animatedToIndex(1);
    }
  }
  void Verify() {
    if (code != codeFieldValue) {
      setState(() {
        isCodeError = true;
      });
    } else {
      animatedToIndex(2);
    }
  }
  void Reset() async {
    EasyLoading.show(status: 'loading...');
    final Map<String, String> form = {
      'email': email,
      'password':password
    };
    int res_code = await UserService.ResetPassword(form);
    EasyLoading.dismiss();
    if (res_code==201) {
      Toast.show("Password succefully modified, please login to continue..", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.pop(context);
    } else {
      Toast.show("An error has occured, please try again", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  /********** Building Forget Password Widgets ***********/
  Widget _buildFPEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 75.0,
          decoration: BoxDecoration(
            color: mColors.black,
            border: Border.all(
                color: isFieldError ? Colors.red : mColors.mc_end,
                // set border color
                width: 2.0), // set border width
            borderRadius: BorderRadius.all(
                Radius.circular(20.0)), // set rounded corner radius
          ),
          child: TextField(
            onChanged: (text) {
              email = text;
              setState(() {
                isFieldError = !Validator.isValid(text);
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
  Widget _buildSendButton() {
    return SizedBox(
      width: double.infinity,
      height: 70.0,
      child: ElevatedButton(
        onPressed: () {
          if (email == null || !Validator.isValid(email)) {
            print(Validator.isValid(email) == false);
            setState(() {
              isFieldError = true;
            });
            return;
          }
          Send();
        },
        child: Text(
          'SEND',
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
  Widget _buildVerifyButton() {
    return SizedBox(
      width: double.infinity,
      height: 70.0,
      child: ElevatedButton(
        onPressed: () {

          Verify();
        },
        child: Text(
          'VERIFY',
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
  Widget _buildResetButton() {
    return SizedBox(
      width: double.infinity,
      height: 70.0,
      child: ElevatedButton(
        onPressed: () {
          Reset();
          Verify();
        },
        child: Text(
          'RESET',
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

            onChanged: (text) {
              setState(() {
                isPasswordError=false;
              });
              password = text;
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
              hintText: 'Enter your new Password',
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
                color: isConfirmPasswordError? Colors.red:mColors.mc_end, // set border color
                // set border color
                width: 2.0), // set border width
            borderRadius: BorderRadius.all(
                Radius.circular(20.0)), // set rounded corner radius
          ),
          child: TextField(
            onChanged: (text) {
              setState(() {
                isConfirmPasswordError=false;
              });
              confirm_password = text;
            },
            obscureText: !_confirmPasswordVisible,
            cursorColor: Colors.white,
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 30.0, top: 12.5),
              hintText: 'Confirm your Password',
              hintStyle: GoogleFonts.nunito(
                color: Colors.white70,
                fontWeight: FontWeight.w700,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _confirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
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

  /********** Building Forget Password Widgets ***********/
  Widget _buildForgetPasswordView() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 35.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white.withOpacity(0.4),
            ),
            SizedBox(height: 50.0),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Forget your Password?",
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ), //Lets Sign
                  Text(
                    "Enter your registred email bellow to receive password reset instruction",
                    style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ), //Welcome
                ],
              ),
            ), //You've been Missed
            SizedBox(height: 30.0),
            Lottie.asset(
              'assets/jsons/send_email.json',
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 30.0),
            _buildFPEmailTF(),
            SizedBox(height: 80.0),
            _buildSendButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildResetPasswordView() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 35.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white.withOpacity(0.4),
            ),
            SizedBox(height: 50.0),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create new Password!",
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ), //Lets Sign
                  Text(
                    "Your new Password must be different from previous used passwords",
                    style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ), //Welcome
                ],
              ),
            ),
            SizedBox(height: 30.0),
            _buildPasswordTF(),
            SizedBox(height: 8.0),
            _buildConfirmPasswordTF(),
            SizedBox(height: 120.0),
            _buildResetButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEnterCodeView() {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 35.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
                size: 35,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white.withOpacity(0.4),
            ),
            SizedBox(height: 50.0),
            Container(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email has been sent!",
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ), //Lets Sign
                  Text(
                    "Please check your inbox and copy the received code to reset your password",
                    style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ), //Welcome
                ],
              ),
            ), //You've been Missed
            SizedBox(height: 30.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 80.0),
              child: PinCodeTextField(
                appContext: context,
                textStyle: GoogleFonts.nunito(
                    color: Colors.white, fontWeight: FontWeight.w700),
                length: 8,
                cursorColor: Colors.white,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  fieldHeight: 40,
                  fieldWidth: 30,
                  inactiveColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedColor: Colors.white,
                  selectedFillColor: Colors.white,
                  activeColor: isCodeError ? Colors.red : Colors.white,
                ),
                onChanged: (value) {
                  codeFieldValue = value;
                  setState(() {
                    isCodeError = false;
                  });
                },
                onCompleted: (value) {
                  if (code != value) {
                    setState(() {
                      isCodeError = true;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 80.0),

            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: GoogleFonts.nunito(
                      color: Colors.white70,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    ' RESEND',
                    style: GoogleFonts.nunito(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              onTap: () {
                email=null;
                animatedToIndex(0);
              },
            ),
            SizedBox(height: 8.0),
            _buildVerifyButton(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: new GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: mColors.black,
                  ),
                ),
                PageView(
                  physics: new NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: [
                    _buildForgetPasswordView(),
                    _buildEnterCodeView(),
                    _buildResetPasswordView()
                  ],
                )
              ],
            )));
  }
}
