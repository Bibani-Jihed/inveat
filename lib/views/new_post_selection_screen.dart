import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inveat/data/place_service.dart' as PlaceService;
import 'package:inveat/models/address_post.dart';
import 'package:inveat/models/file_model.dart';
import 'package:inveat/utilities/constants/colors.dart';
import 'package:storage_path/storage_path.dart';
import 'package:inveat/data/post_service.dart' as PostService;
import 'package:toast/toast.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


class PostSelection extends StatefulWidget {
  PostSelection({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PostSelectionState createState() => _PostSelectionState();
}

class _PostSelectionState extends State<PostSelection> {
  List<FileModel> files;
  FileModel selectedModel;
  String image;
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

  void SharePost() async {
    print(_address.toJson());
    print(_caption);
    print(_title);
    if(_caption==null||_caption.isEmpty){
      setState(() {
        isCaptionError=true;
      });
    }
    if(_title==null||_title.isEmpty){
      setState(() {
        isTitleError=true;
      });
    }
    else {
      EasyLoading.show(status: 'loading...');
      print(_address.toJson());
      Map<String, dynamic> form = {
        'content': _caption,
        'title': _title,
        'type': 'image',
        'address':_address.toJson(),
      };

      final post_res = await PostService.AddPost(File(image), form);
      EasyLoading.dismiss();
      if(post_res!=null){
        Navigator.pop(context);
      }else{
        Toast.show("error occurred, please try again", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
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
    getImagesPath();
    currentIndex = 0;
    captionLength = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  Future<Address>_getAddress() async{
    final tmp=await PlaceService.GetAddress();
    setState((){
      _address=tmp;
    });
    if(_address!=null){
      setState(() {
        isAddressLoaded=true;
      });
    }
    return _address;
  }
  Future<File> CompressAndGetFile(File file, String targetPath) async {
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 20,
    );

    print(file.lengthSync());
    print(result?.lengthSync());

    return result;
  }

  getImagesPath() async {
    var imagePath = await StoragePath.imagesPath;
    var images = jsonDecode(imagePath) as List;

    files = images.map<FileModel>((e) => FileModel.fromJson(e)).toList();

    if (files != null && files.length > 0)
      setState(() {
        selectedModel = files[0];
        image = files[0].files[0];
      });
  }

  Widget _buildImagePicker() {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.clear),
                    color: Colors.white,
                    iconSize: 25.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10),
                  DropdownButtonHideUnderline(
                      child: DropdownButton<FileModel>(
                    dropdownColor: MColors.black,
                    items: getItems(),
                    onChanged: (FileModel d) {
                      assert(d.files.length > 0);
                      image = d.files[0];
                      setState(() {
                        selectedModel = d;
                      });
                    },
                    value: selectedModel,
                  ))
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    child: Text(
                      'Next',
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        changePage(1);
                        _controller.animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);
                      });
                    },
                  ))
            ],
          ),
          Divider(),
          Container(
              height: MediaQuery.of(context).size.height * 0.45,
              child: image != null
                  ? Image.file(File(image),
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width)
                  : Container()),
          Divider(),

          selectedModel == null
              ? Container()
              : Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4),
                      itemBuilder: (_, i) {
                        var file = selectedModel.files[i];
                        return GestureDetector(
                          child: Image.file(
                            File(file),
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            setState(() {
                              image = file;
                            });
                          },
                        );
                      },
                      itemCount: selectedModel.files.length),
                )
        ],
      ),
    );
  }

  Widget _buildPostInfo() {
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
                  setState(() {
                    changePage(0);
                    _controller.animateToPage(0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  });
                },
                color: Colors.white,
              ),
              Text(
                "Back",
                textAlign: TextAlign.start,
                style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
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
                      SharePost();
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
                              child: image!=null?Image.file(File(image), fit: BoxFit.cover):null,
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
                          child: FutureBuilder<Address>(
                            future: _getAddress(),
                            builder: (context,snapshot){
                              return Text(
                                snapshot.data!=null?snapshot.data.city+","+snapshot.data.governerate+","+snapshot.data.country:"loading...",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              );
                            },
                          )


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
                _buildImagePicker(),
                _buildPostInfo(),
              ])
        ]),
      ),
    );
  }

  List<DropdownMenuItem> getItems() {
    try {
      return files
          .map((e) =>
          DropdownMenuItem(
            child: Text(
              e.folder,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            value: e,
          ))
          .toList() ??
          [];
    }catch(e){

    }
  }
}
