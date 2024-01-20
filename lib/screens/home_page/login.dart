import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/screens/home_page/widgets/BoxSwapWidget.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login>
    with SingleTickerProviderStateMixin {

  bool showYellowBirdlogo=false;
  bool isClickBird=false;
  String title="Yellowjay server";
  Color bgcolor=bgYellow;
  ScrollController? scrollController;
  bool pageLoading = true;
  bool gmailLoading = true;
  String companyName="";
  TextEditingController? _emailController;
  TextEditingController? _refController;
  String companyLogo="";
  bool loading=false;
  bool showSignup=false;
  bool loginLoading=false;
  bool rememberme=false;
  TextEditingController _usernameCtrl= TextEditingController();
  TextEditingController _firstnameCtrl= TextEditingController();
  TextEditingController _lastnameCtrl= TextEditingController();
  TextEditingController _passCtrl= TextEditingController();
  AnimationController? _controller;
  List<Animation<Offset>>? _offsetAnimation;
  TextEditingController _rePassCtrl= TextEditingController();
  bool repasswordVisible=false;
  saveProject(String token)
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString("lang_id");
    String? projectId = prefs.getString("project_id");
    if(lang!=null&&lang.trim().length>0){
      try{
        var response = await (Services()).updateProject(token,lang,projectId!);
        if (!(response['statusCode'] != null &&response['statusCode']==200))
        {
          customNotification(true,response["message"],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
          // _usernameCtrl.text="";
          // _passCtrl.text="";
          setState(() {
            pageLoading=false;
          });
        }
      } catch (error) {
        print(error);
        setState(() {
          pageLoading=false;
        });
      }
    }}

  Register(String type)
  async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? lang = prefs.getString("lang_id");
      if(lang!=null&&lang.trim().length>0){
        setState(() {
          loginLoading=true;
        });
        var response = await (Services()).register(
            _usernameCtrl.text,lang, _passCtrl.text,type,_firstnameCtrl.text,_lastnameCtrl.text);
        // String link = response["result"]['link'];
       // String token = "";
        if (response['statusCode'] != null &&response['statusCode']==200)
        {
          setState(() {
            loginLoading=false;
          });
          customNotification(false,response['message'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
         // Navigator.pushNamed(context,"/main_tab_bar");

          _usernameCtrl.text="";
          _passCtrl.text="";
          _rePassCtrl.text="";
          _firstnameCtrl.text="";
          _lastnameCtrl.text="";
        }
        else
        {
          customNotification(true,response["message"],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
          _usernameCtrl.text="";
          _passCtrl.text="";
          _firstnameCtrl.text="";
          _lastnameCtrl.text="";
          _rePassCtrl.text="";
          setState(() {
            loginLoading=false;
          });
        }}
    } catch (error) {
      print(error);
      setState(() {
        loginLoading=false;
      });
    }
  }

  void signOutGoogle() async{
    await _googleSignIn.signOut();
    print("User Sign Out");
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<User?> signInWithGoogle() async {

    setState(() {
      loading=true;
    });

    GoogleSignInAccount? googleSignInAccount;
    User? _user;
    try {
      googleSignInAccount =await _googleSignIn.signIn();

      // GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential authResult = await _auth.signInWithCredential(credential);
      User? _user = authResult.user;
      assert(!_user!.isAnonymous);
      assert(await _user!.getIdToken() != null);
      User? currentUser = await _auth.currentUser;
      assert(_user!.uid == currentUser!.uid);
      // model.state =ViewState.Idle;
      print("User Name: ${_user!.displayName}");
      print("User Email ${_user.email}");
      if(googleSignInAuthentication.idToken!=null&&googleSignInAuthentication.idToken!.trim().length>0) {
        storeToken(googleSignInAuthentication.idToken!);
        storeEmail(_user.email!);
      }
      // customNotification(false,'you are signed in as a ${_user!.email}',MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
      //Navigator.pushNamed(context,"/main_tab_bar");
      Login1(_user!.email!);
    } catch (error) {
      print(error);
      customNotification(true,error.toString(),MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);

      setState(() {
        loading=false;
      });
    }
    setState(() {
      loading=false;
    });

    // if(_user!=null){
    // customNotification(false,'you are signed in as a ${_user!.email}',MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
    // Navigator.pushNamed(context,"/main_tab_bar");}
  }
  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
  void _animate() {
    _controller!.status == AnimationStatus.completed
        ? _controller!.reverse()
        : _controller!.forward();
    setState(() {
      gmailLoading=false;
      showSignup=true;
    });

  }
  void _animate2() {
    _controller!.status == AnimationStatus.completed
        ? _controller!.reverse()
        : _controller!.forward();
    setState(() {
      showSignup=false;
    });

  }
  Login1(String email)
  async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString("lang_id");
    if(lang!=null&&lang.trim().length>0){
      setState(() {
        loginLoading=true;
      });

      try{
        var response = await (Services()).Login(email,lang, _passCtrl.text);
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
            saveProject(token);
            storeEmail(_emailController!.text);
            storeToken(token);
            // customNotification(false,  _usernameCtrl.text, MediaQuery
            //     .of(context)
            //     .size
            //     .width, MediaQuery
            //     .of(context)
            //     .size
            //     .height);
//change by hamide
            //Navigator.pushNamed(context,"/main_tab_bar");
            Navigator.pushNamed(context,"/video");
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

  @override
  initState()  {
    super.initState();
    const begin = Offset(0, 1);
    const end = Offset.zero;
    final tween = Tween(begin: begin, end: end);
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = List.generate(
      2,
          (index) => Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: Offset( 0.0,index == 0 ? 1 : -1,),
      ).animate(_controller!),
    );
    _emailController= TextEditingController(text: "");
    if(mounted){
      //  new Timer.periodic(const Duration(minutes: 1), (Timer t) => setState((){}));
      // getPersonelTraffic();
      //  getPersonelTrafficOffline();
    }
  }
  bool passwordVisible=false;

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
                Image.asset("assets/images/bglang.png", fit: BoxFit.fill),
              ),
            new SingleChildScrollView(child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      BoxSwapWidget(
                        callBack: _animate,
                        widget:
                        showSignup?
                        Container(
                            height: MediaQuery.of(context).size.height*0.49,
                            width: MediaQuery.of(context).size.width*0.88,
                            decoration: BoxDecoration(
                              //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(30)),
                            child:
                            new SingleChildScrollView(child:
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height:2,),
                                  Text("Sign Up",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                                  SizedBox(height: 5,),
                                  Padding(
                                      padding:  EdgeInsets.only(left:25,right: 25),
                                      child:
                                      gmailLoading?
                                      Container(
                                        width: 24,
                                        height: 24,
                                        padding: const EdgeInsets.all(2.0),
                                        child: const CircularProgressIndicator(
                                          color: bgbuttonRed,
                                          strokeWidth: 3,
                                        ),
                                      ):
                                      GestureDetector(
                                          onTap: () async {
                                            // RegisterforGoogle("aaa2@gmail.com");
                                            signInWithGoogle();
                                          },child:
                                      Container(
                                          width:  MediaQuery.of(context).size.width *0.85,
                                          height: 42.sp,
                                          decoration: BoxDecoration(
                                            //  border: Border.all(color: Colors.black87, width: 4),
                                            border:  Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(30),
                                            color:bgbuttonRed,
                                            shape: BoxShape.rectangle,
                                          ),
                                          child:
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:  EdgeInsets.only(left:45,right: 10),
                                                  child:
                                                  Image.asset("assets/images/google.png",width: 22,height: 22, ),),
                                                Text(
                                                  "Sign Up with Google",
                                                  style: const TextStyle(
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16 ,
                                                    color:Colors.white  ,
                                                    //  fontWeight: FontWeight.bold,
                                                  ),
                                                )

                                              ])
                                      ))),
                                  Padding(
                                      padding:  EdgeInsets.only(left:100,top:10,bottom: 10),
                                      child:
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:EdgeInsets.symmetric(horizontal:10.0),
                                              child:Container(
                                                height:1.0,
                                                width:50.0,
                                                color:Colors.white,),),
                                            Text(
                                              "OR",
                                              style: const TextStyle(
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13 ,
                                                color:Colors.white  ,
                                                //  fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding:EdgeInsets.symmetric(horizontal:10.0),
                                              child:Container(
                                                height:1.0,
                                                width:50.0,
                                                color:Colors.white,),)
                                          ])

                                  ),

                                  Padding(
                                      padding:  EdgeInsets.only(left:20,right: 20),
                                      child:
                                      TextFormField(
                                        style:TextStyle(color:Colors.white),
                                        controller: _usernameCtrl,
                                        onTap: (){

                                        },
                                        validator: (text) {
                                          if (text.toString().split(' ').length > 35) {
                                            //return 'Reached max words';
                                            return '';
                                          }
                                          else if( ! EmailValidator.validate(text!))
                                          {
                                           // return 'Please enter a valid email';
                                            return '';
                                          }
                                          return null;
                                        },
                                        // style: Theme.of(context).textTheme.bodyText1,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          hintText: "Email",
                                          labelText: "Email",

                                          hintStyle:TextStyle(color:Colors.white),
                                          labelStyle:TextStyle(color:Colors.white),
                                          prefixIcon:
                                          IconButton(
                                              onPressed: (){
                                              },
                                              icon: Image.asset(
                                                'assets/images/email2.png',width: 20,
                                              )),
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
                                      padding:  EdgeInsets.only(left:20,right: 20,top:5),
                                      child:
                                      TextFormField(
                                        style:TextStyle(color:Colors.white),
                                        controller: _firstnameCtrl,
                                        onTap: (){

                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return ' ';
                                          }

                                          return null;
                                        },
                                        // style: Theme.of(context).textTheme.bodyText1,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          hintText: "FirstName",
                                          labelText: "FirstName",

                                          hintStyle:TextStyle(color:Colors.white),
                                          labelStyle:TextStyle(color:Colors.white),
                                          prefixIcon:
                                          IconButton(
                                              onPressed: (){
                                              },
                                              icon: Image.asset(
                                                'assets/images/email2.png',width: 20,
                                              )),
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
                                      padding:  EdgeInsets.only(left:20,right: 20,top:5),
                                      child:
                                      TextFormField(
                                        style:TextStyle(color:Colors.white),
                                        controller: _lastnameCtrl,
                                        onTap: (){

                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return ' ';
                                          }
                                          return null;
                                        },
                                        // style: Theme.of(context).textTheme.bodyText1,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0),
                                          ),
                                          hintText: "LastName",
                                          labelText: "LastName",
                                          hintStyle:TextStyle(color:Colors.white),
                                          labelStyle:TextStyle(color:Colors.white),
                                          prefixIcon:
                                          IconButton(
                                              onPressed: (){
                                              },
                                              icon: Image.asset(
                                                'assets/images/email2.png',width: 20,
                                              )),
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
                                    padding:  EdgeInsets.only(left:20,right: 20,top:5),   child:
                                  TextFormField(
                                    obscureText: !passwordVisible,
                                    style:TextStyle(color:Colors.white),
                                    controller: _passCtrl,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      hintText: "Password",
                                      labelText: "Password",

                                      // helperText:"Password must contain special character",
                                      labelStyle:TextStyle(color:Colors.white),
                                      hintStyle:TextStyle(color:Colors.white),
                                      prefixIcon:

                                      IconButton(
                                        onPressed: (){

                                        },
                                        icon: Image.asset(
                                          'assets/images/lock.png',width: 20,
                                        ),
                                      ),
                                      alignLabelWithHint: false,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40.0),
                                        borderSide: const BorderSide(color: Colors.white),
                                      ),
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
                                       // return 'Please enter password ';
                                        return ' ';
                                      }
                                      return null;
                                    },
                                  ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(left: 20,top:5,right: 20),
                                    child:
                                    TextFormField(
                                      obscureText: !repasswordVisible,
                                      style:TextStyle(color:Colors.white),
                                      controller: _rePassCtrl,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        hintText: "RePassword",
                                        labelText: "RePassword",

                                        // helperText:"Password must contain special character",
                                        labelStyle:TextStyle(color:Colors.white),
                                        hintStyle:TextStyle(color:Colors.white),
                                        prefixIcon:

                                        IconButton(
                                          onPressed: (){

                                          },
                                          icon: Image.asset(
                                            'assets/images/lock.png',width: 20,
                                          ),
                                        ),
                                        alignLabelWithHint: false,
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40.0),
                                          borderSide: const BorderSide(color: Colors.white),
                                        ),
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
                                        //  return 'Please enter password ';
                                          return '';
                                        }
                                        if (value!=_passCtrl.text) {
                                          return '';}
                                        //  return 'Password not match';}
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                      padding:  EdgeInsets.only(left:20,bottom:10,right: 20,top: 10),
                                      child:
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            loginLoading?
                                            Container(
                                              width: 24,
                                              height: 24,
                                              padding: const EdgeInsets.all(2.0),
                                              child: const CircularProgressIndicator(
                                                color: bgbuttonRed,
                                               strokeWidth: 3,
                                              ),
                                            ) :
                                            GestureDetector(
                                                onTap: () async {
                                                  // Navigator.pushReplacementNamed(context, "/verification");
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(builder: (context) =>  DailyTask(taradod: taradodList[index],)),
                                                  // );
                                                  if (_formKey.currentState!.validate()) {
                                                    Register("other");
                                                  }

                                                },child:
                                            Container(
                                              width: 120,
                                              height: 35.sp,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: bgbuttonRed),
                                                  borderRadius: BorderRadius.circular(30.sp),
                                                  color: bgbuttonRed//.withOpacity(0.1)
                                              ),
                                              child:Center(child: Text('Sign Up',
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
                                              onTap: ()  {
                                                _animate2;
                                                //Navigator.pushReplacementNamed(context, "/login");
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

                                            SizedBox(
                                                width: 120.0,
                                                height: 35.0,child:
                                            ElevatedButton(
                                              onPressed: _animate2,

                                              child: Text('Back to login'),
                                              style: ElevatedButton.styleFrom(
                                                  foregroundColor: bgbuttonRed,//cha
                                                  backgroundColor:Colors.white ,//change text color of button     backgroundColor: Colors.yellow,//change text color of button
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20), // <-- Radius
                                                  ),
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15 ,
                                                    //  color:Color(0xffD90429) ,
                                                  )),

                                            )),
                                            ),
                                          ]))
                                ])
                        )
                        )
                            :
                        Container(
                            height: MediaQuery.of(context).size.height*0.46,
                            width: MediaQuery.of(context).size.width*0.88,
                            decoration: BoxDecoration(
                              //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 25,),
                                  Text("Login",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                                  SizedBox(height: 15,),
                                  Padding(
                                      padding:  EdgeInsets.only(left:25,right: 25),
                                      child:
                                      InkWell(child:
                                      loading?
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
                                          width:  MediaQuery.of(context).size.width *0.85,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            //  border: Border.all(color: Colors.black87, width: 4),
                                            border:  Border.all(color: Colors.grey),
                                            borderRadius: BorderRadius.circular(30),
                                            color:bgbuttonRed,
                                            shape: BoxShape.rectangle,
                                          ),
                                          child:
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:  EdgeInsets.only(left:45,right: 10),
                                                  child:
                                                  Image.asset("assets/images/google.png",width: 22,height: 22, ),),
                                                Text(
                                                  "Login with Google",
                                                  style: const TextStyle(
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16 ,
                                                    color:Colors.white  ,
                                                    //  fontWeight: FontWeight.bold,
                                                  ),
                                                )

                                              ])
                                      ),
                                        onTap: ()
                                        async{
                                          //  signOutGoogle();
                                          signInWithGoogle();
                                        },
                                      )
                                  ),
                                  Padding(
                                      padding:  EdgeInsets.only(left:100,top:10,bottom: 10),
                                      child:
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:EdgeInsets.symmetric(horizontal:10.0),
                                              child:Container(
                                                height:1.0,
                                                width:50.0,
                                                color:Colors.white,),),
                                            Text(
                                              "OR",
                                              style: const TextStyle(
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13 ,
                                                color:Colors.white  ,
                                                //  fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding:EdgeInsets.symmetric(horizontal:10.0),
                                              child:Container(
                                                height:1.0,
                                                width:50.0,
                                                color:Colors.white,),)
                                          ])

                                  ),

                                  Padding(
                                    padding:  EdgeInsets.only(left:20,right: 20),
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
                                          return '';
                                         // return 'Reached max words';
                                        }
                                        else if( ! EmailValidator.validate(text!))
                                        {
                                       //   return 'Please enter a valid email';
                                          return '';
                                        }
                                        return null;
                                      },
                                      // style: Theme.of(context).textTheme.bodyText1,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        hintText: "Email",
                                        hintStyle:TextStyle(color:Colors.white),
                                        labelStyle:TextStyle(color:Colors.white),
                                        prefixIcon:
                                        IconButton(
                                            onPressed: (){
                                              // setState(() => _usernameCtrl.text = "");
                                            },
                                            icon: Image.asset(
                                              'assets/images/email2.png',width: 20,
                                            )),
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
                                      obscureText: !passwordVisible,
                                      style:TextStyle(color:Colors.white),
                                      controller: _passCtrl,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        hintText: "Password",
                                        labelText: "Password",

                                        // helperText:"Password must contain special character",
                                        labelStyle:TextStyle(color:Colors.white),
                                        hintStyle:TextStyle(color:Colors.white),
                                        prefixIcon:

                                        IconButton(
                                          onPressed: (){

                                          },
                                          icon: Image.asset(
                                            'assets/images/lock.png',width: 20,
                                          ),
                                        ),
                                        alignLabelWithHint: false,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40.0),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 1.5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40.0),
                                          borderSide: const BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      keyboardType: TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '';
                                          //return 'Please enter password ';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                      padding:  EdgeInsets.only(left:20,top:10,bottom: 5,right: 20),
                                      child:
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                                padding:EdgeInsets.only(left:1.0),
                                                child:Container(
                                                    height:10.0,
                                                    width:40.0,
                                                    // color:Colors.white,
                                                    child:

                                                    Switch(
                                                      // thumb color (round icon)
                                                      activeColor: Colors.white,
                                                      activeTrackColor: Colors.cyan,
                                                      inactiveThumbColor: Colors.blueGrey.shade600,
                                                      inactiveTrackColor: Colors.grey.shade400,
                                                      splashRadius: 50.0,
                                                      // boolean variable value
                                                      value: rememberme,
                                                      onChanged: (value) => setState(() => rememberme = value),

                                                      //   onChanged: (bool value) {
                                                      //   value=!value;
                                                      // },
                                                      // changes the state of the switch

                                                      //     onChanged: (value) => setState(),
                                                    )
                                                )
                                            ),
                                            Text(
                                              "Remember me",
                                              style: const TextStyle(
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13 ,
                                                color:Colors.white  ,
                                                //  fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              "Forget Password",
                                              style: const TextStyle(
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13 ,
                                                color:Colors.white  ,
                                                //  fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ])
                                  ),
                                  Padding(
                                      padding:  EdgeInsets.only(left:20,top:7,bottom: 0,right: 20),
                                      child:
                                      Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            GestureDetector(
                                                onTap: () async {
                                                  if (_formKey.currentState!.validate()) {
                                                    Login1(_usernameCtrl.text);
                                                  }

                                                  // Navigator.pushReplacementNamed(context, "/verification");
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(builder: (context) =>  DailyTask(taradod: taradodList[index],)),
                                                  // );
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
                                              height: 35.sp,
                                              width: 120,
                                              //  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: bgbuttonRed),
                                                  borderRadius: BorderRadius.circular(30.sp),
                                                  color: bgbuttonRed//.withOpacity(0.1)
                                              ),
                                              child:Center(child: Text('Login',
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
                                            SizedBox(
                                                width: 120.0,
                                                height: 35.0,child:
                                            ElevatedButton(
                                              onPressed: _animate,

                                              //   height: 35.sp,
                                              child: Text('Sign Up'),
                                              style: ElevatedButton.styleFrom(
                                                  foregroundColor: bgbuttonRed,//cha
                                                  backgroundColor:Colors.white ,//change text color of button     backgroundColor: Colors.yellow,//change text color of button
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20), // <-- Radius
                                                  ),
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15 ,
                                                    //  color:Color(0xffD90429) ,
                                                  )),

                                            )),

                                          ]))
                                ])

                        ),

                        position: _offsetAnimation![0],
                      ),
                      BoxSwapWidget(
                        callBack: _animate,
                        widget:
                        Padding(padding: EdgeInsets.only(bottom:showSignup?10:0,top:!showSignup?10:0),
                            child:
                            Container(
                              height: MediaQuery.of(context).size.height*0.49,
                              width: MediaQuery.of(context).size.width*0.88,
                              decoration: BoxDecoration(
                                //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(30),

                              ),

                            )),
                        position: _offsetAnimation![1],
                      )
                    ],
                  ),

                ],
              )),
            ]))
    );



  }

}
