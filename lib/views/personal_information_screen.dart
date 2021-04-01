import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inveat/models/user_model.dart';
import 'package:inveat/utilities/constants/colors.dart';
import 'package:inveat/data/user_service.dart' as UserService;
import 'package:inveat/utilities/constants/api.dart' as api;



class PersonalInfoScreen extends StatefulWidget {
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfoScreen> {
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

  String firstname;
  String lastname;
  String phone;
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _image=null;
    firstname=null;
    lastname=null;
    phone=null;
  }
  @override
  void dispose() {
    _image=null;
    firstname=null;
    lastname=null;
    phone=null;
    super.dispose();
  }

  void Update() async{
    EasyLoading.show(status: 'loading...');
    final form = <String, String>{};
    if(firstname!=null && firstname.isNotEmpty)
      form["first_name"]=firstname;
    if(lastname!=null && lastname.isNotEmpty)
      form["last_name"]=lastname;
    if(phone!=null && phone.isNotEmpty)
      form["phone"]=phone;

    int update_info_code;
    int update_image_code;
    if(form.isNotEmpty){
      update_info_code=await UserService.UpdateUser(form);
      print("update_info_code: "+update_info_code.toString());
    }
    if(_image!=null){
      update_image_code= await UserService.UploadUserImage(_image);
      print("update_image_code: "+update_image_code.toString());
    }
    EasyLoading.dismiss();
    if(update_info_code==201 && update_image_code==200){
      Navigator.pop(context);
    }
    if(update_info_code==201 && update_image_code==null){
      Navigator.pop(context);
    }
    if(update_image_code==200 && update_info_code==null){
      Navigator.pop(context);
    }
  }

  Future<User>initUser()async{
    final user=await UserService.GetCurrentUser();
    lastnameController.text=user.last_name;
    firstnameController.text=user.first_name;
    phoneController.text=user.phone;
    return user;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: initUser(),
        builder: (context,snapshot){
          return Scaffold(
              body: new GestureDetector(
                  onTap: (){
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: SingleChildScrollView(
                    child:Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: MColors.black,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 150.0,left: 20.0,right: 20.0),
                            child: Column(
                              children: [
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      getImage();
                                    },
                                    child:
                                    CircleAvatar(
                                      radius: 40.0,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 12.0,
                                            child: Icon(
                                              Icons.camera_alt,
                                              size: 15.0,
                                              color: Color(0xFF404040),
                                            ),
                                          ),
                                        ),
                                        radius: 38.0,
                                        backgroundImage: _image!=null? FileImage(_image,
                                          )
                                        :NetworkImage(api.BASE_URL+snapshot.data.image_user.url),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40.0,),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: MColors.black,
                                    border: Border.all(
                                        color: MColors.mc_end, // set border color
                                        width: 2.0), // set border width
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    // set rounded corner radius
                                  ),
                                  child: TextField(
                                    controller: firstnameController,
                                    onChanged: (text){
                                      firstname=text;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    style: GoogleFonts.nunito(
                                        color: Colors.white, fontWeight: FontWeight.w700),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                                      hintText: 'Enter your Firstname',
                                      hintStyle: GoogleFonts.nunito(
                                          color: Colors.white70, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: MColors.black,
                                    border: Border.all(
                                        color: MColors.mc_end, // set border color
                                        width: 2.0), // set border width
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    // set rounded corner radius
                                  ),
                                  child: TextField(
                                    controller: lastnameController,
                                    onChanged: (text){
                                      lastname=text;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    style: GoogleFonts.nunito(
                                        color: Colors.white, fontWeight: FontWeight.w700),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                                      hintText: 'Enter your Lastname',
                                      hintStyle: GoogleFonts.nunito(
                                          color: Colors.white70, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: MColors.black,
                                    border: Border.all(
                                        color: MColors.mc_end, // set border color
                                        width: 2.0), // set border width
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    // set rounded corner radius
                                  ),
                                  child: TextField(
                                    controller: phoneController,
                                    onChanged: (text){
                                      phone=text;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    style: GoogleFonts.nunito(
                                        color: Colors.white, fontWeight: FontWeight.w700),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                                      hintText: 'Enter your Phone',
                                      hintStyle: GoogleFonts.nunito(
                                          color: Colors.white70, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40.0,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 60.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Update();
                                    },
                                    child: Text(
                                      'Save',
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
                                          borderRadius: new BorderRadius.circular(20.0)),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Colors.white,
                              ),
                              Text(
                                "Personal Information",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ) ,
                  )
              )
          );
    });

  }
}
