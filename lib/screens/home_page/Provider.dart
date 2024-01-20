
import 'package:email_validator/email_validator.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Provider extends StatefulWidget {
  const Provider({Key? key}) : super(key: key);

  @override
  State<Provider> createState() => ProviderState();
}

class ProviderState extends State<Provider>
    with TickerProviderStateMixin
{
bool showYellowBirdlogo=false;
bool isClickBird=false;
String title="Personal Information";
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
int clickIndex=0;
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
List<Animation<Offset>>? _offsetAnimation;
@override
void dispose() {
  // Clean up the controller when the widget is removed from the widget tree.
  // This also removes the _printLatestValue listener.
  _passCtrl.dispose();
  _rePassCtrl.dispose();
  _usernameCtrl.dispose();
  animationController!.dispose();
  _controller!.dispose();
  super.dispose();
}
Animation<double>? animation;
Animation<double>? extraAnimation;
AnimationController? animationController;
AnimationController? _controller;
AnimationController? _extraController;
Animation<double>? _fadeInFadeOut;
void _animate() {
  // animation!.status == AnimationStatus.completed
  //     ? animation!.reverse()
  //     : animation!.forward();
  clickIndex=1;
  animationController!.forward();
  title="Image and Videos";
  setState(() {

  });

}
void _animate2() {
  _controller!.forward();
  clickIndex=2;
  title="Business Plan";
  setState(() {
  });
}
void _animate3() {
  title="Extra Information";
  _extraController!.forward();
  clickIndex=3;
  setState(() {
  });
}
@override
  initState()  {
    super.initState();
    _emailController= TextEditingController(text: "");
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3),);
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _extraController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
     animation = Tween<double>(begin: 0, end:27).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    extraAnimation = Tween<double>(begin: 0, end:27).animate(_extraController!)
      ..addListener(() {
        setState(() {});
      });
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.5).animate(animationController!);
   // animationController!.forward();
   // _controller!.forward();
 //  animation!.forward();
  //   animation!.addStatusListener((status){
  //     if(status == AnimationStatus.completed){
  //       animation!.reverse();
  //     }
  //     else if(status == AnimationStatus.dismissed){
  //       animation!.forward();
  //     }
  //  });
   // animation!.forward();
    if(mounted){

    }
  }
Login2(String email)
async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? lang = prefs.getString("lang_id");
  if(lang!=null&&lang.trim().length>0){
    setState(() {
      loginLoading=true;
    });
    try{
      var response = await (Services()).Login(
        // email,lang, _passCtrl.text);
         email,lang, email);
      String token = "";
      if (response['statusCode'] != null &&response['statusCode']==200)
      {
        setState(() {
          loginLoading=false;
        });
        if(response["data"]['access_token']!=null)
          token = response["data"]['access_token'].toString();
        if (token != null && token
            .toString()
            .trim()
            .length > 1) {
          storeEmail(_emailController!.text);
          storeToken(token);
         // customNotification(false, 'you are signed in as a ${email}', MediaQuery
         //      .of(context)
         //      .size
         //      .width, MediaQuery
         //      .of(context)
         //      .size
         //      .height);
          Navigator.pushNamed(context,"/main_tab_bar");
          _usernameCtrl.text="";
          _passCtrl.text="";
        }
      }else
      {
        customNotification(true,response["message"],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
        _usernameCtrl.text="";
        _passCtrl.text="";
        setState(() {
          loginLoading=false;
        });
      }
    } catch (error) {
      print(error);
      setState(() {
        loginLoading=false;
      });
    }
  }}

