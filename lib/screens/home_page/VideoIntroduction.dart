
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/AvatarModel.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/ProviderModel.dart';
import 'ExtraIntroduction.dart';
import 'bPlanIntroduction.dart';


class VideoIntroduction extends StatefulWidget {
  const VideoIntroduction({Key? key, this.providerModel, this.backgroundColor, this.buttonColorColor, this.bgtextColor}) : super(key: key);
  //const VideoIntroduction({Key? key,required this.providerModel,required this.backgroundColor,required this.buttonColorColor,required this.bgtextColor}) : super(key: key);
  final   ProviderModel? providerModel;
  final   Color? backgroundColor;
  final   Color? buttonColorColor;
  final   Color? bgtextColor;
  @override
  State<VideoIntroduction> createState() => VideoIntroductionState();
}
class VideoIntroductionState extends State<VideoIntroduction> {
bool showYellowBirdlogo=false;
bool isClickBird=false;
bool loginLoading=false;
String title="Yellowjay server";
Color bgcolor=bgYellow;
ScrollController? scrollController;
bool pageLoading = true;
bool gmailLoading=false;
String companyName="";
TextEditingController? _emailController;
TextEditingController? _refController;
String companyLogo="";
String? largeImageUrl;

List<DropdownMenuItem<String>> dropdownItems = [];
bool loading=false;
bool rememberme=false;

