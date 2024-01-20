
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/BussinessModel.dart';
import 'package:redJAY/models/LangModel.dart';
import 'package:redJAY/models/ProviderModel.dart';
import 'package:redJAY/screens/home_page/AddVideos.dart';
import 'package:redJAY/screens/home_page/ExtraInfo.dart';
import 'package:redJAY/screens/home_page/bPlanCreate.dart';
import 'package:redJAY/screens/home_page/testtimeline.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelines/timelines.dart';

class listTimeline extends StatefulWidget {
  const  listTimeline({Key? key}) : super(key: key);
  @override
  State< listTimeline> createState() =>  listTimelineState();
}
class  listTimelineState extends State<listTimeline> {
  bool showYellowBirdlogo=false;
  bool isClickBird=false;
  String title="Yellowjay server";
  Color bgcolor=bgYellow;
  ScrollController? scrollController;
  bool pageLoading = true;
  bool hasData = true;
  bool isView = true;
  bool loadImage= false;
  bool gmailLoading=false;
  String companyName="";
  TextEditingController? _emailController;
  TextEditingController? _refController;
  String companyLogo="";
  bool loginLoading=false;
  bool updateLoading=false;
  String? _chosenValue;
  String? _chosenSourceValue;
  String? _chosenJobValue;
  String? _chosenLangValue;
  String? _chosenWorkValue;
  String? imageUri;
  List<DropdownMenuItem<String>> dropdownItems = [];
  List<DropdownMenuItem<String>> dropdownJobItems = [];
  List<DropdownMenuItem<String>> dropdownWorkItems = [];
  List<DropdownMenuItem<String>> dropdownLangItems = [];
  SharedPreferences? prefs;
  List<LangModel>CountryList = [];
  bool loading=false;
  bool rememberme=false;
  TextEditingController? _titleController=TextEditingController();

  TextEditingController? _phoneController=TextEditingController();

  TextEditingController _usernameCtrl= TextEditingController();
  TextEditingController _addressCtrl= TextEditingController();
  TextEditingController _passCtrl= TextEditingController();
  TextEditingController _rePassCtrl= TextEditingController();
  bool repasswordVisible=false;
  bool passwordVisible=false;
  String avatar="";
  String uri="";
  String extension="";
  String type="";
  String alt="";
  String name="";
  String data="";
  String size="140";
  String?  token1="";
  String?  lang="";
  String?  projectId="";
  List<ProviderModel> avatarList = [];
  List<BussinessModel> bussinessList = [];
  getCountries()
  async {
    prefs = await SharedPreferences.getInstance();
    //  token1 = prefs!.getString("token");
    var response = await (Services()).getCountries(token1!);
    if (response['statusCode'] != null&&response['statusCode']==200)
      response["data"].forEach((element){
        CountryList .add(LangModel.fromJson(element));
      });

    setState(() {
    });
  }

  getStatusProvider()
  async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   File file = File(result.files.single.path!);
  //  String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    imageUri="";//"https://petroskadeh.com//uploads/7ed149666af28514ee2db1ccbc916ea2febb8744.png";

    //  var response = await (Services()).Uploader(token1, "en", file);
    var response = await (Services()).getStatusProvider(token1!,projectId!,lang!);

