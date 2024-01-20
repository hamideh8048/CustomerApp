
import 'package:cached_network_image/cached_network_image.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/ExtraModel.dart';
import 'package:redJAY/models/ProviderModel.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'VideoIntroduction.dart';
import 'bPlanIntroduction.dart';

class ExtraIntroduction extends StatefulWidget {
  const ExtraIntroduction({Key? key,required this.providerModel,required this.backgroundColor,required this.buttonColorColor,required this.bgtextColor}) : super(key: key);
final   ProviderModel providerModel;
  final   Color backgroundColor;
  final   Color buttonColorColor;
  final   Color bgtextColor;

  @override
  State<ExtraIntroduction> createState() => ExtraIntroductionState();
}

class  ExtraIntroductionState extends State<ExtraIntroduction>
  with TickerProviderStateMixin
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
String? _chosenValue;
String? _chosenSourceValue;
List<DropdownMenuItem<String>> dropdownItems = [];
bool loading=false;
  bool rememberme=false;
TextEditingController _countCtrl= TextEditingController();
TextEditingController _countCtrl2= TextEditingController();
TextEditingController _countCtrl3= TextEditingController();
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

  super.dispose();
}
String?  token1="";
String?  lang="";
String?  projectId="";
List<ExtraModel> avatarList = [];

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
  showExtra();
}
showExtra()
async {
  // String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
  var response = await (Services()).ShowExtra(  token1!,lang!,projectId!);

  if (lang != null && lang!.trim().length > 0) {
    // setState(() {
    //   loginLoading = true;
    // });
    try {
      if (response['statusCode'] != null && response['statusCode'] == 200) {
        response['data'].forEach((element){
          avatarList.add(ExtraModel .fromJson(element));
          //  taradods.add(TaradodListModel.fromJson(element));
        });
        int index=0;
        if(avatarList.length>3)
          index=avatarList.length-3;
        for(int i = index; i < avatarList.length; i++){
          if(i==index) {
            _countCtrl!.text = avatarList[i].count;

          }
          if(i==index+1) {
            _countCtrl2!.text = avatarList[i].count;

          }
          if(i==index+2)
            _countCtrl3!.text=avatarList[i].count;

        }
        // uri=response["data"]["avatar"]??"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";
        //  extension='png';
        //  type='avatar';
        //  size='150192';
        //  name='image.png';
        //  alt='image.png';
        //  data='';
        //  imageUri=uri;//"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//response["data"]["avatar"];
        setState(() {
          //  loginLoading = false;
        });


      } else {
        customNotification(true, response["message"], MediaQuery
            .of(context)
            .size
            .width, MediaQuery
            .of(context)
            .size
            .height);
        _countCtrl.text = "";
        //_passCtrl.text = "";
        // setState(() {
        //   loginLoading = false;
        // });
      }
    } catch (error) {
      print(error);
      setState(() {
        // loginLoading = false;
      });
    }
  }
}
@override
  initState()  {
    super.initState();
  //  _emailController= TextEditingController(text: "");
  //   lang ="en"; //prefs!.getString("lang_id");
  //   projectId = "1";//prefs!.getString("project_id");
  //   token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
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
              right:MediaQuery.of(context).size.width*0.21,
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

               right:MediaQuery.of(context).size.width*0.132,top:MediaQuery.of(context).size.width*0.54,),
                child:
                Container(
                    height: MediaQuery.of(context).size.height*0.75,
                    width: MediaQuery.of(context).size.width*0.86,
                    // padding: const EdgeInsets.only(left: 0.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [widget.backgroundColor, widget.backgroundColor.withOpacity(0.1)]
                        ),
                      //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                        color:widget. backgroundColor,//frameColor,
                        border: Border.all(color: Colors.white) ,
                        borderRadius: BorderRadius.only(topRight:  Radius.circular(30))),
                    child:
                    new SingleChildScrollView(child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20,),
                        Padding(
                            padding:  EdgeInsets.only(left:20,bottom: 0,right: 20),
                            child:
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                SizedBox(width: 140,height: 140,child:
                                ClipOval(

                                    child:
                                Material(
                                  color: widget.backgroundColor,child:Center(child:
                                  CachedNetworkImage(

                                    imageUrl: widget.providerModel.profile,
                                    imageBuilder: (context, imageProvider) => Container(

                                      decoration: BoxDecoration(
                                        image: DecorationImage(

                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  )),
                                )
                                ),
                                ),

                                     Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment:
                                   MainAxisAlignment.spaceAround,

                                      children: [
                                        SizedBox(height:60,),
                                        Image.asset("assets/images/like.png",width: 43.sp, fit: BoxFit.fill),
                                        Image.asset("assets/images/dislike.png",width: 43.sp, fit: BoxFit.fill),
                                        ]),
                                  Container(
                                    height: 35.sp,
                                    width: 120,
                                    //  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: bgbuttonRed),
                                        borderRadius: BorderRadius.circular(10.sp),
                                        color:widget.backgroundColor==bgbuttonRed?greyColor3: bgbuttonRed//.withOpacity(0.1)
                                    ),
                                    child:Center(child: Text('Contact',
                                      style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15 ,
                                        color:Colors.white  ,
                                        //  fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  )
                                      ])

                                ])),
                        Padding(
                            padding:  EdgeInsets.only(left:5,top:50),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text('The documentation has been verified by the',
                              style: const TextStyle(
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w400,
                                fontSize: 13 ,
                                color:greenColor  ,
                                //  fontWeight: FontWeight.bold,
                              ),
                            ),
                          Text('Red Jay',
                            style: const TextStyle(
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w400,
                              fontSize: 13 ,
                              color:bgbuttonRed  ,
                              //  fontWeight: FontWeight.bold,
                            ),
                          ),
                                Text('app',
                                  style: const TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13 ,
                                    color:greenColor  ,
                                    //  fontWeight: FontWeight.bold,
                                  ),
                                ),
                          ])
                        ),
                          Padding(
                              padding:  EdgeInsets.only(left:40,top:20),
                              child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox( width: 250.sp,child:
                                    Container(
                                        height: 45.sp,
                                        decoration: BoxDecoration(
                                          // border: Border.all(color: bgbuttonRed),
                                            borderRadius: BorderRadius.circular(30.sp),
                                            color: Colors.white//.withOpacity(0.1)
                                        ),
                                        child:
                                        Padding(
                                            padding:  EdgeInsets.symmetric(vertical: 10),child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 10,),
                                            Text('Total businesses',
                                              style: const TextStyle(
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 15 ,
                                                color:Colors.black  ,
                                                //  fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(_countCtrl.text,
                                              style: const TextStyle(
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15 ,
                                                color:Colors.red  ,
                                                //  fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                          ],
                                        ))
                                    ))
                                  ])

                          ),

                          Padding(
                              padding:  EdgeInsets.only(left:40,right: 20,top:20),
                              child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox( width: 250.sp,child:
                              Container(
                                  height: 45.sp,
                                  decoration: BoxDecoration(
                                    // border: Border.all(color: bgbuttonRed),
                                      borderRadius: BorderRadius.circular(30.sp),
                                      color: Colors.white//.withOpacity(0.1)
                                  ),
                                  child:
                                  Padding(
                                      padding:  EdgeInsets.symmetric(vertical: 10),child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 10,),
                                      Text('Successful businesses',
                                        style: const TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15 ,
                                          color:Colors.black  ,
                                          //  fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(_countCtrl2.text,
                                        style: const TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15 ,
                                          color:Colors.red  ,
                                          //  fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                    ],
                                  ))
                                 ))
                                 ])
                          ),
                               Padding(
                              padding:  EdgeInsets.only(left:40,top:20.sp,bottom: 0,right: 20),
                              child:

                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox( width: 250.sp,child:
                                    Container(
                                      height: 45.sp,
                                      decoration: BoxDecoration(
                                         // border: Border.all(color: bgbuttonRed),
                                          borderRadius: BorderRadius.circular(30.sp),
                                        color: Colors.white//.withOpacity(0.1)
                                      ),
                                      child:
                                      Padding(
                                          padding:  EdgeInsets.symmetric(vertical: 10),child:

                                          Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
SizedBox(width: 10,),
                                          Text('Active Bussiness',
                                            style: const TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15 ,
                                              color:Colors.black  ,
                                              //  fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Spacer(flex: 1),
                                          Text(_countCtrl.text
                                            ,
                                            style: const TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15 ,
                                              color:Colors.red  ,
                                              //  fontWeight: FontWeight.bold,
                                            ),

                                          ), SizedBox(width: 10,),
                                        ],
                                      ))
                                    )
                                    ),


                                  ])
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left:20,top:30.sp,bottom: 10,right: 20),
                              child:
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          // Navigator.pushReplacementNamed(context, "/verification");
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) =>  DailyTask(taradod: taradodList[index],)),
                                          // );
                                          if (_formKey.currentState!.validate()) {

                                          }

                                        },child:
                                    loginLoading?
                                    Container(
                                      width: 24,
                                      height: 24,
                                      padding: const EdgeInsets.all(2.0),
                                      child: const CircularProgressIndicator(
                                        color: bgbuttonRed,
                                        strokeWidth: 3,
                                      ),
                                    ):

                                    Container(
                                      width: 120,
                                      height: 35.sp,

                                        decoration: BoxDecoration(
                                          border: Border.all(color: bgbuttonRed),
                                          borderRadius: BorderRadius.circular(30.sp),
                                          color: bgbuttonRed//.withOpacity(0.1)
                                      ),
                                      child:
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(width: 20,),
                                          Image.asset("assets/images/Files.png",width: 15.sp, fit: BoxFit.fill),
                                            SizedBox(width: 10,),
                                          Text('Files',
                                            style: const TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15 ,
                                              color:Colors.white  ,
                                              //  fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      )

                                    )),

                                  ]))

                        ])
                    )
                ),
              ),
              Positioned(
                top:MediaQuery.of(context).size.width*0.28,
                  left: 30,
                  child:
                  GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  VideoIntroduction(providerModel: widget.providerModel,backgroundColor: widget.backgroundColor,buttonColorColor: widget.buttonColorColor,bgtextColor: widget.buttonColorColor,)),
                        );
                      },child:
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
                  GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => bPlanIntroduction ()),
                        );
                      },child:
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
                      ))))
              ),
              Positioned(
                  top:MediaQuery.of(context).size.width*0.28,
                  left: 245.sp,
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
                        height: 32,
                        width:32,
                        child:
                        Image.asset("assets/images/extra.png", fit: BoxFit.cover),
                      )))
              )
            ])

        )
    );



  }

}
