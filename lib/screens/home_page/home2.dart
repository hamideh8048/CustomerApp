import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/LangModel.dart';

class Home2 extends StatefulWidget {
  const Home2({Key? key}) : super(key: key);

  @override
  State<Home2> createState() => Home2State();
}

class Home2State extends State<Home2> {
bool showYellowBirdlogo=false;
bool isClickBird=false;
String title="Yellowjay server";
Color bgcolor=bgYellow;
String? _chosenValue;
String? _chosenSourceValue;
  ScrollController? scrollController;
  bool pageLoading = true;
  String companyName="";
String? lang ;
String? token1 ;
List<DropdownMenuItem<String>> dropdownItems = [];
  TextEditingController? _nameController;
  TextEditingController? _fullController;
 // TextEditingController? _birthController;
  TextEditingController? _ageController;
  TextEditingController? _addressController;
  TextEditingController? _educationController;
  TextEditingController? _sourceController;
  TextEditingController? _targetController;
  TextEditingController? _phoneController;
  SharedPreferences? prefs;
  List<LangModel>CountryList = [];
  String companyLogo="";
  bool saveLoading=false;
  bool loading=false;
  @override
  initState()  {

    super.initState();
    _ageController= TextEditingController(text: "");
    _nameController= TextEditingController(text: "");
    _fullController= TextEditingController(text: "");
    _addressController= TextEditingController(text: "");
    _educationController= TextEditingController(text: "");
    _phoneController= TextEditingController(text: "");
    _sourceController= TextEditingController(text: "");
    _targetController= TextEditingController(text: "");

    if(mounted){
      //  new Timer.periodic(const Duration(minutes: 1), (Timer t) => setState((){}));
    show();
   // getCountries();
      //  getPersonelTrafficOffline();
    }
  }
getCountries()
async {
  prefs = await SharedPreferences.getInstance();
  if( token1==null)
    token1 = prefs!.getString("token");
  var response = await (Services()).getCountries(token1!);
  if (response['statusCode'] != null&&response['statusCode']==200)
    response["data"].forEach((element){
      CountryList .add(LangModel.fromJson(element));
    });
 // _chosenValue=CountryList[0].id;
  for (LangModel lang in CountryList) {
    var newItem = DropdownMenuItem(
      child: Text(lang.title,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
       key: UniqueKey(),
      value: lang.id.toString(),
    );
    dropdownItems.add(newItem);

  }
  setState(() {
  });
}
show()
async {
  try{
    prefs = await SharedPreferences.getInstance();
    if(lang==null)
      lang = prefs!.getString("lang_id");
    if( token1==null)
      token1 = prefs!.getString("token");
    if(lang!=null&&lang!.trim().length>0 && token1!=null&&token1!.trim().length>0){
      setState(() {
        loading=true;
      });
      var response = await (Services()).showProfile(token1!);
      // _phoneController!.text, _nameController!.text,_fullController!.text,_educationController!.text,_addressController!.text ,_sourceController!.text,_targetController!.text,_ageController!.text);
      if (response['statusCode'] != null &&response['statusCode']==200)
      {
        _nameController!.text=response["data"]["first_name"]??"";
        _fullController!.text=response["data"]["last_name"]??"";
        _ageController!.text=response["data"]["age"].toString()??"";
     // _em.text=response["data"]["address"]??"";
       // _educationController!.text=response["data"]["education"]??"";
        // _sourceController!.text=response["data"]["source_country"]??"";
        // _targetController!.text=response["data"]["target_country"]??"";
    //    if(response["data"]["target_country_id"]!=null&&response["data"]["target_country_id"]!="")
      // _chosenValue=response["data"]["target_country_id"];
     //   if(response["data"]["source_country_id"]!=null&&response["data"]["source_country_id"]!="")
       //   _chosenSourceValue=response["data"]["source_country_id"];
     //   _chosenSourceValue=response["data"]["source_country"]??"";
     //   _phoneController!.text=response["data"]["phone"]??"";
        setState(() {
          loading=false;
        });
      }else
      {
        customNotification(true,response["message"],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
        setState(() {
          loading=false;
        });
      }
  }
  } catch (error) {
  print(error);
  setState(() {
    loading=false;
  });
  }
  }
save()
async {

  prefs = await SharedPreferences.getInstance();
  if(lang==null)
    lang = prefs!.getString("lang_id");
  if( token1==null)
    token1 = prefs!.getString("token");
// getpref();
  if(lang!=null&&lang!.trim().length>0 && token1!=null&&token1!.trim().length>0){
    setState(() {
      saveLoading=true;
    });
    try{
      var response = await (Services()).saveProfile(token1!,lang!,
        _nameController!.text,_fullController!.text,_ageController!.text);
      if (response['statusCode'] != null &&response['statusCode']==200)
      {
        setState(() {
          saveLoading=false;
        });
        show();
        setState(() {
        });
      }else
      {
        customNotification(true,response["message"],MediaQuery.of(context).size.width,MediaQuery.of(context).size.height);
        setState(() {
         saveLoading=false;
       });
      }
    } catch (error) {
      setState(() {
        saveLoading=false;
      });
       print(error);

    }
  }}
final _formKey = GlobalKey<FormState>();
@override
void dispose() {
  // Clean up the controller when the widget is removed from the widget tree.
  // This also removes the _printLatestValue listener.
  _nameController!.dispose();
  _ageController!.dispose();;
  _addressController!.dispose();
  _targetController!.dispose();
  _sourceController!.dispose();
  _fullController!.dispose();
  _phoneController!.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // backgroundColor:frameColor, //Colors.white,//backgroundColor,
         body:
loading
        ?
Container(
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height,

      decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/bgprofilemain.png"),
        fit: BoxFit.cover,
      ),
    ),

  child: const Center(child: const CircularProgressIndicator(
    color: bgbuttonRed,
    strokeWidth: 3,
  ),)  ,
) :

         Form(
       key: _formKey,
            child:
        Stack(
            alignment: Alignment.topCenter,
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:
                Image.asset("assets/images/bgprofilemain.png", fit: BoxFit.cover),
              ),
        Padding(padding: EdgeInsets.only(top:30,),
            child:
            Text("        User Profile",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: greyColor3 )),

        ),
              //تکست باکس ها
              Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.46,),
                child:
                    Container(
                        height: MediaQuery.of(context).size.height*0.4,
                        width: MediaQuery.of(context).size.width*0.88,
                        child:
                        new SingleChildScrollView(child:
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:  EdgeInsets.only(left:30,right: 50,top:10),
                                child:
                                TextFormField(
                                  controller: _nameController,
                                  style:TextStyle(color:Colors.white,fontSize:14 ,),
                                  onTap: (){
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter Name';
                                    }
                                    return null;
                                  },
                                  // style: Theme.of(context).textTheme.bodyText1,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                    border: OutlineInputBorder(

                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    hintText: "Name",

                                    hintStyle:TextStyle(color:Colors.white),
                                    labelStyle:TextStyle(color:Colors.white,),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.black),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.5),
                                    ),

                                    labelText: "Name",
                                    alignLabelWithHint: false,
                                    filled: true,
                                    // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left:30,right: 50,top:10),
                                child:
                                TextFormField(
                                  controller: _fullController,
                                  style:TextStyle(color:Colors.white,fontSize:14 ,),
                                  onTap: (){

                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter FullName ';
                                    }

                                    return null;
                                  },
                                  // style: Theme.of(context).textTheme.bodyText1,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                    border: OutlineInputBorder(

                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    hintText: "   FullName",

                                    hintStyle:TextStyle(color:Colors.white),
                                    labelStyle:TextStyle(color:Colors.white,),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(color: Colors.black),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.5),
                                    ),

                                    labelText: "FullName",
                                    alignLabelWithHint: false,
                                    filled: true,
                                    // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left:30,right: 50,top:10),
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
                                      borderSide: const BorderSide(color: Colors.black),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      borderSide: const BorderSide(
                                          color: Colors.black, width: 1.5),
                                    ),

                                    labelText: "Age",
                                    alignLabelWithHint: false,
                                    filled: true,
                                    // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                                  ),
                                ),
                              ),

                              // Padding(
                              //     padding:  EdgeInsets.only(left:30,right: 50,top:10),
                              //     child:
                              //     Container(
                              //         height: 50.sp,
                              //         width: MediaQuery.of(context).size.width*0.88,
                              //         padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                              //         decoration: BoxDecoration(
                              //           border: Border.all(color: Colors.black,width: 1.4),
                              //           borderRadius: BorderRadius.circular(30.sp),
                              //           //      color: bgbuttonRed//.withOpacity(0.1)
                              //         ),
                              //         child:
                              //         DropdownButton<String>(
                              //           items: dropdownItems,
                              //           // hint: new Text("Select"),
                              //           dropdownColor: bgGray,
                              //           value: _chosenSourceValue,
                              //           hint: Text("Select Source",    style:TextStyle(color:Colors.white,fontSize:14 ,),),
                              //           onChanged: (String? value) {
                              //             setState(() {
                              //               _chosenSourceValue = value!;
                              //             });
                              //           },
                              //         ))),
                              // Padding(
                              //   padding:  EdgeInsets.only(left:30,right: 50,top:10),
                              //   child:
                              //   TextFormField(
                              //     controller: _sourceController,
                              //     style:TextStyle(color:Colors.white,fontSize:14 ,),
                              //     onTap: (){
                              //
                              //     },
                              //     validator: (value) {
                              //       if (value == null || value.isEmpty) {
                              //         return 'Please enter Source Country ';
                              //       }
                              //       return null;
                              //     },
                              //     // style: Theme.of(context).textTheme.bodyText1,
                              //     decoration: InputDecoration(
                              //       contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(20.0),
                              //       ),
                              //       hintText: "Source Country",
                              //       hintStyle:TextStyle(color:Colors.white),
                              //       labelStyle:TextStyle(color:Colors.white,),
                              //       focusedBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(40.0),
                              //         borderSide: const BorderSide(color: Colors.black),
                              //       ),
                              //       enabledBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(40.0),
                              //         borderSide: const BorderSide(
                              //             color: Colors.black, width: 1.5),
                              //       ),
                              //
                              //       labelText: "Source Country",
                              //       alignLabelWithHint: false,
                              //       filled: true,
                              //       // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                              //     ),
                              //   ),
                              // ),
                        // Padding(
                        //     padding:  EdgeInsets.only(left:30,right: 50,top:10),
                        //     child:
                        // Container(
                        //     height: 50.sp,
                        //     width: MediaQuery.of(context).size.width*0.88,
                        //      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                        //     decoration: BoxDecoration(
                        //         border: Border.all(color: Colors.black,width: 1.4),
                        //         borderRadius: BorderRadius.circular(30.sp),
                        //   //      color: bgbuttonRed//.withOpacity(0.1)
                        //     ),
                        //     child:
                        //       DropdownButton<String>(
                        //         items: dropdownItems,
                        //        // hint: new Text("Select"),
                        //         dropdownColor: bgGray,
                        //      value: _chosenValue,
                        //         hint: Text("select target",    style:TextStyle(color:Colors.white,fontSize:14 ,),),
                        //         onChanged: (String? value) {
                        //           setState(() {
                        //             _chosenValue = value!;
                        //           });
                        //         },
                        //       ))),
                              // Padding(
                              //   padding:  EdgeInsets.only(left:30,right: 50,top:10),
                              //   child:
                              //   TextFormField(
                              //     controller: _targetController,
                              //     style:TextStyle(color:Colors.white,fontSize:14 ,),
                              //     onTap: (){
                              //     },
                              //     validator: (value) {
                              //       if (value == null || value.isEmpty) {
                              //         return 'Please enter target Country ';
                              //       }
                              //       return null;
                              //     },
                              //     // style: Theme.of(context).textTheme.bodyText1,
                              //     decoration: InputDecoration(
                              //       contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(20.0),
                              //       ),
                              //       hintText: "Target Country",
                              //       hintStyle:TextStyle(color:Colors.white),
                              //       labelStyle:TextStyle(color:Colors.white,),
                              //       focusedBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(40.0),
                              //         borderSide: const BorderSide(color: Colors.black),
                              //       ),
                              //       enabledBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(40.0),
                              //         borderSide: const BorderSide(
                              //             color: Colors.black, width: 1.5),
                              //       ),
                              //       labelText: "Target Country",
                              //       alignLabelWithHint: false,
                              //       filled: true,
                              //       // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                              //     ),
                              //   ),
                              // ),
                              Padding(
                          padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1,right: 50,top:15),
                          child:
                         saveLoading?
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
                                   if (_formKey.currentState!.validate()) {
                                   save();
                                //   show();
                                    }
                                  },child:
                              Container(
                                height: 35.sp,
                                width: 120,
                                //  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                                decoration: BoxDecoration(
                                    border: Border.all(color: bgbuttonRed),
                                    borderRadius: BorderRadius.circular(30.sp),
                                    color: bgbuttonRed//.withOpacity(0.1)
                                ),
                                child:Center(child: Text('Save',
                                  style: const TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15 ,
                                    color:Colors.white  ,
                                    //  fontWeight: FontWeight.bold,
                                  ),
                                )),
                              )
                              ),)
                            ]))

                    ),
              ),


   ])

        ));




  }

}
