
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
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
bool loading=false;
  bool rememberme=false;
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

Future<User?> signInWithGoogle() async {

  setState(() {
    gmailLoading=true;
  });
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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
   // customNotification(false,'${_user!.email}',MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
    RegisterforGoogle(_user!.email!);

    //Navigator.pushNamed(context,"/main_tab_bar");
  } catch (error) {
    customNotification(true,error.toString(),MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);

    print(error);
    setState(() {
      gmailLoading=false;
    });
  }
  setState(() {
    gmailLoading=false;
  });

  // if(_user!=null){
  // customNotification(false,'you are signed in as a ${_user!.email}',MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
  // Navigator.pushNamed(context,"/main_tab_bar");}
}

@override
  initState()  {
    super.initState();
    _emailController= TextEditingController(text: "");
    if(mounted){
      //  new Timer.periodic(const Duration(minutes: 1), (Timer t) => setState((){}));
     // getPersonelTraffic();
      //  getPersonelTrafficOffline();
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
    _usernameCtrl.text,lang, _passCtrl.text,type,"","");
   // String link = response["result"]['link'];
    String token = "";
    if (response['statusCode'] != null &&response['statusCode']==200)
      {
        setState(() {
          loginLoading=false;
        });
        customNotification(false,response['message'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
      Navigator.pushNamed(context,"/main_tab_bar");
      }

    else
    {
      customNotification(true,response["message"],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
      _usernameCtrl.text="";
      _passCtrl.text="";
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
RegisterforGoogle(String email)
async {
  try{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lang = prefs.getString("lang_id");
    if(lang!=null&&lang.trim().length>0){
      setState(() {
        loginLoading=true;
      });
      var response = await (Services()).register(
          email,lang, email,"gmail","","");
      // String link = response["result"]['link'];
      String token = "";
      if (response['statusCode'] != null &&response['statusCode']==200)
      {
        setState(() {
          loginLoading=false;
        });
       customNotification(false,response['message'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
      Login2(response['data']['email']);
       // Login1("aamm@gmail.com");
        //    Navigator.pushNamed(context,"/main_tab_bar");
      }

      else
      {
        customNotification(true,response['message'],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
        _usernameCtrl.text="";
        _passCtrl.text="";
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
           //   Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.45,),
              Padding(padding: EdgeInsets.only(top:40),
                child:
                Container(
                    height: MediaQuery.of(context).size.height*0.54,
                    width: MediaQuery.of(context).size.width*0.88,
                    decoration: BoxDecoration(
                      //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(30)),
                    child:

                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10,),
                          Text("Sign Up",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                          SizedBox(height: 15,),
                          Padding(
                              padding:  EdgeInsets.only(left:35,right: 25),
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
                                        height:3.0,
                                        width:50.0,
                                        color:Colors.white,),),
                                    Text(
                                      "OR",
                                      style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15 ,
                                        color:Colors.white  ,
                                        //  fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding:EdgeInsets.symmetric(horizontal:10.0),
                                      child:Container(
                                        height:3.0,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Email ';
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
                        padding:  EdgeInsets.only(left:20,right: 20,top:10),   child:
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
                            padding:  EdgeInsets.only(left: 20,top:10,right: 20),
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
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password ';
                                  }
                              if (value!=_passCtrl.text) {
                              return 'Password not match';}
                                  return null;
                                },
                              ),

                              // TextField(
                              //   controller: _passCtrl,
                              //   obscureText: passwordVisible,
                              //
                              //     decoration: InputDecoration(
                              //
                              //       border: OutlineInputBorder(
                              //     //    borderSide: const BorderSide(color: Colors.white),
                              //
                              //         borderRadius: BorderRadius.circular(30.0),
                              //       ),
                              //       prefixIcon:
                              //       _passCtrl.text == "" ?
                              //       IconButton(
                              //         onPressed: (){
                              //           setState(() => _passCtrl.text = "");
                              //         },
                              //         icon: Image.asset(
                              //           'assets/images/lock.png',width: 20,
                              //         ),
                              //       )
                              //           :     Container(),
                              //   //  hintText: "Password",
                              //     labelText: "Password",
                              //   //  helperText:"Password must contain special character",
                              //   //  helperStyle:TextStyle(color:Colors.green),
                              //       labelStyle: TextStyle(color:Colors.white),
                              //     suffixIcon: IconButton(
                              //       icon: Icon(passwordVisible
                              //           ? Icons.visibility
                              //           : Icons.visibility_off,color: Colors.white,),
                              //       onPressed: () {
                              //         setState(
                              //               () {
                              //             passwordVisible = !passwordVisible;
                              //           },
                              //         );
                              //       },
                              //     ),
                              //     alignLabelWithHint: false,
                              //     filled: true,
                              //      , focusedBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(40.0),
                              //         borderSide: const BorderSide(color: Colors.white),
                              //       ),
                              //       enabledBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(40.0),
                              //         borderSide: const BorderSide(
                              //             color: Colors.white, width: 1.5),
                              //       ),
                              //   ),
                              //   keyboardType: TextInputType.visiblePassword,
                              //   textInputAction: TextInputAction.done,
                              // ),

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
                                        padding:EdgeInsets.only(left:1),
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
                                      "I accept the privacy and terms",
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
                              padding:  EdgeInsets.only(left:20,top:5.sp,bottom: 0,right: 20),
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
                            Register("other");
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
                                      height: 35.sp,
                                      width: 130,

                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30.sp),
                                          color: Colors.white//.withOpacity(0.1)
                                      ),
                                      child:Center(child: Text('Back to login',
                                        style: const TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15 ,
                                          color:bgbuttonRed ,
                                          //  fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    )),
                                  ]))
                        ])

                ),
              ),
              Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.6,),
                child:
                Container(
                    height: MediaQuery.of(context).size.height*0.37,
                    width: MediaQuery.of(context).size.width*0.88,
                    decoration: BoxDecoration(
                      //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(30)),
                ),
              ),

            ]))
    );



  }

}
