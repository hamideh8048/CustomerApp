
import 'package:cached_network_image/cached_network_image.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/BussinessModel.dart';
import 'package:redJAY/models/ProviderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redJAY/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/PartModel.dart';


class bPlanDetail extends StatefulWidget {
  const bPlanDetail({Key? key,this.bussinessModel}) : super(key: key);
  final   BussinessModel? bussinessModel;

  @override
  State<bPlanDetail> createState() => bPlanDetailState();
}

class bPlanDetailState extends State<bPlanDetail>

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
String price="";
bool loginLoading=false;
String? _chosenValue;
String? _chosenSourceValue;
List<DropdownMenuItem<String>> dropdownItems = [];
bool loading=false;
  bool rememberme=false;

  TextEditingController _usernameCtrl= TextEditingController();
  TextEditingController _passCtrl= TextEditingController();
  TextEditingController _rePassCtrl= TextEditingController();
  bool repasswordVisible=false;
  bool passwordVisible=false;

String?  token1="";
String?  lang="";
String?  projectId="";
getValueFromPref()async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  lang =prefs!.getString("lang_id");//"en";
  projectId = prefs!.getString("project_id");//"1"
  token1=prefs!.getString("token");//"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
  // lang ="en";//prefs!.getString("lang_id");//"en";
  // projectId = "1";//prefs!.getString("project_id");//"1"
  // token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDI5OTI3MTMsImV4cCI6MTcwNTU4NTMxMywibmJmIjoxNzAyOTkyNzEzLCJqdGkiOiJXdEhld0MySUlnTDBDcHZXIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ.nLt3G4TnyCW2-TMA4_pODSzryV5FptzHB1gycdSBkP0";
//prefs!.getString("token");//
  showProvider();

  //  getStatusProvider();
}

