
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:redJAY/screens/home_page/Sample.dart';
import 'package:redJAY/screens/home_page/bPlanCreate.dart';
import 'package:redJAY/screens/home_page/bPlanIntroduction.dart';
import 'package:redJAY/screens/home_page/home2.dart';
import 'package:redJAY/screens/home_page/introdution3.dart';
import 'package:redJAY/screens/home_page/language.dart';
import 'package:redJAY/screens/home_page/listTimeline.dart';
import 'package:redJAY/screens/home_page/login.dart';

import 'package:redJAY/screens/home_page/projects.dart';
import 'package:redJAY/screens/home_page/selectCustomer.dart';
import 'package:redJAY/screens/home_page/signup.dart';
import 'package:redJAY/screens/home_page/testtimeline.dart';
import 'package:redJAY/screens/home_page/videoPlayer.dart';
import 'package:redJAY/test_page.dart';
import 'api/firebase_api.dart';
import 'main_tabbar.dart';
import 'screens/kartabl/kartabl.dart';

void main()async {
WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
 await FirebaseApi().initNotifications();
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926), // iphone 13 pro max (926 * 428)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return OverlaySupport.global(
          child: MaterialApp(
            title: 'Jay',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.grey,
            ),

            routes: {
              "/" : (context) =>  testtimeline(),//Sample(),//bPlanIntroduction(),//Sample(),//bPlanIntroduction(),//listTimeline(),// Sample(),//SelectCustomer(),//bPlanCreate(),//listTimeline(),//bPlanCreate(),//testtimeline(),//bPlanCreate(),//listTimeline(),//testtimeline(),//bPlanCreate(),//Sample(), //SelectCustomer(),//Language(),//Sample(),// SelectCustomer(),//Sample(),//VideoPlayerScreen(),//Introduction3(),//PersonalInfo(),//Introduction3(),//PersonalInfo(),//Introduction3(),//PersonalInfo(),//Sample(),//PersonalInfo(),//AddVideo(),//ExtraInfo(),//PersonalInfo(),// VideoPlayerScreen(),//PersonalInfo(), //Onboard(),//PersonalInfo(),//VideoPlayerScreen(),//VideoTest(),//test(),//Onboard(),//Login(),//Projects(),//Introduction3(),//AddVideo(),//Bplan(), //Provider(),//Bplan() ,//Provider(),//Onboard(),//MainTabBar(),//  Onboard(),
              "/main_tab_bar" : (context) => const MainTabBar(),
              "/test_page" : (context) => ExampleApp(),
              "/login" : (context) => const Login(),
              "/home_page" : (context) => const Home2(),
              "/kartabl" : (context) => const Kartabl(),
              "/signup" : (context) => const Signup(),
              "/lang" : (context) => const Language(),
              "/projects" : (context) =>  Projects(),
              "/lang" : (context) =>  Language(),
              "/video" : (context) =>  VideoPlayerScreen(),

             },
          ),
        );
      },
    );
  }
}

