
import 'package:cached_network_image/cached_network_image.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/ProviderModel.dart';
import 'package:redJAY/screens/home_page/introduction.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class Introduction3 extends StatefulWidget {
  const Introduction3({Key? key}) : super(key: key);

  @override
  State<Introduction3> createState() => Introduction3State();
}

class Introduction3State extends State<Introduction3>

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
List<ProviderModel> providerList = [];

Color? bgContainer;
Color? bgtext;
Color? bgButton;
Color getButtonColor(int index) {
    index = index % 2;
    if (index == 0)
      bgButton =greyColor3;
    else if (index == 1)
      bgButton =Colors.white;
    return bgButton!;
}
Color? textColor;
Color getTextColor(int index) {
  index = index % 2;
  if (index == 1)
    textColor =greyColor3;
  else if (index == 0)
    textColor =Colors.white;
  return textColor!;
}
Color getColor(int index) {
  if(index>4)
  index=index%4;
  if (index == 1)
    bgContainer = greyColor3;
  else if (index == 2)
    bgContainer =frameColor;
  else if (index == 3)
    bgContainer = bgbuttonRed;
  else if (index == 4)
    bgContainer = greyColor2;
  return bgContainer!;
}
double topPadding=10;
double  getTopPadding(int index)
{
  if(   index>4)
    index=index%4;
  if(index==1)
    topPadding=40.sp;
  else if(index==2)
    topPadding=120.sp;
  else if(index==4)
    topPadding=80.sp;
  else if(index==3)
    topPadding=100.sp;

  return topPadding;
}

double height=100;
double  getHeight(int index)
  {
 if(   index>4)
   index=index%4;
    if(index==1)
      height=290.sp;
    else if(index==2)
      height=410.sp;
    else if(index==4)
      height=330.sp;
    else if(index==3)
      height=370.sp;
    return height;
  }
