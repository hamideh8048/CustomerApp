
import 'package:cached_network_image/cached_network_image.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/ProviderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ExtraIntroduction.dart';
import 'VideoIntroduction.dart';
import 'bPlanIntroduction.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key,required this.providerModel,required this.backgroundColor,required this.buttonColorColor,required this.bgtextColor}) : super(key: key);
final   ProviderModel providerModel;
  final   Color backgroundColor;
  final   Color buttonColorColor;
  final   Color bgtextColor;

  @override
  State<Introduction> createState() => IntroductionState();
}

class IntroductionState extends State<Introduction>
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
TextEditingController? _ageController=TextEditingController();
TextEditingController? _addressController=TextEditingController();
TextEditingController? _yearController=TextEditingController();
TextEditingController? _phoneController=TextEditingController();
  TextEditingController _usernameCtrl= TextEditingController();
  TextEditingController _passCtrl= TextEditingController();
  TextEditingController _rePassCtrl= TextEditingController();
  bool repasswordVisible=false;
  bool passwordVisible=false;

Animation<double>? animation1;
Animation<double>? animation2;
Animation<double>? animation3;
AnimationController? animationController1;
AnimationController? animationController2;
AnimationController? animationController3;
AnimationController? _extraController;
Animation<double>? _fadeInFadeOut;
void _animate() {
  // animation!.status == AnimationStatus.completed
  //     ? animation!.reverse()
  //     : animation!.forward();
  animationController1!.forward();
  title="Image and Videos";
  setState(() {
  });
}
@override
void dispose() {
  // Clean up the controller when the widget is removed from the widget tree.
  // This also removes the _printLatestValue listener.
  _passCtrl.dispose();
  _rePassCtrl.dispose();
  _usernameCtrl.dispose();
  animationController1!.dispose();
  animationController2!.dispose();
  super.dispose();
}


@override
  initState()  {
    super.initState();
    _emailController= TextEditingController(text: "");
    animationController1 = AnimationController(vsync: this, duration: Duration(seconds:2),);
    animationController3 = AnimationController(vsync: this, duration: Duration(seconds:2),);
    animationController2  = AnimationController(
  duration: const Duration(seconds: 7),
  vsync: this,
  );


    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.5).animate(animationController1!);
    animation1 = Tween<double>(begin: 0.0, end: 1).animate(animationController2!);
    animation2 = Tween<double>(begin: 0.0, end: 1).animate(animationController3!);
//    animation3 = Tween<double>(begin: 0.0, end: 1).animate(animationController3!);
    animationController1!.forward();
    animationController2!.forward();
    animationController3!.forward();
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

               right:MediaQuery.of(context).size.width*0.13,top:MediaQuery.of(context).size.width*0.54,),
                child:
                Container(
                    height: MediaQuery.of(context).size.height*0.75,
                    width: MediaQuery.of(context).size.width*0.86,
                    // padding: const EdgeInsets.only(left: 0.0),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [widget.backgroundColor, widget.backgroundColor.withOpacity(0.4)]
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
                                FadeTransition(
                                opacity: _fadeInFadeOut!,child:
SizedBox(width: 140,height: 140,child:

// CircleAvatar(
//   radius: 30.0,
//   backgroundImage:
//   NetworkImage(widget.providerModel.profile),
//   backgroundColor: Colors.red,
// )
//
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

),


                            //   Image.asset("assets/images/img_2.png",width: 130.sp, fit: BoxFit.fill)),
                            FadeTransition(
                                opacity: animation1!,child:
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
                                    child:Center(child:
                                    Text('Contact',
                                      style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15 ,
                                        color:Colors.white  ,
                                        //  fontWeight: FontWeight.bold,
                                      ),
                                    )
                                    ),
                                  )
                                      ])
                            )
                                ])),
                        Padding(
                            padding:  EdgeInsets.only(left:20,top: 30 ),
                            child:
                            FadeTransition(
                                opacity: animation2!,child:
                          Container(
                            height: 35.sp,
                            width: 150,
                            //  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(10.sp),
                                color: widget.buttonColorColor //greyColor3
                            ),
                            child:Center(child: Text(widget.providerModel.first_name+""+widget.providerModel.last_name,
                              style:  TextStyle(
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 15 ,
                                color: widget.bgtextColor,//bgGray2   ,
                                //  fontWeight: FontWeight.bold,
                              ),
                            )),
                          )
                        )
                        ),
                       Padding(
                              padding:  EdgeInsets.only(left:20,top: 10 ),
                              child:
                              FadeTransition(
                                  opacity: animation2!,child:
                              Container(
                                height: 30.sp,
                                width: 65.sp,
                                //  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    color: widget.buttonColorColor//.withOpacity(0.1)
                                ),
                                child:
                                Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                    Image.asset("assets/images/star.png",width: 20.sp, fit: BoxFit.fill),

                                Text('8.8',
                                  style:  TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15 ,
                                    color: widget.bgtextColor   ,
                                ))],
                              )))
                          ),
                        FadeTransition(
                            opacity: animation1!,child:
                        Padding(
                            padding:  EdgeInsets.only(left:20,top:30.sp ),
                            child:
                                Text('Immigration Lawer',
                                    style:  TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24 ,
                                      color:  widget.buttonColorColor//greyColor3  ,
                                    ))
                            )),
                        FadeTransition(
                            opacity: animation1!,child:
                         Padding(
                              padding:  EdgeInsets.only(left:20,top:30.sp,right: 100 ),
                              child:

                              Text('Principal Attorney at a law firm with 7 years experience  in Immigration Law',
                                  maxLines:3,
                                  style:  TextStyle(
                                    height: 1.5,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15 ,
                                    color:  widget.buttonColorColor//greyColor3  ,
                                  ))

                          )),

                          Padding(
                              padding:  EdgeInsets.only(left:20,top:50.sp ),
                              child:
                              FadeTransition(
                                  opacity: animation1!,child:
                              Text('Help with visas, citizenship, green cards, naturalization applications',
                                  maxLines:4,
                                  style:  TextStyle(
                                    decoration: TextDecoration.underline,

                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13 ,
                                    color: widget.buttonColorColor  ,
                                  ))
                              )
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left:20,top:20.sp ),
                              child:
                              FadeTransition(
                                  opacity: animation1!,child:
                              Text('Building and promoting business',
                                  maxLines:4,
                                  style:  TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13 ,
                                    color: widget.buttonColorColor// greyColor3  ,
                                  ))
                              )
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left:20,top:20.sp ),
                              child:
                              FadeTransition(
                                  opacity: animation1!,child:
                              Text('Full-Service legal support for business and private clients',
                                  maxLines:4,
                                  style:  TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13 ,
                                    color:  widget.buttonColorColor//greyColor3  ,
                                  ))
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
                          MaterialPageRoute(builder: (context) =>  ExtraIntroduction(providerModel: widget.providerModel,backgroundColor: widget.backgroundColor,buttonColorColor: widget.buttonColorColor,bgtextColor: widget.buttonColorColor,)),
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
              )
            ]))
    );



  }

}