    if (lang != null && lang!.trim().length > 0) {
      // setState(() {
      //   loginLoading = true;
      // });
      try {
        // var response = await (Services()).getStatusProvider(token1);
        //  var response = await (Services()).Uploader(token1,"en");
        //  var response = await (Services()).UpdateProvider(token1,"09126666661","1","abc","aaa","4","en","korea","lawyer","bbb","");
        if (response['statusCode'] != null && response['statusCode'] == 200) {
          // setState(() {
          //   loginLoading = false;
          // });
          hasData=response['data']['status'];
          if(hasData)
          {
            showBussinessProvider();
          }
          // if(response["data"]['status']!=null)
          //   isView  = response["data"]['status'];

          // customNotification(false, 'you are signed in as a ${email}', MediaQuery
          //      .of(context)
          //      .size
          //      .width, MediaQuery
          //      .of(context)
          //      .size
          // //      .height);
          // Navigator.pushNamed(context,"/main_tab_bar");
          // _usernameCtrl.text="";
          // _passCtrl.text="";

        } else {
          customNotification(true, response["message"], MediaQuery
              .of(context)
              .size
              .width, MediaQuery
              .of(context)
              .size
              .height);
          _usernameCtrl.text = "";
          _passCtrl.text = "";
          // setState(() {
          //   loginLoading = false;
          // });
        }
      } catch (error) {
        print(error);
        // setState(() {
        //   loginLoading = false;
        // });

      }
    }
  }
  showBussinessProvider()
  async {
//  token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    // var response3 = await (Services()).getProviderList(token1!, projectId!, lang!);
    try{
      setState(() {
        loginLoading = true;
      });
      var response2 = await (Services()).ShowBusinessProvider(token1!,lang!, projectId!);
      if (response2['statusCode'] != null && response2['statusCode'] == 200) {
        response2['data'].forEach((element) {
          bussinessList.add(BussinessModel.fromJson2(element));
        });
        setState(() {
          loginLoading = false;
        });
      }
    } catch (error) {
      print(error);
      setState(() {
        loginLoading = false;
      });
    }
    // providerList.add(ProviderModel.fromString("alireza", "haghighi", 1, "https://petroskadeh.com//uploads/7fa0ea82fdbad0f5586951fbdafa636b1b5990ae.png"));
    // providerList.add(ProviderModel.fromString("mina", "mansuri", 2, "https://petroskadeh.com//uploads/7fa0ea82fdbad0f5586951fbdafa636b1b5990ae.png"));
    // providerList.add(ProviderModel.fromString("shayan", "tahmaseb", 3, "https://petroskadeh.com//uploads/7fa0ea82fdbad0f5586951fbdafa636b1b5990ae.png"));
    // providerList.add(ProviderModel.fromString("babak", "jahani", 4, "https://petroskadeh.com//uploads/7fa0ea82fdbad0f5586951fbdafa636b1b5990ae.png"));

  }
  // showBussinessProvider2()
  // async {
  //   bussinessList.add(BussinessModel.fromString("alireza", "haghighi hffggfhgfffffffffffffffffffff", 1));
  //   bussinessList.add(BussinessModel.fromString("mina", "mansurib mmnkdfliugggggggggggvvv", 2, ));
  //   bussinessList.add(BussinessModel.fromString("shayan", "tahmaseb bbbbjjjjjjjjjjjjjjjllllllll", 3));
  //
  // }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _passCtrl.dispose();
    _rePassCtrl.dispose();
    _usernameCtrl.dispose();
    super.dispose();
  }
  getValueFromPref()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lang =prefs!.getString("lang_id");//"en";
    projectId = prefs!.getString("project_id");//"1"
    token1=prefs!.getString("token");//"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    // lang ="en";//prefs!.getString("lang_id");//"en";
    // projectId = "1";//prefs!.getString("project_id");//"1"
    // token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
