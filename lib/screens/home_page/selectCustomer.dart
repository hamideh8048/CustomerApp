
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/LangModel.dart';
import 'package:redJAY/screens/home_page/PersonalInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'introdution3.dart';
class SelectCustomer extends StatefulWidget {
  const SelectCustomer({Key? key}) : super(key: key);

  @override
  State<SelectCustomer> createState() => SelectCustomerState();
}

class SelectCustomerState extends State<SelectCustomer> {
  String _chosenValue="1";
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

    }
  }

final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor:  bglightRed, //Colors.white,//backgroundColor,
        body:Form(
        key: _formKey,child:
        Stack(
            alignment: Alignment.topRight,
            children: [
            SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
                width: MediaQuery.of(context).size.width,
                child:
                Image.asset("assets/images/customer.png", fit: BoxFit.fill),
              ),
             Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*.5),child:

             SizedBox(
                height: MediaQuery.of(context).size.height*.5,
                width: MediaQuery.of(context).size.width,
                child:
                Image.asset("assets/images/provider.png", fit: BoxFit.fill,),
              )),
              Positioned(
                  top:MediaQuery.of(context).size.width*0.89,
                  left: 115.sp,
                  child:

                  GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  Introduction3()),
                        );
                      },
                      child:
                  Container(
                      height: 40.sp,
                      width: 195.sp,
                      decoration: BoxDecoration(
                          border: Border.all(color: blackColor55) ,
                          //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(18)),
                      child:Center(child:
                        Text("Click",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
                      )
                      ))),
              Positioned(
                  top:MediaQuery.of(context).size.width*1.92,
                  left: 115.sp,
                  child:
                  GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  PersonalInfo()),
                        );
                      },
                      child:
                  Container(
                      height: 40.sp,
                      width: 195.sp,
                      decoration: BoxDecoration(
                          border: Border.all(color: blackColor55) ,
                          //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(18)),
                      child:Center(child:
                      Text("Click",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),

                      ))))
              ]

    )));

  }
  void storeProject(String projectId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("project_id", projectId);
    // getUserInfo(tokenResult);
  }
}
