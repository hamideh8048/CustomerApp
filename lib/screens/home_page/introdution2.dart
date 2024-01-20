

import 'package:redJAY/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Introduction2 extends StatefulWidget {
  const Introduction2({Key? key}) : super(key: key);

  @override
  State<Introduction2> createState() => Introduction2State();
}

class Introduction2State extends State<Introduction2>

{
bool showYellowBirdlogo=false;
bool isClickBird=false;
String title="Yellowjay server";
Color bgcolor=bgYellow;
  ScrollController? scrollController;
  bool pageLoading = true;
  bool gmailLoading=false;
  String companyName="";
  TextEditingController? _emailController;
  TextEditingController? _refController;
  String companyLogo="";
bool loginLoading=false;
String? imageURL = "https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Instagram_logo_2022.svg/150px-Instagram_logo_2022.svg.png";

String? _chosenValue;
String? _chosenSourceValue;
List<DropdownMenuItem<String>> dropdownItems = [];
bool loading=false;
  bool rememberme=false;
TextEditingController? _ageController=TextEditingController();
TextEditingController? _addressController=TextEditingController();
TextEditingController? _yearController=TextEditingController();
TextEditingController? _phoneController=TextEditingController();
  TextEditingController _usernameCtrl= TextEditingController();
  TextEditingController _passCtrl= TextEditingController();
  TextEditingController _rePassCtrl= TextEditingController();
  bool repasswordVisible=false;
  bool passwordVisible=false;

@override
void dispose() {
  // Clean up the controller when the widget is removed from the widget tree.
  // This also removes the _printLatestValue listener.
  _passCtrl.dispose();
  _rePassCtrl.dispose();
  _usernameCtrl.dispose();
  super.dispose();
}
@override
  initState()  {
    super.initState();
    _emailController= TextEditingController(text: "");
    if(mounted){
    }
  }


final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    // Container(
    //
    //   width: 120,
    //   height: 120,
    //   child:Center(child: Text("English",
    //     style: const TextStyle(
    //     fontFamily: 'DM Sans',
    //     fontWeight: FontWeight.w700,
    //     fontSize: 16 ,
    //     color:   frameColor  ,
    //   )
    //   )),
    //   decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //       color:  greyColor3),
    // ),

    final double circleRadius = 70;
    final circle = Container(
      height: circleRadius * 2.2,
      width: circleRadius * 2.2,
        child:
        Padding(padding: EdgeInsets.only(left: 20,top:60),child:
        Text("English",
          style: const TextStyle(
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w700,
          fontSize: 16 ,
          color:   frameColor  ,
          )
        )),

        decoration: BoxDecoration(
          color:greyColor3,
          borderRadius: BorderRadius.circular(100)  ,
          border: Border.all(
            color:frameColor,
            // width: 15,
            // strokeAlign: align,
          ),
        ));
    return Scaffold(
     // backgroundColor:  bglightRed, //Colors.white,//backgroundColor,
        body:Form(
        key: _formKey,child:
        Stack(
            alignment: Alignment.topCenter,
            children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:
                Image.asset("assets/images/bglang.png", fit: BoxFit.cover),
              ),
            Padding(padding: EdgeInsets.only(
              right:MediaQuery.of(context).size.width*0.2,
              top:MediaQuery.of(context).size.width*0.3,),
    child:
    Container(
    height: 65.sp,
    width: MediaQuery.of(context).size.width*0.8,
    decoration: BoxDecoration(
    //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
    color: Colors.white24,
    borderRadius: BorderRadius.circular(10)),
    child:
    Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
    ]))),
             Padding(padding: EdgeInsets.only(
               right:MediaQuery.of(context).size.width*0.13,top:MediaQuery.of(context).size.width*0.54,),
                child:
                Container(
                    height: MediaQuery.of(context).size.height*0.75,
                    width: MediaQuery.of(context).size.width*0.86,
                    // padding: const EdgeInsets.only(left: 0.0),
                    decoration: BoxDecoration(
                      //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                        color:frameColor,
                        borderRadius: BorderRadius.only(topRight:  Radius.circular(30))),
                    child:
                    new SingleChildScrollView(child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20,),
                           Padding(
                            padding:  EdgeInsets.only(left:10,bottom: 0,right: 20),
                            child:
                            Image.asset("assets/images/migrate1.png",width:MediaQuery.of(context).size.width*0.86, fit: BoxFit.fill),
                        ),
                          Padding(
                            padding:  EdgeInsets.only(top: 80,right: 0),
                            child:
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < 3; i++)
                                    Align(
                                      widthFactor: 0.5,
                                      child:
                                        circle
                                    )
                                ],
                              ),
                            )
                            )

                        ])
                    )
                ),
              ),
              Positioned(
                top:MediaQuery.of(context).size.width*0.28,
                  left: 30,
                  child:
                  Container(
                      height: 82.sp,
                      width: 63.sp,
                      decoration: BoxDecoration(
                        //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10)),
                      child:Center(child:      SizedBox(
                        height: 30,
                        width:30,
                        child:
                        Image.asset("assets/images/app.png", fit: BoxFit.cover),
                      )))
              ),
              Positioned(
                  top:MediaQuery.of(context).size.width*0.28,
                  left: 140.sp,
                  child:
                  Container(
                      height: 82.sp,
                      width: 63.sp,
                      decoration: BoxDecoration(
                        //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10)),
                      child:Center(child:      SizedBox(
                        height: 30,
                        width:30,
                        child:
                        Image.asset("assets/images/bplan.png", fit: BoxFit.cover),
                      )))
              ),
              Positioned(
                  top:MediaQuery.of(context).size.width*0.28,
                  left: 245.sp,
                  child:
                  Container(
                      height: 82.sp,
                      width: 63.sp,
                      decoration: BoxDecoration(
                        //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10)),
                      child:Center(child:      SizedBox(
                        height: 30,
                        width:30,
                        child:
                        Image.asset("assets/images/extra.png", fit: BoxFit.cover),
                      )))
              )
            ]))
    );



  }

}