@override
void dispose() {
  // Clean up the controller when the widget is removed from the widget tree.
  // This also removes the _printLatestValue listener.
  _passCtrl.dispose();
  _rePassCtrl.dispose();
  _usernameCtrl.dispose();

  super.dispose();
}
List<PartModel>listParts=[];
showProvider()
async {
  //! String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
  setState(() {loading=true;});
  if(widget.bussinessModel!=null)
  {
    if (lang != null && lang!.trim().length > 0) {
      var response = await (Services()).ShowBussiness(  token1!,lang!,projectId!,widget.bussinessModel!.id);
      try {

        if (response['statusCode'] != null && response['statusCode'] == 200) {
          if(response['data'].length>0&&response['data'][0]['part']!=null)
            response['data'][0]['part'].forEach((element) {
              listParts.add(PartModel.fromJson(element));
            });
          // if(response['data'].length>0&&response['data'][0]['file']!=null)
          //   uri=response["data"][0]['file']??"";
          if(response['data'].length>0&&response['data'][0]['price']!=null)
           price=  response['data'][0]['price'];
          widget.bussinessModel!.price= price;
          // extension='png';
          // type='avatar';
          // size='150192';
          // name='image.png';
          // alt='image.png';
          // data='';
          setState(() { loading=false;});
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
          setState(() { loading=false;});
        }
      } catch (error) {
        print(error);
        setState(() {
         loading = false;
        });
      }}
  }
}
@override
  initState()  {
    super.initState();
    getValueFromPref();
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


              Padding(padding: EdgeInsets.only(
                right:MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.width*0.54,),
                  child:
                  Container(
                      height: MediaQuery.of(context).size.height*0.75,
                      width: MediaQuery.of(context).size.width*0.89,
                      // padding: const EdgeInsets.only(left: 0.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [greyColor3, greyColor3.withOpacity(0.4)]
                          ),
                        //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                          color:greyColor3,
                          // border: Border.all(color: Colors.white) ,
                          borderRadius: BorderRadius.only(topRight:  Radius.circular(30))),
                      child:

                     loading?
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
                          height: MediaQuery.of(context).size.height*0.75,
                          width: MediaQuery.of(context).size.width*0.86,
                          // padding: const EdgeInsets.only(left: 0.0),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [greyColor3, greyColor3.withOpacity(0.4)]
                              ),
                              //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                              color:frameColor,
                              border: Border.all(color: Colors.white) ,
                              borderRadius: BorderRadius.only(topRight:  Radius.circular(30))),
                          child:


                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(left: 150.sp,top:100.sp),child:
                                Text(widget. bussinessModel!.title,
                                  style: const TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18 ,
                                    color:Colors.white  ,
                                    //  fontWeight: FontWeight.bold,
                                  ),
                                )),
                                SizedBox(height: 20,),
                      Padding(padding: EdgeInsets.only(left: 110.sp),child:
                                Text(widget. bussinessModel!.description,
                                  style: const TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15 ,
                                    color:Colors.white  ,
                                    //  fontWeight: FontWeight.bold,
                                  ),
                                )),
                                SizedBox(height: 20,),
                                Padding(
                                    padding:  EdgeInsets.only(left:20,right: 20),child:
                                Divider(
                                  color: Colors.white,thickness: 2,
                                )),

                                Padding(padding: EdgeInsets.only(left:10,right: 10,top: 20),child:

                                Container(

                                    height: 150,
                                    width: MediaQuery.of(context).size.width*0.86,child:
                                ListView.builder(
                                    itemCount:listParts.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return

                                        Row(children: [
                                          SizedBox(height: 10,),

                                          Column
                                            (
                                            mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(height: 5,),


                                              Text("PART"+index.toString(),style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color:  Colors.white,)),


                                              SizedBox(height: 10,),

                                              Padding(padding: EdgeInsets.only(left:20),child:
                                              SizedBox(width:80.sp,child:
                                              Text(listParts[index].title,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color:  Colors.white,)),
                                              )
                                              ),
                                              SizedBox(height: 10,),
                                              GestureDetector(
                                                  onTap: () async {
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(builder: (context) =>  bPlanDetail(bussinessModel: BussinessModel.fromString(bussinessList[index].title,bussinessList[index].description,int.parse(bussinessList[index].id),[],bussinessList[index].price))),
                                                    // );
                                                  },child:
                                              Container(
                                                width: 80,
                                                height: 35.sp,
                                                decoration: BoxDecoration(
                                                  //   border: Border.all(color: Red),
                                                    borderRadius: BorderRadius.circular(30.sp),
                                                    color: Colors.white
                                                ),
                                                child:Center(child: Text(listParts[index].price+"USDT",
                                                  style: const TextStyle(
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15 ,
                                                    color:Colors.black  ,
                                                    //  fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                              ))
                                            ],
                                          ),
                                          //SizedBox(height: 10,),
                                        ]);
                                    }
                                ))),

                                  Padding(padding: EdgeInsets.only(left:10,top:10.sp),child:
                                      SizedBox(width: MediaQuery.of(context).size.width*0.82,child:
                                  Text("If our service was satisfactory for you"+
                                    "the amount you paid will be released to the service provider,"+
                                    "but if you have any dissatisfaction, the amount will be returned to you.",
                                    maxLines: 3,
                                    style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15 ,
                                      color:Colors.white  ,
                                      //  fontWeight: FontWeight.bold,
                                    ),
                                  ))),
                      Padding(padding: EdgeInsets.only(left:10,top:15.sp),child:
                                GestureDetector(
                                    onTap: () async {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) =>  bPlanDetail(bussinessModel: BussinessModel.fromString(bussinessList[index].title,bussinessList[index].description,int.parse(bussinessList[index].id),[],bussinessList[index].price))),
                                      // );
                                    },child:
                                Container(
                                  width: 110,
                                  height: 35.sp,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: bgbuttonRed),
                                      borderRadius: BorderRadius.circular(15.sp),
                                      boxShadow: [
                                        BoxShadow(
                                            color: greyColor3,
                                            blurRadius: 10,
                                            spreadRadius: 10)
                                      ],
                                      color: bgbuttonRed//.withOpacity(0.1)
                                  ),
                                  child:Center(child: Text('Read Rules',
                                    style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15 ,
                                      color:Colors.white  ,
                                      //  fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                ))),
                                Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.65.sp,top:60.sp),child:
                                Text(' Price '+widget.bussinessModel!.price.toString(),
                                  style: const TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15 ,
                                    color:Colors.white  ,
                                    //  fontWeight: FontWeight.bold,

                                ),
                                )
                                ),
                                Padding(
                                    padding:  EdgeInsets.only(left:20,right: 20),child:
                                Divider(
                                  color: Colors.white,thickness: 2,
                                )),

                                Padding(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.65.sp,top:5.sp),child:

                                Container(
                        width: 110,
                        height: 35.sp,
                        decoration: BoxDecoration(
                            border: Border.all(color: bgbuttonRed),
                            borderRadius: BorderRadius.circular(15.sp),
                            color: bgbuttonRed,
                            //.withOpacity(0.1)
                            boxShadow: [
                            BoxShadow(
                                color: greyColor3,
                                blurRadius: 10,
                                spreadRadius: 10)
                            ]
                        ),

                        child:Center(child: Text(' START ',
                          style: const TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 15 ,
                            color:Colors.white  ,
                            //  fontWeight: FontWeight.bold,
                          ),
                        )),
                      )
                      )
                      ])
                      ))),

              Positioned(
                  top:MediaQuery.of(context).size.width*0.28,
                  left: 30,
                  child:
                  GestureDetector(
                      onTap: () async {

                      },
                      child:
                      Container(
                          height: 82.sp,
                          width: 63.sp,
                          decoration: BoxDecoration(
                            //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                              color: Colors.white60,
                              border: Border.all(color: blackColor55) ,
                              borderRadius: BorderRadius.circular(10)),
                          child:Center(child:      SizedBox(
                            height: 32,
                            width:32,
                            child:
                            Image.asset("assets/images/app.png", fit: BoxFit.cover),
                          ))))
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
                          color: Colors.white60,
                          border: Border.all(color: blackColor55) ,
                          borderRadius: BorderRadius.circular(10)),
                      child:Center(child:      SizedBox(
                        height: 32,
                        width:32,
                        child:
                        Image.asset("assets/images/bplan.png", fit: BoxFit.cover),
                      )))
              ),
              Positioned(
                  top:MediaQuery.of(context).size.width*0.28,
                  left: 245.sp,
                  child:
                  GestureDetector(
                      onTap: () async {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) =>  ExtraIntroduction(providerModel: widget.providerModel,backgroundColor: widget.backgroundColor,buttonColorColor: widget.buttonColorColor,bgtextColor: widget.buttonColorColor,)),
                        // );
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
                        height: 32,
                        width:32,
                        child:
                        Image.asset("assets/images/extra.png", fit: BoxFit.cover),
                      ))))
              )
            ]))
    );


  }

}
