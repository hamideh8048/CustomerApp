

import 'package:redJAY/components/constants.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Bplan extends StatefulWidget {
  const Bplan({Key? key}) : super(key: key);

  @override
  State<Bplan> createState() => BplanState();
}

class BplanState extends State<Bplan> {
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
  ;
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
             Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.width*0.54,),
                child:
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
                                           // Register("other");
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
                ),
              ),
              Positioned(
                top:MediaQuery.of(context).size.width*0.28,
                  left: 70,
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
                  left: 180.sp,
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
                  left: 280.sp,
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