//prefs!.getString("token");//

   showBussinessProvider();
  //  getStatusProvider();
  }
  @override
  initState()  {
    super.initState();
  getValueFromPref();
    //showProvider();
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
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:
                Image.asset("assets/images/bglang.png", fit: BoxFit.cover),
              ),
              Padding(padding: EdgeInsets.only(top:50,left:MediaQuery.of(context).size.width*0.01 ),child:
              Text("Business plans",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color:  Colors.white24,))),
              Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.width*0.3,),
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
              Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.width*0.53,),
                child:

                Container(
                    height: MediaQuery.of(context).size.height*0.73,
                    width: MediaQuery.of(context).size.width*0.86,
                    decoration: BoxDecoration(
                      //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(30)),
                         margin: new EdgeInsets.only(top: 0),
                         child:
                         Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [

                           loginLoading?
                        Center(child:   Container(
                             width: 24,
                             height: 24,
                             padding: const EdgeInsets.all(2.0),
                             child: const CircularProgressIndicator(
                               color: bgbuttonRed,
                               strokeWidth: 3,
                             ),
                           )) :
                         Container(
                         height: MediaQuery.of(context).size.height*0.68,
                          width: MediaQuery.of(context).size.width*0.86,child:
                               ListView.builder(
                                  itemCount:bussinessList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                  return
                                    GestureDetector(
                                        onTap: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) =>  bPlanCreate(bussinessModel: BussinessModel.fromString(bussinessList[index].title,bussinessList[index].description,int.parse(bussinessList[index].id),[],bussinessList[index].price))),
                                            );
                                         },child:
                                  Column(children: [
                                    SizedBox(height: 10,),
                                  Container(
                                  width:  MediaQuery.of(context).size.width*0.8,
                                  height: 120.sp,
                                  decoration: BoxDecoration(
                                  border: Border.all(color: frameColor),
                                  borderRadius: BorderRadius.circular(30.sp),
                                  color: greyColor3 //.withOpacity(0.1)
                                  ),
                                  child:
                                  Column(children: [
                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 27,child:
                                        Image.asset("assets/images/remove.png", fit: BoxFit.cover,)),
                                      SizedBox(width: 100.sp,child:
                                      Text(bussinessList[index].title,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color:  Colors.white,))),
                                    Container(
                                    width: 80,
                                    height: 35.sp,
                                    decoration: BoxDecoration(
                                    border: Border.all(color: frameColor),
                                    borderRadius: BorderRadius.circular(30.sp),
                                    color: frameColor//.withOpacity(0.1)
                                    ),
                                    child:Center(child: Text('Waiting',
                                    style:  TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14 ,
                                    color:bussinessList[index].status.contains("pending")?
                                    Colors.red: bussinessList[index].status.contains("pay")?Colors.green :Colors.deepOrange,
                                    //  fontWeight: FontWeight.bold,
                                    ),
                                    )),
                                    )
                                    ]),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 30.sp,),
                                    SizedBox(width: 240.sp,child:
                                        Text(bussinessList[index].description,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color:  Colors.white,)),
                                    )
                                      ],),
                                    ],
                                  )),
                                    //SizedBox(height: 10,),
                                    ])
                                    );}
                                  )),
                //    SizedBox( height: 20),
                   SizedBox(height: 5,),

                    ])
                )

   ),

                // new SingleChildScrollView(child:
                    // Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: <Widget>[
                    //       SizedBox(height: 20,),
                    //
                    //
                    //     ])
                    // )
              Positioned(
                  top:MediaQuery.of(context).size.width*0.28,
                  left: 70,
                  child:
                  Container(
                      height: 82.sp,
                      width: 63.sp,
                      decoration: BoxDecoration(
                          border: Border.all(color: blackColor55) ,
                          //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                          color: Colors.white60,
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
                  left: 180.sp,
                  child:
                  GestureDetector(
                      onTap: () async {
                        // Navigator.pushReplacementNamed(context, "/verification");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  AddVideo()),
                        );
                      },child:
                  Container(
                      height: 82.sp,
                      width: 63.sp,
                      decoration: BoxDecoration(
                          border: Border.all(color: blackColor55) ,
                          //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(10)),
                      child:Center(child:      SizedBox(
                        height: 30,
                        width:30,
                        child:
                        Image.asset("assets/images/bplan.png", fit: BoxFit.cover),
                      ))))
              ),
              Positioned(
                  left:MediaQuery.of(context).size.width*0.38,
                  bottom: 20.sp,
                  child:
                  GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  bPlanCreate()),
                        );
                      },child:
                  Container(
                    width: 120,
                    height: 35.sp,
                    decoration: BoxDecoration(
                        border: Border.all(color: bgbuttonRed),
                        borderRadius: BorderRadius.circular(30.sp),
                        color: bgbuttonRed//.withOpacity(0.1)
                    ),
                    child:Center(child: Text('Add Project',
                      style: const TextStyle(
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 15 ,
                        color:Colors.white  ,
                        //  fontWeight: FontWeight.bold,
                      ),
                    )),
                  ))
              ),
              Positioned(
                  top:MediaQuery.of(context).size.width*0.28,
                  left: 280.sp,
                  child:
                  GestureDetector(
                      onTap: () async {
                        // Navigator.pushReplacementNamed(context, "/verification");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ExtraInfo()),
                        );
                      },child:
                  Container(
                      height: 82.sp,
                      width: 63.sp,
                      decoration: BoxDecoration(
                          border: Border.all(color: blackColor55) ,
                          //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(10)),
                      child:Center(child:      SizedBox(
                        height: 30,
                        width:30,
                        child:
                        Image.asset("assets/images/extra.png", fit: BoxFit.cover),
                      ))))
              )
            ]))
    );



  }

}
