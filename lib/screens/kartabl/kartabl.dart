import 'dart:async';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Kartabl extends StatefulWidget {
  const Kartabl({Key? key}) : super(key: key);

  @override
  State<Kartabl> createState() => KartablState();
}

class KartablState extends State<Kartabl> {
  bool showYellowBirdlogo=false;
  bool isClickBird=false;
  String title="Yellowjay server";
  Color bgcolor=bgYellow;
  ScrollController? scrollController;
  bool pageLoading = true;
  String companyName="";
  TextEditingController? _emailController;
  TextEditingController? _refController;
  String companyLogo="";
  String balance="";
  getWallet()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    if(email!=null&&email.trim().length>0){
     // var response = await (Services()).getWallet(_emailController!.text,);
      var response = await (Services()).getWallet(email);
      setState(() {
        balance = response["result"]['balance'];
      });

    }
  }
  checkEmail()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    if(email!=null&&email.trim().length>0){
      // var response = await (Services()).getWallet(_emailController!.text,);
      var response = await (Services()).checkEmail(email,"1");
      String j="";
     
      if( response['message']!=null &&  response['message']!.trim().length>1 && response['message']!.toString().contains("success")) {
        customNotification(false, "update done Successfully", MediaQuery
            .of(context)
            .size
            .width, MediaQuery
            .of(context)
            .size
            .height);
      }
        // setState(() {
      //   balance = response["result"]['balance'];
      // });

    }
  }
  @override
  initState()  {

    super.initState();
    getWallet();
    _emailController= TextEditingController(text: "");
    if(mounted){
      //  new Timer.periodic(const Duration(minutes: 1), (Timer t) => setState((){}));
      // getPersonelTraffic();
      //  getPersonelTrafficOffline();
    }
  }

bool selected=false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  bgbuttonRed, //Colors.white,//backgroundColor,
        body:Form(
            key: _formKey,child:
        Stack(
            alignment: Alignment.center,
            children: [


            ]))
    );



  }

}

