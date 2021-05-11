import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/data/place_service.dart' as PlaceService;
import 'package:inveat/models/address_post.dart';
import 'package:inveat/models/file_model.dart';
import 'package:inveat/utilities/constants/colors.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:storage_path/storage_path.dart';
import 'package:inveat/data/post_service.dart' as PostService;
import 'package:toast/toast.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'login_screen.dart';


class PostSelection extends StatefulWidget {
  final VoidCallback  callback;
  List<String> files;
  PostSelection({this.callback,this.files});


  @override
  _PostSelectionState createState() => _PostSelectionState();
}

class _PostSelectionState extends State<PostSelection> {
  int currentIndex;
  int captionLength;
  PageController _controller = PageController(
    initialPage: 0,
  );
  String _caption;
  String _title;
  Address _address;

  bool isTitleError=false;
  bool isCaptionError=false;
  bool isAddressLoaded=false;
  int items_number=12;


  void SharePost(files) async {


      print(_address.toJson());
      print(_caption);
      print(_title);
      if (_caption == null || _caption.isEmpty) {
        setState(() {
          isCaptionError = true;
        });
      }
      if (_title == null || _title.isEmpty) {
        setState(() {
          isTitleError = true;
        });
      }
      else {
        EasyLoading.show(status: 'loading...');
        print(_address.toJson());
        Map<String, dynamic> form = {
          'content': _caption,
          'title': _title,
          'type': 'image',
          'address': _address.toJson(),
        };

        final post_res =await PostService.AddPost(files, form);
        EasyLoading.dismiss();

        if (post_res == -1) {
          Alert(
            context: context,
            type: AlertType.warning,
            title: "Session expired",
            style: AlertStyle(
              isOverlayTapDismiss: false,
              descStyle: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
              descTextAlign: TextAlign.start,
              animationDuration: Duration(milliseconds: 400),
              backgroundColor: Colors.black,
              alertBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Colors.black,
                ),
              ),
              titleStyle: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
              alertAlignment: Alignment.center,
            ),
            desc: "Please login to continue...",
            buttons: [
              DialogButton(
                child: Text(
                  "Go",
                  style: GoogleFonts.nunito(
                    color: Colors.yellow,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) =>
                          Login()), (Route<dynamic> route) => false);
                },
                color: Colors.black,
              ),

            ],
          ).show();
        }
        else if (post_res != null) {
          widget.callback();
          //Navigator.pop(context);
        } else {
          Toast.show("error occurred, please try again", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }

    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getAddress();
    currentIndex = 0;
    captionLength = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }



  Future<Address>_getAddress() async{
    if(_address==null) {
      final tmp = await PlaceService.GetAddress();
    setState(() {
    _address=tmp;
    });
      if (_address != null) {
        setState(() {
          isAddressLoaded = true;
        });
      }
    }
    return _address;
  }


  Widget _buildPostInfo() {
    print("length fies: "+widget.files.length.toString());
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.only(top: 24.0),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
              ),
              Spacer(),
              TextButton(
                child: Text(
                  'Share',
                  style: GoogleFonts.nunito(
                    color: isAddressLoaded?Colors.white:Colors.white.withOpacity(0.1),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  if(isAddressLoaded)
                    {
                      SharePost(widget.files);

                    }
                },
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: widget.files.isNotEmpty?Image.file(File(widget.files[widget.files.length-1]), fit: BoxFit.cover):null,
                            ),
                          ),
                          Spacer(),
                          Expanded(flex:6,child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              color: MColors.black,
                              border: Border.all(
                                  color: isCaptionError?Colors.red:MColors.mc_end, // set border color
                                  width: 2.0), // set border width
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20.0)), // set rounded corner radius
                            ),
                            child: TextField(
                              onChanged: (text) {

                                setState(() {
                                  captionLength = text.length;
                                });
                                _caption = text;
                                isCaptionError=false;

                              },
                              maxLines: null,
                              maxLength: 350,
                              keyboardType: TextInputType.multiline,
                              cursorColor: Colors.white,
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 10.0,
                                ),
                                hintText: 'Write a caption..',
                                hintStyle: GoogleFonts.nunito(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Text(
                            captionLength.toString() + "/350",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white.withOpacity(0.1),
                ),
                Container(
                  height: 60.0,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Icon(
                                Icons.short_text,
                                color: Colors.white,
                              ),
                              Text(
                                "Title",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )),
                      Expanded(
                        flex: 6,
                        child: Container(
                          width: 240,
                          decoration: BoxDecoration(
                            color: MColors.black,
                            border: Border.all(
                                color: isTitleError?Colors.red:MColors.mc_end, // set border color
                                width: 2.0), // set border width
                            borderRadius: BorderRadius.all(Radius.circular(
                                20.0)), // set rounded corner radius
                          ),
                          child: TextField(
                            onChanged: (text) {
                              _title = text;
                              isTitleError=false;
                            },
                            maxLength: 30,
                            cursorColor: Colors.white,
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 10.0,
                              ),
                              hintText: 'title..',
                              hintStyle: GoogleFonts.nunito(
                                color: Colors.white70,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white.withOpacity(0.1),
                ),
                Container(
                  height: 60.0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                            ),
                            Text(
                              "Location",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 6,
                          child: Text(
                            _address!=null?_address.city+","+_address.governerate+","+_address.country:"loading...",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),


                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.white.withOpacity(0.1),
                ),
                Wrap(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(

                                  Icons.tag,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Hashtags",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                          flex: 6,
                          child: Text(
                            "#food #foodie #instafood #foodphotography #foodstagram #yummy #instagood #love #foodlover #like #delicious #homemade #healthyfood",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.nunito(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.white.withOpacity(0.1),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: MColors.black,
            ),
          ),
         PageView(
              controller: _controller,
              onPageChanged: (index) {
                changePage(index);
              },
              physics: new NeverScrollableScrollPhysics(),
              children: <Widget>[
                _buildPostInfo(),
                //_buildImagePicker(),
              ])
        ]),
      ),
    );
  }

}
