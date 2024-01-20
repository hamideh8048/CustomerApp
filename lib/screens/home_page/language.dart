
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/LangModel.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;
class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);
  @override
  State<Language> createState() => LanguageState();
}

class LanguageState extends State<Language> {
  String _chosenValue="es";
bool showYellowBirdlogo=false;
bool isClickBird=false;
String title="Yellowjay server";
Color bgcolor=bgYellow;
  ScrollController? scrollController;
  bool pageLoading = true;
  String companyName="";
  List<LangModel>langList = [];
  String companyLogo="";
  List<DropdownMenuItem<String>> dropdownItems = [];
  @override
  initState()  {
    super.initState();
    if(mounted){
      getLang();
    }
  }

  getLang()
  async {

    var response = await (Services()).getLang();

    if (response['statusCode'] != null&&response['statusCode']==200)
      response["data"].forEach((element){
        langList .add(LangModel.fromJson(element));
      });
    for (LangModel lang in langList) {
      var newItem = DropdownMenuItem(
        child: Text(lang.label,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
        value: lang.title,
      );
      dropdownItems.add(newItem);
    }
    setState(() {

    });
  }
final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor:  bglightRed, //Colors.white,//backgroundColor,
        body:Form(
        key: _formKey,child:
        Stack(
            alignment: Alignment.center,
            children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:
                Image.asset("assets/images/bglang.png", fit: BoxFit.fill),
              ),

         SizedBox(
                height: MediaQuery.of(context).size.height*.72,
                width: MediaQuery.of(context).size.width*0.81,
                child:
              //   Image.asset("assets/images/boxframe.png", fit: BoxFit.fill,color:Colors.white54,),
              // ),
              // Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*.05),child:
              // SizedBox(
              //   height: MediaQuery.of(context).size.height*.42,
              //   width: MediaQuery.of(context).size.width*0.66,
              //   child:
              //   Image.asset("assets/images/boxframe.png", fit: BoxFit.fill),
              // )),
        Container(

            decoration: BoxDecoration(
              //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                color: Colors.white54,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
               bottomLeft: Radius.circular(30.0)),
            ),

            child:
                Center(child:
            SizedBox(
              height: MediaQuery.of(context).size.height*.42,
              width: MediaQuery.of(context).size.width*0.66,
              child:
              Container(

                  decoration: BoxDecoration(
                    //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                    color:   greyLangColor,//Colors.white60,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                  ),child:
               Column(
          //  crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Text("Please slect language",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
            SizedBox(height: 10,),
        DropdownButton<String>(
            items: dropdownItems,
          dropdownColor: bgGray,
          value: _chosenValue,
          // hint: Text("select language"),
          onChanged: (String? value) {
            setState(() {
              _chosenValue = value!;
            });
          },
        ),
                  Padding(padding: EdgeInsets.only(top:100.sp),child:
                  GestureDetector(child:
            Container(
              width: 130,
              padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.sp),
                  color: Colors.white//.withOpacity(0.1)
              ),
              child:Center(child: Text('Next',
                style: const TextStyle(
                  fontFamily: 'DM Sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 16 ,
                  color:bgbuttonRed ,
                  //  fontWeight: FontWeight.bold,
                ),
              )),
            ),onTap:() {

                  //   storeLang(_chosenValue);
                  // Navigator.pushNamed(context,"/login");
                  },
                  ),
                  ),
            ])))))),
              Padding(padding: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*.52),child:(
                  Image.asset("assets/images/welcom.png", fit: BoxFit.fill,width: 150,))),
            ])
    ));



  }
  void storeLang(String langId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lang_id", langId);
    // getUserInfo(tokenResult);
  }
}
