import 'dart:async';
import 'package:redJAY/components/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redJAY/screens/home_page/projects.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => OnboardState();
}

class OnboardState extends State<Onboard> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late StreamSubscription subscription;
  late StreamSubscription internetSubscription;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      checkLogin();
    //  Navigator.pushReplacementNamed(context, "/main_tab_bar");
      //checkLogin();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  bgGray,
      body:
      SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:
        Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 210.sp,child:
              Image.asset("assets/images/jay2.png", fit: BoxFit.fitWidth)),
              Text("Welcome to future by",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  )),
              SizedBox(height: 15,),
              Text("RedJay",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: bgbuttonRed,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ))
            ]),
        ),
      ),

      // SizedBox(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child:
      //   Image.asset("assets/images/bglang.png", fit: BoxFit.fill),
      // )
    );
  }

  checkLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    if(token!=null&&token.trim().length>0){
     Navigator.pushNamed(context,"/main_tab_bar");
     //Navigator.pushNamed(context,"/login");
     // Navigator.pushNamed(context,"/option2");
    }
    else
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>Projects()//Language()//Signup()//Login()//Language()// Login()//Home2(),
      ),
    );

  }

  navigationToHome(){
    if(mounted) {

      Navigator.pushReplacementNamed(context, "/main_tab_bar");
    }
  }

}