getProviders()
async {
//  token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
 // var response3 = await (Services()).getProviderList(token1!, projectId!, lang!);
 try{
  setState(() {
   loginLoading = true;
  });
  var response2 = await (Services()).showList2(token1!, projectId!);
  if (response2['statusCode'] != null && response2['statusCode'] == 200) {
    response2['data'].forEach((element) {
      providerList.add(ProviderModel.fromJson(element));
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
@override
void dispose() {
  // Clean up the controller when the widget is removed from the widget tree.
  // This also removes the _printLatestValue listener.
  _passCtrl.dispose();
  _rePassCtrl.dispose();
  _usernameCtrl.dispose();
  super.dispose();
}
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
  // token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
//prefs!.getString("token");//
  getProviders();
}
@override
  initState()  {
    super.initState();
    // lang ="en";//prefs!.getString("lang_id");//"en";
    // projectId = "1";//prefs!.getString("project_id");//"1"
    // token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    getValueFromPref();
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
        Padding(padding: EdgeInsets.only(top:70,left: 20),
        child:     Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 40.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                  //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                    color: bgbuttonRed,
                    boxShadow: [
                      BoxShadow(color: Colors.black, spreadRadius: -10,  ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child:Center(child:      SizedBox(
                  height: 20,
                  width:20,
                  child:
                  Image.asset("assets/images/back.png", fit: BoxFit.cover),
                ))),
            SizedBox(width: 30.sp,),
            SizedBox(
              height: 35,
              width: 240.sp,
              child: TextField(

                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  filled: true,
                  fillColor: bgbuttonRed,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(18),

                  ),
                  hintText: "Search  ",
                  hintStyle:TextStyle(color: Colors.white),

                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 30.sp,),
            Padding(padding: EdgeInsets.only(right: 10),child:
            Container(
                height: 40.sp,
                width: 40.sp,
                decoration: BoxDecoration(
                  //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                    boxShadow: [
                      BoxShadow(color: Colors.black, spreadRadius: -10,  blurRadius: 10,),
                    ],
                    color: bgbuttonRed,
                    borderRadius: BorderRadius.circular(10)),
                child:Center(child:      SizedBox(
                  height: 20,
                  width:20,
                  child:
                  Image.asset("assets/images/home.png", fit: BoxFit.cover),
                ))))
          ],

        )),
             Padding(padding: EdgeInsets.only(

               right:0,top:MediaQuery.of(context).size.width*0.5,left: 0),
                child:

                Container(
                    height: MediaQuery.of(context).size.height*0.6,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(0)),
                    child:
                    new SingleChildScrollView(child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 115.sp,),
                          // Text("Personal Information",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                          // SizedBox(height: 15,),

                          Padding(
                              padding:  EdgeInsets.only(left:20,right: 20),
                              child:
                              Container(
                                child:
                                new SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    for (int i = 0; i < providerList.length; i++)
                                       Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                      // Align(
                                      //     widthFactor: 1,
                                      //     child:
                                GestureDetector(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  Introduction(providerModel: providerList[i],backgroundColor: getColor(i+1),buttonColorColor: getButtonColor(i+1),bgtextColor: getTextColor(i+1),)),
                                      );
                                    },
                                    child:
                                          Container(
                                              height:getHeight(i+1),//i==1?210: i==2?350: 300.sp,
                                              width: 250.sp,
                                              //  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),

                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20.sp),
                                                  color:getColor(i+1)//.withOpacity(0.1)
                                              ),
                                              child:
                                                  Stack(

                                                      children:[

                                              Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                              Padding(
                                                  padding:  EdgeInsets.only(left:10,top: 30 ),
                                                  child:
                                             
                                                  Container(
                                                    height: 35.sp,
                                                    width: 150,
                                                    //  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10.sp),
                                                        color: getButtonColor(i+1),//.withOpacity(0.1)
                                                    ),
                                                    child:Center(child: Text(providerList[i].first_name+""+providerList[i].last_name,
                                                      style:  TextStyle(
                                                        fontFamily: 'DM Sans',
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 15 ,
                                                        color: getButtonColor(i)   ,
                                                        //  fontWeight: FontWeight.bold,
                                                      ),
                                                    )),
                                                  )

                                              ),
                                                    Padding(
                                                        padding:  EdgeInsets.only(left:10,top: 10 ),
                                                        child:
                                                        Container(
                                                            height: 30.sp,
                                                            width: 65.sp,
                                                           //  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10.sp),
                                                                color: getButtonColor(i+1)//.withOpacity(0.1)
                                                            ),
                                                            child:
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.spaceAround,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset("assets/images/star.png",width: 20.sp, fit: BoxFit.fill),

                                                                Text('8.9',
                                                                    style:  TextStyle(
                                                                      fontFamily: 'DM Sans',
                                                                      fontWeight: FontWeight.w700,
                                                                      fontSize: 15 ,
                                                                      color:getButtonColor(i)   ,
                                                                    ))],
                                                            ))
                                                    ),

                                                  ]
                                                    ),
                                    Positioned(
                                    top:60+getTopPadding(i+1),//MediaQuery.of(context).size.width*0.28,
                                 ////     bottom: 200,
                                        right:(i+1)%2==0? MediaQuery.of(context).size.width*0.23:0,

                                        // left: 110.sp,
                                  child:
                                      SizedBox(
                                        width: 140,
                                    height: 160,
                                    child:

                                       //  Image.asset("assets/images/img_2.png",width: 140.sp,height: 140, fit: BoxFit.fill)),
                                  CachedNetworkImage(
                                    imageUrl: providerList[i].profile!,
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        Container(
                                          margin: new EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                                          width: 10,
                                          height: 10,
                                          child: const CircularProgressIndicator(
                                            color: bgbuttonRed,
                                            strokeWidth: 3,
                                          ),
                                        ),
                                    errorWidget: (context, url, error) {
                                      print("hey you:"+error);
                                   return   Icon(Icons.error);
                                    }
                                  )
                                      )),
                                                    Positioned(
                                                        top:80+getTopPadding(i+1),//MediaQuery.of(context).size.width*0.28,
                                                        ////     bottom: 200,
                                                       // right:(i+1)%2==0?0:MediaQuery.of(context).size.width*2,
                                                        right:(i+1)%2==1? MediaQuery.of(context).size.width*0.32:0,
                                                        // left: 110.sp,
                                                        child:
                                                       Column(
                                                         children: [
                                                                     SizedBox(
                                                                         width:80.sp,
                                                                         child:
                                                                         Text('Click',
                                                                             style:  TextStyle(
                                                                               //   height: 1.5,
                                                                               fontFamily: 'DM Sans',
                                                                               fontWeight: FontWeight.w700,
                                                                               fontSize: 22 ,
                                                                               color:  getButtonColor(i+1) ,
                                                                             ))),

                                                                   SizedBox(
                                                                       width:100.sp,
                                                                       child:
                                                                       Text('Principal Attorney at a law firm with 7 years experience  in Immigration Law',
                                                                           maxLines:3,
                                                                           style:  TextStyle(
                                                                             //   height: 1.5,
                                                                             fontFamily: 'DM Sans',
                                                                             fontWeight: FontWeight.w500,
                                                                             fontSize: 14 ,
                                                                             color:  getButtonColor(i+1) ,
                                                                           ))),

                                                                   // Text('Click',
                                                                   //     style: const TextStyle(
                                                                   //       fontFamily: 'DM Sans',
                                                                   //       fontWeight: FontWeight.w700,
                                                                   //       fontSize: 24 ,
                                                                   //       color: bgGray2  ,
                                                                   //     )),

                                                                 ],
                                                       )

                                                    )

        ])

                                      )),SizedBox(width: 10,)])
                                  ],
                                )),
                              )
                          ),

                        ])
                    )
                )
              ),
              Positioned(
                  top:MediaQuery.of(context).size.height*0.5,
                  left:MediaQuery.of(context).size.width*0.42,
                  child:
                  loginLoading?
                  Container(
                    width: 54,
                    height: 54,
                    padding: const EdgeInsets.all(2.0),
                    child: const CircularProgressIndicator(
                      color: bgbuttonRed,
                      strokeWidth: 3,
                    ),
                  ):Container())
            ]))
    );



  }

}