final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor:  bglightRed, //Colors.white,//backgroundColor,
        body:
        Form(
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
              Text('$title',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color:  Colors.white24,))),
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
           //   Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.45,),
              Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.width*0.52,),
                child:
              clickIndex==1?
              FadeTransition(
               opacity: _fadeInFadeOut!,child:
              Container(
                  height: MediaQuery.of(context).size.height*0.69,
                  width: MediaQuery.of(context).size.width*0.86,
                  decoration: BoxDecoration(
                    //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(30)),
                  child:
                  new SingleChildScrollView(child:
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20,),
                        // Text("Personal Information",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                        // SizedBox(height: 15,),

                        Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top: 10),
                            child:
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(

                                      onTap: () async {},
                                      child:
                                      Container(
                                          height: 140.sp,
                                          width: 130.sp,
                                          decoration: BoxDecoration(
                                            //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                              color: Colors.white24,
                                              borderRadius: BorderRadius.circular(10)),
                                          child:Center(child:      SizedBox(
                                            height: 50,
                                            width:50,
                                            child:
                                            Image.asset("assets/images/plusVideo.png", fit: BoxFit.cover),
                                          )))

                                  ),
                                  GestureDetector(

                                      onTap: () async {},
                                      child:
                                      Container(
                                          height: 140.sp,
                                          width: 130.sp,
                                          decoration: BoxDecoration(
                                            //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                              color: Colors.white24,
                                              borderRadius: BorderRadius.circular(10)),
                                          child:Center(child:      SizedBox(
                                            height: 50,
                                            width:50,
                                            child:
                                            Image.asset("assets/images/plusVideo.png", fit: BoxFit.cover),
                                          )))

                                  )])
                        ),
                        Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:20),
                            child:
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround
                                ,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(

                                      onTap: () async {},
                                      child:
                                      Container(
                                          height: 140.sp,
                                          width: 130.sp,
                                          decoration: BoxDecoration(
                                            //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                              color: Colors.white24,
                                              borderRadius: BorderRadius.circular(10)),
                                          child:Center(child:      SizedBox(
                                            height: 50,
                                            width:50,
                                            child:
                                            Image.asset("assets/images/plusVideo.png", fit: BoxFit.cover),
                                          )))

                                  ),
                                  GestureDetector(

                                      onTap: () async {},
                                      child:
                                      Container(
                                          height: 140.sp,
                                          width: 130.sp,
                                          decoration: BoxDecoration(
                                            //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                              color: Colors.white24,
                                              borderRadius: BorderRadius.circular(10)),
                                          child:Center(child:      SizedBox(
                                            height: 50,
                                            width:50,
                                            child:
                                            Image.asset("assets/images/plusVideo.png", fit: BoxFit.cover),
                                          )))

                                  )])
                        ),
                        Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:20),
                            child:
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(

                                      onTap: () async {},
                                      child:
                                      Container(
                                          height: 140.sp,
                                          width: 130.sp,
                                          decoration: BoxDecoration(
                                            //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                              color: Colors.white24,
                                              borderRadius: BorderRadius.circular(10)),
                                          child:Center(child:      SizedBox(
                                            height: 50,
                                            width:50,
                                            child:
                                            Image.asset("assets/images/plusVideo.png", fit: BoxFit.fill),
                                          )))

                                  ),
                                  GestureDetector(

                                      onTap: () async {},
                                      child:
                                      Container(
                                          height: 140.sp,
                                          width: 130.sp,
                                          decoration: BoxDecoration(
                                            //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                              color: Colors.white24,
                                              borderRadius: BorderRadius.circular(10)),
                                          child:Center(child:      SizedBox(
                                            height: 50,
                                            width:50,
                                            child:
                                            Image.asset("assets/images/plusVideo.png", fit: BoxFit.cover),
                                          )))

                                  )])
                        ),
                        Padding(
                            padding:  EdgeInsets.only(left:20,top:30.sp,right: 20),
                            child:
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                    child:Center(child: Text('Add',
                                      style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15 ,
                                        color:Colors.white  ,
                                        //  fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  )),
                                  GestureDetector(
                                      onTap: () async {
                                        Navigator.pushReplacementNamed(context, "/login");
                                        // Navigator.pushReplacementNamed(context, "/verification");
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) =>  DailyTask(taradod: taradodList[index],)),
                                        // );
                                        // if (_formKey.currentState!.validate()) {
                                        //
                                        // }
                                        //    Register();
                                      },child:
                                  Container(
                                    width: 120,
                                    height: 35.sp,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: bgbuttonRed),
                                        borderRadius: BorderRadius.circular(30.sp),
                                        color: bgbuttonRed//.withOpacity(0.1)
                                    ),
                                    child:Center(child: Text('Edit',
                                      style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15 ,
                                        color:Colors.white  ,
                                        //  fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  )
                                  ),
                                ]))

                      ])
                  )
              ))
               : clickIndex==2?
              Transform.translate(
                //   offset: Offset(0, 15),
                //  offset: Offset(2, animation!.value),
                  offset: Offset(0, animation!.value),child:
              Container(
                  height: MediaQuery.of(context).size.height*0.69,
                  width: MediaQuery.of(context).size.width*0.86,
                  decoration: BoxDecoration(
                    //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(30)),
                  child:
                  new SingleChildScrollView(child:
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20,),
                        // Text("Personal Information",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                        // SizedBox(height: 15,),

                        Padding(
                            padding:  EdgeInsets.only(left:20,right: 20),
                            child:
                            TextFormField(
                              style:TextStyle(color:Colors.white),
                              controller: _usernameCtrl,
                              onTap: (){

                              },
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter Email ';
                              //   }
                              //
                              //   return null;
                              // },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: "What business?",
                                hintStyle:TextStyle(color:Colors.white),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.5),
                                ),
                                alignLabelWithHint: false,
                                filled: true,
                              ),
                            )
                        ),
                        Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:20),
                            child:
                            Container(
                                height: 50.sp,
                                width: MediaQuery.of(context).size.width*0.88,
                                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white,width: 1.4),
                                  borderRadius: BorderRadius.circular(30.sp),
                                  //      color: bgbuttonRed//.withOpacity(0.1)
                                ),
                                child:
                                DropdownButton<String>(
                                  items: dropdownItems,
                                  // hint: new Text("Select"),
                                  dropdownColor: bgGray,
                                  value: _chosenSourceValue,
                                  hint: Text("Which Country",    style:TextStyle(color:Colors.white,fontSize:14 ,),),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _chosenSourceValue = value!;
                                    });
                                  },
                                ))),
                        Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:20),
                            child:
                            TextFormField(
                              style:TextStyle(color:Colors.white),
                              controller: _usernameCtrl,
                              onTap: (){

                              },
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter Email ';
                              //   }
                              //
                              //   return null;
                              // },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: "What requirement?",
                                hintStyle:TextStyle(color:Colors.white),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.5),
                                ),
                                alignLabelWithHint: false,
                                filled: true,
                              ),
                            )
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left:20,right: 20,top:20),
                          child:
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _ageController,
                            style:TextStyle(color:Colors.white,fontSize:14 ,),
                            onTap: (){

                            },

                            // style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              hintText: "How much take long?",
                              hintStyle:TextStyle(color:Colors.white),
                              labelStyle:TextStyle(color:Colors.white,),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.5),
                              ),

                              labelText: "How much take long?",
                              alignLabelWithHint: false,
                              filled: true,
                              // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left:20,right: 20,top:20),
                          child:
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _yearController,
                            style:TextStyle(color:Colors.white,fontSize:14 ,),
                            onTap: (){

                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Year ';
                              }
                              else
                              if (int.parse( value) <1) {
                                return 'Please enter  valid year';
                              }
                              return null;
                            },
                            // style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              hintText: "Price",
                              hintStyle:TextStyle(color:Colors.white),
                              labelStyle:TextStyle(color:Colors.white,),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.5),
                              ),

                              labelText: "Price",
                              alignLabelWithHint: false,
                              filled: true,
                              // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                            ),
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(left:20,right: 20,top:20),
                          child:
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            controller: _addressController,
                            style:TextStyle(color:Colors.white,fontSize:14 ,),
                            onTap: (){
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: "More Description",
                              hintStyle:TextStyle(color:Colors.white),
                              labelStyle:TextStyle(color:Colors.white,),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.5),
                              ),

                              labelText: "More Description",
                              alignLabelWithHint: false,
                              filled: true,
                              // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                            ),
                          ),
                        ),
                        Padding(
                            padding:  EdgeInsets.only(left:20,top:20.sp,bottom: 0,right: 20),
                            child:
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                    child:Center(child: Text('Add',
                                      style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15 ,
                                        color:Colors.white  ,
                                        //  fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  )),
                                  GestureDetector(
                                      onTap: () async {
                                        Navigator.pushReplacementNamed(context, "/login");
                                        // Navigator.pushReplacementNamed(context, "/verification");
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) =>  DailyTask(taradod: taradodList[index],)),
                                        // );
                                        // if (_formKey.currentState!.validate()) {
                                        //
                                        // }
                                        //    Register();
                                      },child:
                                  Container(
                                    width: 120,
                                    height: 35.sp,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: bgbuttonRed),
                                        borderRadius: BorderRadius.circular(30.sp),
                                        color: bgbuttonRed//.withOpacity(0.1)
                                    ),
                                    child:Center(child: Text('Edit',
                                      style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15 ,
                                        color:Colors.white  ,
                                        //  fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  )
                                  ),
                                ]))

                      ])
                  )
              )):
              clickIndex==3?
              Transform.translate(
                  offset: Offset(0, extraAnimation!.value),child:
              Container(
                  height: MediaQuery.of(context).size.height*0.69,
                  width: MediaQuery.of(context).size.width*0.86,
                  decoration: BoxDecoration(
                    //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(30)),
                  child:
                  new SingleChildScrollView(child:
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20,),
                        // Text("Personal Information",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                        // SizedBox(height: 15,),

                        Padding(
                            padding:  EdgeInsets.only(left:20,right: 20),
                            child:
                            TextFormField(
                              style:TextStyle(color:Colors.white),
                              controller: _usernameCtrl,
                              onTap: (){

                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: "Total Uers",
                                hintStyle:TextStyle(color:Colors.white),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.5),
                                ),
                                alignLabelWithHint: false,
                                filled: true,
                              ),
                            )
                        ),
                        Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:20),
                            child:
                            Container(
                                height: 50.sp,
                                width: MediaQuery.of(context).size.width*0.88,
                                padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white,width: 1.4),
                                  borderRadius: BorderRadius.circular(30.sp),
                                  //      color: bgbuttonRed//.withOpacity(0.1)
                                ),
                                child:
                                DropdownButton<String>(
                                  items: dropdownItems,
                                  // hint: new Text("Select"),
                                  dropdownColor: bgGray,
                                  value: _chosenSourceValue,
                                  hint: Text("Active Users",    style:TextStyle(color:Colors.white,fontSize:14 ,),),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _chosenSourceValue = value!;
                                    });
                                  },
                                ))),
                        Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:20),
                            child:
                            TextFormField(
                              style:TextStyle(color:Colors.white),
                              controller: _usernameCtrl,
                              onTap: (){

                              },
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter Email ';
                              //   }
                              //
                              //   return null;
                              // },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: "Successful Users",
                                hintStyle:TextStyle(color:Colors.white),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.5),
                                ),
                                alignLabelWithHint: false,
                                filled: true,
                              ),
                            )
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left:20,right: 20,top:20),
                          child:
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _ageController,
                            style:TextStyle(color:Colors.white,fontSize:14 ,),
                            onTap: (){

                            },

                            // style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              hintText: "Total Businesses",
                              hintStyle:TextStyle(color:Colors.white),
                              labelStyle:TextStyle(color:Colors.white,),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.5),
                              ),

                              labelText: "Total Businesses",
                              alignLabelWithHint: false,
                              filled: true,
                              // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left:20,right: 20,top:20),
                          child:
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _yearController,
                            style:TextStyle(color:Colors.white,fontSize:14 ,),
                            onTap: (){

                            },
                            // style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              hintText: "Active Businesses",
                              hintStyle:TextStyle(color:Colors.white),
                              labelStyle:TextStyle(color:Colors.white,),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.5),
                              ),

                              labelText: "Active Businesses",
                              alignLabelWithHint: false,
                              filled: true,
                              // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left:20,right: 20,top:20),
                          child:
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            controller: _addressController,
                            style:TextStyle(color:Colors.white,fontSize:14 ,),
                            onTap: (){
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              hintText: "Successful Businesses",
                              hintStyle:TextStyle(color:Colors.white),
                              labelStyle:TextStyle(color:Colors.white,),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.5),
                              ),

                              labelText: "Successful Businesses",
                              alignLabelWithHint: false,
                              filled: true,
                              // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                            ),
                          ),
                        ),
                        Padding(
                            padding:  EdgeInsets.only(left:20,top:20.sp,bottom: 0,right: 20),
                            child:
                            Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                    child:Center(child: Text('Add',
                                      style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15 ,
                                        color:Colors.white  ,
                                        //  fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  )),
                                  GestureDetector(
                                      onTap: () async {
                                        Navigator.pushReplacementNamed(context, "/login");
                                        // Navigator.pushReplacementNamed(context, "/verification");
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) =>  DailyTask(taradod: taradodList[index],)),
                                        // );
                                        // if (_formKey.currentState!.validate()) {
                                        //
                                        // }
                                        //    Register();
                                      },child:
                                  Container(
                                    width: 120,
                                    height: 35.sp,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: bgbuttonRed),
                                        borderRadius: BorderRadius.circular(30.sp),
                                        color: bgbuttonRed//.withOpacity(0.1)
                                    ),
                                    child:Center(child: Text('Edit',
                                      style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15 ,
                                        color:Colors.white  ,
                                        //  fontWeight: FontWeight.bold,
                                      ),
                                    )),
                                  )
                                  ),
                                ]))

                      ])
                  )
              )):
              Transform.translate(
                offset: Offset(0, extraAnimation!.value),child:
              Container(
                    height: MediaQuery.of(context).size.height*0.7,
                    width: MediaQuery.of(context).size.width*0.86,
                    decoration: BoxDecoration(
                      //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(30)),
                    child:
                    new SingleChildScrollView(child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 15,),
                          // Text("Personal Information",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                          // SizedBox(height: 15,),

                          Padding(
                            padding:  EdgeInsets.only(left:20,right: 20),
                            child:
                            TextFormField(
                              style:TextStyle(color:Colors.white),
                              controller: _usernameCtrl,
                              onTap: (){

                              },

                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: "Name",
                                hintStyle:TextStyle(color:Colors.white),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.5),
                                ),
                                alignLabelWithHint: false,
                                filled: true,
                              ),
                            )
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left:20,right: 20,top:10),
                              child:
                              TextFormField(
                                style:TextStyle(color:Colors.white),
                                controller: _usernameCtrl,
                                onTap: (){

                                },

                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  border: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  hintText: "NickName",
                                  hintStyle:TextStyle(color:Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.5),
                                  ),
                                  alignLabelWithHint: false,
                                  filled: true,
                                ),
                              )
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left:20,right: 20,top:10),
                              child:
                              TextFormField(
                                style:TextStyle(color:Colors.white),
                                controller: _usernameCtrl,
                                onTap: (){

                                },

                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  border: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  hintText: "FullName",
                                  hintStyle:TextStyle(color:Colors.white),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.5),
                                  ),
                                  alignLabelWithHint: false,
                                  filled: true,
                                ),
                              )
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:10),
                            child:
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _ageController,
                              style:TextStyle(color:Colors.white,fontSize:14 ,),
                              onTap: (){

                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Age ';
                                }
                                else
                                if (int.parse( value) <1) {
                                  return 'Please enter  valid Age';
                                }
                                return null;
                              },
                              // style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: "Age",
                                hintStyle:TextStyle(color:Colors.white),
                                labelStyle:TextStyle(color:Colors.white,),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.5),
                                ),

                                labelText: "Age",
                                alignLabelWithHint: false,
                                filled: true,
                                // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:20),
                            child:
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _yearController,
                              style:TextStyle(color:Colors.white,fontSize:14 ,),
                              onTap: (){

                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Year ';
                                }
                                else
                                if (int.parse( value) <1) {
                                  return 'Please enter  valid year';
                                }
                                return null;
                              },
                              // style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: "Work exprience(year)",
                                hintStyle:TextStyle(color:Colors.white),
                                labelStyle:TextStyle(color:Colors.white,),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.5),
                                ),

                                labelText: "Work exprience(year)",
                                alignLabelWithHint: false,
                                filled: true,
                                // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                              ),
                            ),
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left:20,right: 20,top:10),
                              child:
                              Container(
                                  height: 50.sp,
                                  width: MediaQuery.of(context).size.width*0.88,
                                  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white,width: 1.4),
                                    borderRadius: BorderRadius.circular(30.sp),
                                    //      color: bgbuttonRed//.withOpacity(0.1)
                                  ),
                                  child:
                                  DropdownButton<String>(
                                    items: dropdownItems,
                                    // hint: new Text("Select"),
                                    dropdownColor: bgGray,
                                    value: _chosenSourceValue,
                                    hint: Text("Country",    style:TextStyle(color:Colors.white,fontSize:14 ,),),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _chosenSourceValue = value!;
                                      });
                                    },
                                  ))),
                          Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:10),
                            child:
                            TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _addressController,
                              style:TextStyle(color:Colors.white,fontSize:14 ,),
                              onTap: (){

                              },

                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: "Address",
                                hintStyle:TextStyle(color:Colors.white),
                                labelStyle:TextStyle(color:Colors.white,),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.5),
                                ),

                                labelText: "Address",
                                alignLabelWithHint: false,
                                filled: true,
                                // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:10),
                            child:
                            TextFormField(
                              style:TextStyle(color:Colors.white,fontSize:14 ,),
                              controller: _usernameCtrl,
                              onTap: (){
                                // setState(() {
                                //   openGetDateDialog(setState, context, _dateToController);
                                // });
                              },
                              validator: (text) {
                                if (text.toString().split(' ').length > 35) {
                                  return 'Reached max words';
                                }
                                else if( ! EmailValidator.validate(text!))
                                {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              // style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: "Email",
                                hintStyle:TextStyle(color:Colors.white),
                                labelStyle:TextStyle(color:Colors.white),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.5),
                                ),

                                labelText: "Email",
                                alignLabelWithHint: false,
                                filled: true,
                                // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:10),
                            child:
                            TextFormField(

                              style:TextStyle(color:Colors.white,fontSize:14 ,),
                              controller: _usernameCtrl,
                              keyboardType: TextInputType.number,
                              onTap: (){
                                // setState(() {
                                //   openGetDateDialog(setState, context, _dateToController);
                                // });
                              },

                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: "Phone",
                                hintStyle:TextStyle(color:Colors.white),
                                labelStyle:TextStyle(color:Colors.white),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.0),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.5),
                                ),

                                labelText: "Phone",
                                alignLabelWithHint: false,
                                filled: true,
                                // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                              ),
                            ),
                          ),
                          Padding(
                        padding:  EdgeInsets.only(left:20,right: 20,top:10),   child:
                        TextFormField(
                          obscureText: !passwordVisible,
                          style:TextStyle(color:Colors.white),
                          controller: _passCtrl,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            hintText: "Password",
                            labelText: "Password",

                            // helperText:"Password must contain special character",
                            labelStyle:TextStyle(color:Colors.white),
                            alignLabelWithHint: false,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.5),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password ';
                            }
                            return null;
                          },
                        ),
                    ),
                        Padding(
                              padding:  EdgeInsets.only(left:20,top:10.sp,bottom: 0,right: 20),
                              child:
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                          //  Register("other");
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
                                      child:Center(child: Text('Verify',
                                        style: const TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15 ,
                                          color:Colors.white  ,
                                          //  fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    )),
                                    GestureDetector(
                                        onTap: () async {
                                           Navigator.pushReplacementNamed(context, "/login");
                                          // Navigator.pushReplacementNamed(context, "/verification");
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(builder: (context) =>  DailyTask(taradod: taradodList[index],)),
                                          // );
                                          // if (_formKey.currentState!.validate()) {
                                          //
                                          // }
                                      //    Register();
                                        },child:
                                    Container(
                                      width: 120,
                                      height: 35.sp,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: bgbuttonRed),
                                          borderRadius: BorderRadius.circular(30.sp),
                                          color: bgbuttonRed//.withOpacity(0.1)
                                      ),
                                      child:Center(child: Text('Edit',
                                        style: const TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15 ,
                                          color:Colors.white  ,
                                          //  fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    )
                                    ),
                                  ]))
                        ])
                    )
                )
              ),
              ),
              Positioned(
                top:MediaQuery.of(context).size.width*0.28,
                  left: 70,
                  child:
                  GestureDetector(
                  onTap: ()  {
                      _animate();
                  },child:
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
                      ))))
              ),
              Positioned(
                  top:MediaQuery.of(context).size.width*0.28,
                  left: 180.sp,
                  child:
                  GestureDetector(
                      onTap: ()  {
                        _animate2();
                      },child:
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
                      ))))
              ),
              Positioned(
                  top:MediaQuery.of(context).size.width*0.28,
                  left: 280.sp,
                  child:
                  GestureDetector(
                      onTap: ()  {
                        _animate3();
                      },child:
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
                      ))))
              )
            ]))

    //     Container(
    //   child: Center(
    //   child: FadeTransition(
    //   opacity: _fadeInFadeOut!,
    //   child: Container(
    //     color: Colors.green,
    //     width: 100,
    //     height: 100,
    //   ),
    // ),
    // )));
    );
  }

}
