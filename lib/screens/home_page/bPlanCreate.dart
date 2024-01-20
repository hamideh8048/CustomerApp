
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/BussinessModel.dart';
import 'package:redJAY/models/LangModel.dart';
import 'package:redJAY/models/PartModel.dart';
import 'package:redJAY/models/ProviderModel.dart';
import 'package:redJAY/screens/home_page/AddVideos.dart';
import 'package:redJAY/screens/home_page/ExtraInfo.dart';
import 'package:redJAY/screens/home_page/testtimeline.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'listTimeline.dart';


class bPlanCreate extends StatefulWidget {
  const  bPlanCreate({Key? key,this.bussinessModel}) : super(key: key);
  final   BussinessModel? bussinessModel;
  @override
  State< bPlanCreate> createState() =>  bPlanCreateState();
}
class  bPlanCreateState extends State<bPlanCreate> {
  bool showYellowBirdlogo=false;
  bool isClickBird=false;
  String title="Yellowjay server";
  Color bgcolor=bgYellow;
  ScrollController? scrollController;
  bool pageLoading = true;
  bool hasData = true;
  bool isView = true;
  bool loadImage= false;
  bool gmailLoading=false;
  String companyName="";
  TextEditingController? _emailController;
  TextEditingController? _refController;
  String companyLogo="";
  bool loginLoading=false;
  bool updateLoading=false;
  String? _chosenValue;
  String? _chosenSourceValue;
  String? _chosenJobValue;
  String? _chosenLangValue;
  String? _chosenWorkValue;
  String? imageUri;
  List<DropdownMenuItem<String>> dropdownItems = [];
  List<DropdownMenuItem<String>> dropdownJobItems = [];
  List<DropdownMenuItem<String>> dropdownWorkItems = [];
  List<DropdownMenuItem<String>> dropdownLangItems = [];
  SharedPreferences? prefs;
  List<LangModel>CountryList = [];
  bool loading=false;
  bool rememberme=false;
  TextEditingController? _titleController=TextEditingController();
  TextEditingController? _priceController=TextEditingController();
  TextEditingController? _descController=TextEditingController();
  TextEditingController? _phoneController=TextEditingController();
  TextEditingController _usernameCtrl= TextEditingController();
  TextEditingController _addressCtrl= TextEditingController();
  TextEditingController _passCtrl= TextEditingController();
  TextEditingController _rePassCtrl= TextEditingController();
  bool repasswordVisible=false;
  bool passwordVisible=false;
  String avatar="";
  String uri="";
  String extension="";
  String type="";
  String alt="";
  String name="";
  String data="";
  String size="140";
  String?  token1="";
  String?  lang="";
  String?  projectId="";
  bool loadImage2=false;
  String bussinessId="0";
  List<ProviderModel> avatarList = [];
  getStatusProvider()
  async {
       imageUri="";//"https://petroskadeh.com//uploads/7ed149666af28514ee2db1ccbc916ea2febb8744.png";

    //  var response = await (Services()).Uploader(token1, "en", file);
    var response = await (Services()).getStatusProvider(token1!,projectId!,lang!);

    if (lang != null && lang!.trim().length > 0) {
      // setState(() {
      //   loginLoading = true;
      // });
      try {
        // var response = await (Services()).getStatusProvider(token1);
        //  var response = await (Services()).Uploader(token1,"en");
        //  var response = await (Services()).UpdateProvider(token1,"09126666661","1","abc","aaa","4","en","korea","lawyer","bbb","");
        if (response['statusCode'] != null && response['statusCode'] == 200) {
          // setState(() {
          //   loginLoading = false;
          // });
          hasData=response['data']['status'];
          if(hasData)
          {
            showProvider();
          }
          // if(response["data"]['status']!=null)
          //   isView  = response["data"]['status'];

          // customNotification(false, 'you are signed in as a ${email}', MediaQuery
          //      .of(context)
          //      .size
          //      .width, MediaQuery
          //      .of(context)
          //      .size
          // //      .height);
          // Navigator.pushNamed(context,"/main_tab_bar");
          // _usernameCtrl.text="";
          // _passCtrl.text="";

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
        }
      } catch (error) {
        print(error);
        // setState(() {
        //   loginLoading = false;
        // });

      }
    }
  }
  List<PartModel>parts=[];
  showProvider()
  async {
    //! String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    setState(() { loadImage=true;});
    if(widget.bussinessModel!=null)
      {


        if (lang != null && lang!.trim().length > 0) {
            var response = await (Services()).ShowBussiness(  token1!,lang!,projectId!,widget.bussinessModel!.id);

      // setState(() {
      //   loginLoading = true;
      // });
      try {


        widget.bussinessModel!.parts=parts;
         if (response['statusCode'] != null && response['statusCode'] == 200) {
           if(response['data'].length>0&&response['data'][0]['part']!=null)
             response['data'][0]['part'].forEach((element) {
               parts.add(PartModel.fromJson(element));
             });
           if(response['data'].length>0&&response['data'][0]['file']!=null&&response["data"][0]['file'].length>0)
        uri=response["data"][0]['file']??"";
           if(response['data'].length>0&&response['data'][0]['price']!=null)
         _priceController!.text=  response['data'][0]['price'];
           widget.bussinessModel!.price=     _priceController!.text;
           _titleController!.text=widget.bussinessModel!.title;
           _descController!.text=widget.bussinessModel!.description;
           bussinessId = widget.bussinessModel!.id;
          extension='png';
          type='avatar';
          size='150192';
          name='image.png';
          alt='image.png';
          data='';
            setState(() { loadImage=false;});
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
          setState(() { loadImage=false;});
        }
      } catch (error) {
        print(error);
        setState(() {
          loginLoading = false;
        });
      }}
    }
  }
  selectImage()
  async {

    FilePickerResult? result = await FilePicker.platform.pickFiles( allowedExtensions: ['pdf'],type: FileType.custom);
    if (result != null) {
      setState(() { loadImage2=true;});
      File file = File(result.files.single.path!);
      // String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
      var responseUpload = await (Services()).Uploader(token1!, lang!, file);
      if (responseUpload['statusCode'] != null && responseUpload['statusCode'] == 200) {
        uri=responseUpload['data']['uri'];//"https://petroskadeh.com/uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//responseUpload['data']['uri'];
        extension=responseUpload['data']['extension'];
        alt=responseUpload['data']['alt'];
        name=responseUpload['data']['name'];
        type=responseUpload['data']['type'];
        size=responseUpload['data']['size'].toString();
        data=responseUpload['data']['data']??"";
       imageUri =
        responseUpload['data']['uri']; //"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//response["data"]["avatar"];
        loadImage2=false;
        if( responseUpload["message"]!=null)
          customNotification(false, responseUpload["message"], MediaQuery
              .of(context)
              .size
              .width, MediaQuery
              .of(context)
              .size
              .height);
        setState(() { loadImage2=false;});
      }
    }}
  createBussiness()
  async {
    try {
      if (lang != null && lang!.trim().length > 0) {
        setState(() {
          loginLoading = true;
        });
        // uri="https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";
        //  extension='png';
        //  type='avatar';
        //  size='150192';
        //  name='image.png';
        //  alt='image.png';
        //  data='';
        if(uri.length>5){
          var response;
    if(widget.bussinessModel==null)
        response = await (Services()).createBusiness(token1!,lang!,projectId!,_descController!.text,_titleController!.text,_priceController!.text,"3",uri,extension,name,alt,size,data,type);
       else
          response = await (Services()).editBusiness(token1!,lang!,widget.bussinessModel!.id,projectId!,_descController!.text,_titleController!.text,_priceController!.text,"3",uri,extension,name,alt,size,data,type);
       // var response = await (Services()).createPartBusiness(token1!,4,lang!,projectId!,_descController!.text,_titleController!.text,"3000","3",uri,extension,name,alt,size,data,type);
        if (response['statusCode'] != null && response['statusCode'] == 200) {

         if(response['data']['id']!=null)
           {
           bussinessId = response['data']['id'].toString();
           }
          setState(() {
            loginLoading = false;
          });

          customNotification(false, response["message"], MediaQuery
              .of(context)
              .size
              .width, MediaQuery
              .of(context)
              .size
              .height);
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => listTimeline()),
         );
        }
        else {
          customNotification(true, response["message"], MediaQuery
              .of(context)
              .size
              .width, MediaQuery
              .of(context)
              .size
              .height);
          _usernameCtrl.text = "";
          _passCtrl.text = "";
          setState(() {
            loginLoading = false;
          });
        }
      }
        else
        {
          customNotification(true, "please upload file at first", MediaQuery
              .of(context)
              .size
              .width, MediaQuery
              .of(context)
              .size
              .height);
          _usernameCtrl.text = "";
          _passCtrl.text = "";
          setState(() {
            loginLoading = false;
          });
        }
        }

      }

    catch (error) {
      print(error);
      setState(() {
        loginLoading = false;
      });
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
  getValueFromPref()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    lang =prefs!.getString("lang_id");//
    projectId = prefs!.getString("project_id");//"1"
    token1=prefs!.getString("token");//
    // lang ="en";//prefs!.getString("lang_id");//"en";
    // projectId = "1";//prefs!.getString("project_id");//"1"
    // token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
//prefs!.getString("token");//
   // getCountries();
    // showProvider();
  //  getStatusProvider();
    if(widget.bussinessModel!=null)
     showProvider();
  }
  @override
  initState()  {
    super.initState();
    getValueFromPref();
    // lang ="en"; //prefs!.getString("lang_id");
    // projectId = "1";//prefs!.getString("project_id");
    // token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";

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
              Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.width*0.53,),
                child:
                Container(
                    height: MediaQuery.of(context).size.height*0.73,
                    width: MediaQuery.of(context).size.width*0.86,
                    decoration: BoxDecoration(
                      //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(30)),
                    child:
                    new SingleChildScrollView(child:
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20,),

                          Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:20),
                            child:
                            TextFormField(
                              controller: _titleController,
                              style:TextStyle(color:Colors.white,fontSize:14 ,),
                              onTap: (){

                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                //  return 'Please enter proje ';
                                }
                                return null;
                              },
                              // style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: "Project Title",
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
                                labelText: "Project Title",
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
                              controller: _priceController,
                              style:TextStyle(color:Colors.white,fontSize:14 ,),
                              onTap: (){

                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                  //  return 'Please enter proje ';
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
                                controller: _descController,
                                style:TextStyle(color:Colors.white,fontSize:14 ,),
                                onTap: (){
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "";
                                    //  return 'Please enter proje ';
                                  }
                                  return null;
                                },
                                // style: Theme.of(context).textTheme.bodyText1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 70,horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  hintText: "Description of your project",
                                  hintStyle:TextStyle(color:Colors.white),
                                  labelStyle:TextStyle(color:Colors.white,),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    borderSide: const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1.5),
                                  ),
                                  labelText: "Description of your project",
                                  alignLabelWithHint: false,
                                  filled: true,
                                  // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                                ),
                              ),

                          ),

                          Padding(
                              padding:  EdgeInsets.only(left:20,right: 20,top:20),
                              child:
                                  SizedBox(width: 2500.sp,child:
                              Text("If our customer was satisfactory of you,the amount they paid will be released to you",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.normal,color:  Colors.white,)),
                    )),
                          Padding(
                              padding:  EdgeInsets.only(left:20,right: 20,top:20),
                              child:
                              SizedBox(width: 2500.sp,child:
                              Text("but if they have any dissatisfaction, the amount will be returned to them.",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.normal,color:  Colors.white,)),
                              )),
                          Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:20),
                            child:
                            SizedBox(width: 2500.sp,child:
                            Text("Please upload your terms and conditions, so that in case of any problem,necessary actions will be taken according to your rules",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.normal,color:  Colors.white,)),
                            )
                          ),
                              Padding(
                                  padding:  EdgeInsets.only(left:100.sp,top:30.sp,bottom: 10,),
                                  child:
                                  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: () async {
                                              selectImage();
                                            },child:
                                        loadImage2?
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
                                          child:Center(child: Text('Upload files',
                                            style: const TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15 ,
                                              color:Colors.white  ,
                                              //  fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                        )),


                                      ])),
                        Padding(
                            padding:  EdgeInsets.only(left:20,right: 20),child:

                          Divider(
                            color: Colors.white,thickness: 2,
                          )),
                          Padding(
                              padding:  EdgeInsets.only(left:20,top:10),
                              child:
                              Text("Click if you want to partition your project",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.normal,color:  Colors.white,)),
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left:100.sp,top:20.sp,bottom: 10,),
                              child:
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                    //    if(_titleController!.text.length>0 &&bussinessId!="0")
                                          if(widget.bussinessModel==null) {
                                            if (bussinessId == "0")
                                              createBussiness();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      testtimeline(
                                                          bussinessModel: BussinessModel
                                                              .fromString(
                                                              _titleController!
                                                                  .text, "ff",
                                                              int.parse(
                                                                  bussinessId),
                                                              parts,
                                                              _priceController!
                                                                  .text))
                                              ),
                                            );
                                          }
                                        else
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) =>  testtimeline(bussinessModel:widget.bussinessModel!)));
                                      //    Navigator.pushReplacementNamed(context, "/verification");
                                        },child:
                                    // loginLoading?
                                    // Container(
                                    //   width: 24,
                                    //   height: 24,
                                    //   padding: const EdgeInsets.all(2.0),
                                    //   child: const CircularProgressIndicator(
                                    //     color: bgbuttonRed,
                                    //     strokeWidth: 3,
                                    //   ),
                                    // ):
                                    Container(
                                      width: 120,
                                      height: 35.sp,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: bgbuttonRed),
                                          borderRadius: BorderRadius.circular(30.sp),
                                          color: bgbuttonRed//.withOpacity(0.1)
                                      ),
                                      child:Center(child: Text('set parts',
                                        style: const TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15 ,
                                          color:Colors.white  ,
                                          //  fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    )),


                                  ])),
                          Padding(
                              padding:  EdgeInsets.only(left:20,right: 20),child:
                          Divider(
                            color: Colors.white,thickness: 2,
                          )),
                          Padding(
                              padding:  EdgeInsets.only(left:20.sp,top:20.sp,bottom: 10,),
                              child:
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          createBussiness();
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
                                      child:Center(child: Text('Submit',
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

                                        },child:
                                    // loginLoading?
                                    // Container(
                                    //   width: 24,
                                    //   height: 24,
                                    //   padding: const EdgeInsets.all(2.0),
                                    //   child: const CircularProgressIndicator(
                                    //     color: bgbuttonRed,
                                    //     strokeWidth: 3,
                                    //   ),
                                    // ):
                                    Container(
                                      width: 160.sp,
                                      height: 35.sp,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: bgbuttonRed),
                                          borderRadius: BorderRadius.circular(30.sp),
                                          color: bgbuttonRed//.withOpacity(0.1)
                                      ),
                                      child:Center(child: Text('Add another project',
                                        style: const TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15 ,
                                          color:Colors.white  ,
                                          //  fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                    )),

                                  ])),
                        ])
                    )
                ),
              ),
              Positioned(
                  top:MediaQuery.of(context).size.width*0.28,
                  left: 70,
                  child:
                  GestureDetector(
                      onTap: () async {
                        // Navigator.pushReplacementNamed(context, "/verification");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  listTimeline()),
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
                      onTap: () async {
                        // Navigator.pushReplacementNamed(context, "/verification");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  AddVideo()),
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
                      onTap: () async {
                        // Navigator.pushReplacementNamed(context, "/verification");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  ExtraInfo()),
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
                        height: 30,
                        width:30,
                        child:
                        Image.asset("assets/images/extra.png", fit: BoxFit.cover),
                      ))))
              )
            ]))
    );



  }

}