  TextEditingController _usernameCtrl= TextEditingController();
  TextEditingController _passCtrl= TextEditingController();
  TextEditingController _rePassCtrl= TextEditingController();
bool repasswordVisible=false;
bool passwordVisible=false;
bool loadImage=false;
bool loadImage2=false;
bool loadImage3=false;
bool loadImage4=false;
String avatar="";
String imageUri ="";
String imageUri2 ="";
String imageUri3 ="";
String imageUri4 ="";
bool hasData=false;
String uri="";
String extension="";
String type="";
String alt="";
String name="";
String data="";
String size="140";
String uri2="";
String extension2="";
String type2="";
String alt2="";
String name2="";
String data2="";
String size2="140";
String uri3="";
String extension3="";
String type3="";
String alt3="";
String name3="";
String data3="";
String size3="140";
String uri4="";
String extension4="";
String type4="";
String alt4="";
String name4="";
String data4="";
String size4="140";
bool showLargeScale=false;
String?  token1="";
String?  lang="";
String?  projectId="";

getValueFromPref()async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  lang =prefs!.getString("lang_id");//"en";
  projectId = prefs!.getString("project_id");//"1"
  token1=prefs!.getString("token");//"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
  // lang ="en";
  // projectId = "1";
  // token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
  showPresent();
}
getStatusPresent()
async {

  if (lang != null && lang!.trim().length > 0) {

    try {
      //  var response = await (Services()).UpdateProvider(token1,"09126666661","1","abc","aaa","4","en","korea","lawyer","bbb","");
      var response = await (Services()).getStatusPresent(token1!,projectId!,lang!);
      if (response['statusCode'] != null && response['statusCode'] == 200) {
        // setState(() {
        //   loginLoading = false;
        // });
        hasData=response['data']['status'];
        if(hasData)
        {
          showPresent();
        }
      } else {
        customNotification(true, response["message"], MediaQuery
            .of(context)
            .size
            .width, MediaQuery
            .of(context)
            .size
            .height);
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
List<AvatarModel> avatarList = [];
showPresent()
async {
//  String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
  setState(() {
    loginLoading=true;
  });
  var response = await (Services()).ShowPresentation(  token1!,lang!,projectId!);

  if (lang != null && lang!.trim().length > 0) {

    try {
      if (response['statusCode'] != null && response['statusCode'] == 200) {
          response['data'].forEach((element){
            avatarList.add(AvatarModel .fromJson(element));
          //  taradods.add(TaradodListModel.fromJson(element));
          });
          int index=0;
          if(avatarList.length>4)
            index=avatarList.length-4;
          for( int i = index; i < avatarList.length; i++){
            if(i==index)
            imageUri=avatarList[i].uri;
            if(i==index+1)
              imageUri2=avatarList[i].uri;
            if(i==index+2)
              imageUri3=avatarList[i].uri;
            if(i==index+3)
              imageUri4=avatarList[i].uri;
          }
        setState(() {
          loginLoading=false;
        });
            // uri=response["data"]["avatar"]??"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";
        //  extension='png';
        //  type='avatar';
        //  size='150192';
        //  name='image.png';
        //  alt='image.png';
        //  data='';
        //  imageUri=uri;//"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//response["data"]["avatar"];
        //  setState(() {
        //    //  loginLoading = false;
        //  });


      } else {
        customNotification(true, response["message"], MediaQuery
            .of(context)
            .size
            .width, MediaQuery
            .of(context)
            .size
            .height);
        //_passCtrl.text = "";
        // setState(() {
        //   loginLoading = false;
        // });
      }
    } catch (error) {
      print(error);
      setState(() {
         loginLoading = false;
      });
    }
  }
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
@override
  initState()  {
    super.initState();
    // lang ="en"; //prefs!.getString("lang_id");
    // projectId = "1";//prefs!.getString("project_id");
    // token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
   // getStatusPresent();
    getValueFromPref();
  //  showPresent();
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
                            colors: [widget.backgroundColor!, widget.backgroundColor!.withOpacity(0.1)]
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
                          Text('  Images',
                            style: const TextStyle(
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 15 ,
                              color:Colors.white  ,
                              //  fontWeight: FontWeight.bold,
                            ),
                          ),    Padding(
                              padding:  EdgeInsets.only(top: 320.sp),child:
                          Text('  videos',
                            style: const TextStyle(
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 15 ,
                              color:Colors.white  ,
                              //  fontWeight: FontWeight.bold,
                            ),
                          )
                          )

                        ])
                    )
                ),
              ),

              !showLargeScale?   Positioned(
                  top:260,
                  left: 15,
                  child:
                  GestureDetector(
                      onTap: () async {
                        setState(() {
                          showLargeScale=true;
                          largeImageUrl=imageUri;
                        });
                      },child:  imageUri.length<5?Container():
                  Container(
                      height: 165.sp,
                      width: 180.sp,
                      decoration: BoxDecoration(
                        //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                      //    color: Colors.white60,
                          border: Border.all(color:Colors.white) ,
                          borderRadius: BorderRadius.circular(20)),child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    // Image border
                    child: SizedBox.fromSize(

                      size: Size.fromRadius(88), // Image radius
                      child:

                     Image.network(imageUri, fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                    ),
                  ))
                  // Container(
                  //     height: 165.sp,
                  //     width: 180.sp,
                  //     decoration: BoxDecoration(
                  //       //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                  //     //    color: Colors.white60,
                  //         border: Border.all(color:Colors.white) ,
                  //         borderRadius: BorderRadius.circular(10)),
                  //     child:
                  //     CachedNetworkImage(
                  //         imageUrl:imageUri,
                  //         progressIndicatorBuilder: (context, url, downloadProgress) =>
                  //             Container(
                  //               margin: new EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                  //               width: 10,
                  //               height: 10,
                  //               child: const CircularProgressIndicator(
                  //                 color: bgbuttonRed,
                  //                 strokeWidth: 3,
                  //               ),
                  //             ),
                  //         errorWidget: (context, url, error) {
                  //        //   print("hey you:"+error);
                  //           return   Icon(Icons.error);
                  //         }
                  //     )
                  //   //    Image.asset("assets/images/migrate4.png", fit: BoxFit.cover),
                  //     )
                  )
              ):Container(),
              !showLargeScale?   Positioned(
                  top:350,
                  left: 30,
                  child:
                  GestureDetector(
                      onTap: () async {
                        setState(() {
                          showLargeScale=true;
                          largeImageUrl=imageUri2;
                        });
                      },child:  imageUri2.length<5?Container():
                  Container(
                    height: 165.sp,
                    width: 170.sp,
                    decoration: BoxDecoration(
                        border: Border.all(color:Colors.white) ,
                        borderRadius: BorderRadius.circular(20)),

                  child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                  // Image border
                    child: SizedBox.fromSize(

                      size: Size.fromRadius(88), // Image radius
                      child:

                      Image.network(imageUri2, fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ))
                  // Container(
                  //   height: 165.sp,
                  //   width: 170.sp,
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color:Colors.white) ,
                  //       borderRadius: BorderRadius.circular(10)),
                  //
                  // child:
                  //   CachedNetworkImage(
                  //       imageUrl: imageUri2,
                  //       progressIndicatorBuilder: (context, url, downloadProgress) =>
                  //           Container(
                  //             margin: new EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                  //             width: 10,
                  //             height: 10,
                  //             child: const CircularProgressIndicator(
                  //               color: bgbuttonRed,
                  //               strokeWidth: 3,
                  //             ),
                  //           ),
                  //       errorWidget: (context, url, error) {
                  //        // print("hey you:"+error);
                  //         return   Icon(Icons.error);
                  //       }
                  //   )
                  //  // Image.asset("assets/images/migrate3.png", fit: BoxFit.cover),
                  // )
             // )
                  )
              ):Container(),
              !showLargeScale?   Positioned(
                  top:260,
                  left: 140,
                  child:
                  GestureDetector(
                      onTap: () async {
                        setState(() {
                          largeImageUrl=imageUri3;
                          showLargeScale=true;
                        });
                      },child:  imageUri3.length<5?Container():
                  Container(
                      height: 165.sp,
                      width: 170.sp,
                      decoration: BoxDecoration(
                          border: Border.all(color:Colors.white) ,
                          borderRadius: BorderRadius.circular(20)),child:
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    // Image border
                    child: SizedBox.fromSize(

                      size: Size.fromRadius(88), // Image radius
                      child:

                      Image.network(imageUri3, fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ))
                  // Container(
                  //   height: 165.sp,
                  //   width: 180.sp,
                  //   decoration: BoxDecoration(
                  //     //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                  //     //    color: Colors.white60,
                  //     //  border: Border.all(color:Colors.white) ,
                  //       borderRadius: BorderRadius.circular(10)),
                  //   child:
                  //   CachedNetworkImage(
                  //       imageUrl: imageUri3,
                  //       progressIndicatorBuilder: (context, url, downloadProgress) =>
                  //           Container(
                  //             margin: new EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                  //             width: 10,
                  //             height: 10,
                  //             child: const CircularProgressIndicator(
                  //               color: bgbuttonRed,
                  //               strokeWidth: 3,
                  //             ),
                  //           ),
                  //       errorWidget: (context, url, error) {
                  //     //    print("hey you:"+error.toString());
                  //         return   Icon(Icons.error);
                  //       }
                  //   )
                  //  // Image.asset("assets/images/migrate1.png", fit: BoxFit.fitWidth),
                  // )
                  )
              ):Container(),
              !showLargeScale?      Positioned(
                  top:350,
                  left: 180.sp,
                  child:
                  GestureDetector(
                      onTap: () async {
                        setState(() {
                          showLargeScale=true;
                          largeImageUrl=imageUri4;
                        });
                      },
                      child:

                      imageUri4.length<5?Container():
                      // Container(
                      //   height: 165.sp,
                      //   width: 190.sp.sp,
                      //   decoration: BoxDecoration(
                      //     //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                      //     //    color: Colors.white60,
                      //     //  border: Border.all(color:Colors.white) ,
                      //       borderRadius: BorderRadius.circular(10)),
                      //   child:
                      Container(
                          height: 165.sp,
                          width: 170.sp,
                          decoration: BoxDecoration(
                              border: Border.all(color:Colors.white) ,
                              borderRadius: BorderRadius.circular(20)),child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        // Image border
                        child: SizedBox.fromSize(

                          size: Size.fromRadius(88), // Image radius
                          child:

                          Image.network(imageUri4, fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ))
                  // Container(
                  //   height: 165.sp,
                  //   width: 190.sp.sp,
                  //   decoration: BoxDecoration(
                  //     //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                  //     //    color: Colors.white60,
                  //     //  border: Border.all(color:Colors.white) ,
                  //       borderRadius: BorderRadius.circular(10)),
                  //   child:
                  //   CachedNetworkImage(
                  //       imageUrl: imageUri4,
                  //       progressIndicatorBuilder: (context, url, downloadProgress) =>
                  //           Container(
                  //             margin: new EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                  //             width: 10,
                  //             height: 10,
                  //             child: const CircularProgressIndicator(
                  //               color: bgbuttonRed,
                  //               strokeWidth: 3,
                  //             ),
                  //           ),
                  //       errorWidget: (context, url, error) {
                  //        // print("hey you:"+error);
                  //         return   Icon(Icons.error);
                  //       }
                  //   )
                  //   //Image.asset("assets/images/migrate2.png", fit: BoxFit.cover),
                  // )
                  )
              ):Container(),
              showLargeScale?       Positioned(
                  top:280.sp,
                  left: 15.sp,
                  child:
                  GestureDetector(
                      onTap: () async {
                        setState(() {
                          showLargeScale=false;
                        });
                      },child:
                  Container(
                    height: 280.sp,
                    width: 340.sp,
                    decoration: BoxDecoration(
                      //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                      //    color: Colors.white60,
                       border: Border.all(color:Colors.white,width: 2) ,
                        borderRadius: BorderRadius.circular(20)),
                    child:
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      // Image border
                      child: SizedBox.fromSize(

                        size: Size.fromRadius(88), // Image radius
                        child:

                        Image.network(largeImageUrl!, fit: BoxFit.cover),
                      ),
                    )
                    // CachedNetworkImage(
                    //     imageUrl:largeImageUrl!,
                    //     progressIndicatorBuilder: (context, url, downloadProgress) =>
                    //         Container(
                    //           margin: new EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                    //           width: 10,
                    //           height: 10,
                    //           child: const CircularProgressIndicator(
                    //             color: bgbuttonRed,
                    //             strokeWidth: 3,
                    //           ),
                    //         ),
                    //     errorWidget: (context, url, error) {
                    //      // print("hey you:"+error);
                    //       return   Icon(Icons.error);
                    //     }
                    // )
                  //  Image.asset("assets/images/$largeImageUrl", fit: BoxFit.fitWidth),
                  ))
              ):Container(),
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
                  GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ExtraIntroduction(providerModel: widget.providerModel!,backgroundColor: widget.backgroundColor!,buttonColorColor: widget.buttonColorColor!,bgtextColor: widget.buttonColorColor!,)),
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
                        height: 32,
                        width:32,
                        child:
                        Image.asset("assets/images/extra.png", fit: BoxFit.cover),
                      ))))
              ),
              largeImageUrl==null||largeImageUrl!.length<5?Container():    Positioned(
                  top: MediaQuery.of(context).size.height*0.7,
                  left: 15.sp,
                  child:
                  GestureDetector(
                      onTap: () async {
                        setState(() {
                          showLargeScale=false;
                        });
                      },child:

                  Container(
                    height: 280.sp,
                    width:  MediaQuery.of(context).size.width*0.79,
                    decoration: BoxDecoration(
                      //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                        // color: Colors.green,
                       border: Border.all(color:Colors.white,  width: 2.0,) ,
                        borderRadius: BorderRadius.circular(20)),
                    child:
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      // Image border
                      child: SizedBox.fromSize(

                        size: Size.fromRadius(88), // Image radius
                        child:
                        Image.asset("assets/images/migrate1.png", fit: BoxFit.cover),
                    //    Image.network(largeImageUrl!, fit: BoxFit.cover),
                      ),
                    )
                    //Image.asset("assets/images/migrate1.png", fit: BoxFit.cover),
                  )
                  )
              ),
             Positioned(
        top:MediaQuery.of(context).size.height*0.46,
          left:MediaQuery.of(context).size.width*0.38,
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
            ])

        )
    );



  }

}
