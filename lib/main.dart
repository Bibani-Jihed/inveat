import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:inveat/data/user_service.dart';
import 'package:inveat/views/navigation_screen.dart';
import 'package:inveat/views/welcome_screen.dart';
import 'package:provider/provider.dart';


dynamic id;

Future<void> main() async {
  runApp(MyApp());
  configLoading();
  id= await FlutterSession().get("id");
  print('id'+id.toString());
}
void configLoading() {
  EasyLoading.instance
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
          title: 'Inveat',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
           primarySwatch: Colors.blue,
          ),
          home: id!=null ?Navigation():Welcome(),
          builder: EasyLoading.init(),
    );
  }
}
