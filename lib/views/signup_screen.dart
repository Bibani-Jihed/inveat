import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inveat/data/user_service.dart' as UserService;
import 'package:inveat/data/post_service.dart' as PostService;
import 'package:inveat/utilities/constants/colors.dart';
import 'package:inveat/views/login_screen.dart';
import 'navigation_screen.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email;
  String password;
  String confirm_password;
  String first_name="jihed";
  String last_name="bibani";
  String phone="23706542";
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
    _confirmPasswordVisible=false;
  }
  void Signup() async{
    EasyLoading.show(status: 'loading...');
    final Map<String, String> form = {'email':email,'password':password,'first_name':first_name,'last_name':last_name,'phone':phone};
    final res_code=await UserService.Signup(form);
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
            color: MColors.black,
            border: Border.all(
                color: MColors.mc_end, // set border color
                width: 2.0), // set border width
            borderRadius: BorderRadius.all(
                Radius.circular(20.0)),
            // set rounded corner radius
          ),
          child: TextField(
            onChanged: (text){
              email=text;
            },
            keyboardType: TextInputType.emailAddress,
            style: GoogleFonts.nunito(
              color: Colors.white, fontWeight: FontWeight.w700
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 30.0),
              hintText: 'Enter your Email',
              hintStyle: GoogleFonts.nunito(
                  color: Colors.white70,
              fontWeight: FontWeight.w700),
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
            color: MColors.black,
            border: Border.all(
                color: MColors.mc_end, // set border color
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
  Widget _buildConfirmPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 75.0,
          decoration: BoxDecoration(
            color: MColors.black,
            border: Border.all(
                color: MColors.mc_end, // set border color
                width: 2.0), // set border width
            borderRadius: BorderRadius.all(
                Radius.circular(20.0)), // set rounded corner radius
          ),
          child: TextField(
            onChanged: (text){
              confirm_password=text;
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
                  _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
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
  Widget _buildSignupButton() {
    return SizedBox(
      width: double.infinity,
      height: 70.0,
      child: ElevatedButton(
        onPressed: (){
          Signup();

        },
        child: Text(
          'SIGN UP',
          style: GoogleFonts.nunito(
            color: MColors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: MColors.mc_start,
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
      body: new GestureDetector(
        onTap: () {

          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child:  Stack(
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
                        children: [
                          Text(
                            "Join the community?",
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),//Lets Sign
                          Text(
                            "Create your account first",
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
                              fit: BoxFit.fitHeight,
                            ),
                          )
                              :Container(
                            decoration: BoxDecoration(
                                color: MColors.black,
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
                    SizedBox(height: 40.0),
                    _buildSignupButton(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an Account?',
                            style: GoogleFonts.nunito(
                              color: Colors.white70,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                              onPressed: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Login()),
                                );
                              },
                              child:
                              Text(
                                'Log in',
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
                  ],
                ),
              ),
            ),

          ],
        ),
      )


    );
  }
}
