import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inveat/data/user_service.dart';
import 'package:inveat/views/navigation_screen.dart';
import 'package:inveat/views/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inveat/data/user_service.dart' as UserService;
import 'models/user_model.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
          home:   FutureBuilder(
            future: hasAlreadySigned(),
            builder: (context,snapshot){
              if (snapshot.data==null)
                return Welcome();
                return snapshot.data? Navigation():Welcome();
            },
          ),
          builder: EasyLoading.init(),
    );
  }

  Future<bool> hasAlreadySigned() async {
    final user=await UserService.GetCurrentUser();
    try {
      if (user.first_name != null) {
        return true;
      }
    }catch(e){

    }
    return false;
  }
}

