
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/LangModel.dart';
import 'package:redJAY/models/ProviderModel.dart';
import 'package:redJAY/screens/home_page/AddVideos.dart';
import 'package:redJAY/screens/home_page/ExtraInfo.dart';
import 'package:redJAY/screens/home_page/bPlanCreate.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'listTimeline.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => PersonalInfoState();
}

class PersonalInfoState extends State<PersonalInfo> {
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
  TextEditingController? _ageController=TextEditingController();
  TextEditingController? _addressController=TextEditingController();
  TextEditingController? _yearController=TextEditingController();
  TextEditingController? _phoneController=TextEditingController();
  TextEditingController? _sourceController=TextEditingController(text: "");
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
  List<ProviderModel> avatarList = [];
  getCountries()
  async {
    prefs = await SharedPreferences.getInstance();
    //  token1 = prefs!.getString("token");
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
    var newLangItem = DropdownMenuItem(
      child: Text("Korea",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
      key: UniqueKey(),
      value: "1",
    );
    var newLangItem2 = DropdownMenuItem(
      child: Text("Chinees",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
      key: UniqueKey(),
      value: "2",
    );
    var newLangItem3 = DropdownMenuItem(
      child: Text("English",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
      key: UniqueKey(),
      value: "3",
    );
    var newJobItem = DropdownMenuItem(
      child: Text("Lawyer",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
      key: UniqueKey(),
      value: "1",
    );
    var newJobItem2 = DropdownMenuItem(
      child: Text("Mentor",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
      key: UniqueKey(),
      value: "2",
    );
    dropdownJobItems.add(newJobItem);
    dropdownJobItems.add(newJobItem2);
    dropdownLangItems.add(newLangItem);
    dropdownLangItems.add(newLangItem2);
    dropdownLangItems.add(newLangItem3);
    var newWorkItem  = DropdownMenuItem(
      child: Text("Less than 1 year",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
      key: UniqueKey(),
      value: "1",
    );
    var newWorkItem2  = DropdownMenuItem(
      child: Text("1 year",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
      key: UniqueKey(),
      value: "2",
    );
    var newWorkItem3  = DropdownMenuItem(
      child: Text("2 year",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
      key: UniqueKey(),
      value: "3",
    );
    var newWorkItem4  = DropdownMenuItem(
      child: Text("3 year",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
      key: UniqueKey(),
      value: "4",
    );
    var newWorkItem5  = DropdownMenuItem(
      child: Text("4 year",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
      key: UniqueKey(),
      value: "5",
    );
    var newWorkItem6  = DropdownMenuItem(
      child: Text("5 year",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
      key: UniqueKey(),
      value: "6",
    );
    var newWorkItem7  = DropdownMenuItem(
      child: Text("more than 5 year",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
      key: UniqueKey(),
      value: "7",
    );
    dropdownWorkItems.add(newWorkItem);
    dropdownWorkItems.add(newWorkItem2);
    dropdownWorkItems.add(newWorkItem3);
    dropdownWorkItems.add(newWorkItem4);
    dropdownWorkItems.add(newWorkItem5);
    dropdownWorkItems.add(newWorkItem6);
    setState(() {
    });
  }
  selectImage()
  async {
    FilePickerResult? result = await FilePicker.platform.pickFiles( allowedExtensions: ['jpg', 'pdf', 'png'],type: FileType.custom);
    if (result != null) {
      setState(() { loadImage=true;});
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
        // avatar=  "{\"uri\":\"$uri\",\"extension\":\"$extension\",\"type\":\"$type\",\"size\":\"$size\",\"name\":\"$name\",\"alt\":\"$alt\",\"data\":\"$data\"}";
        avatar=  "{uri:$uri,$extension,type:$type,size:$size,name:$name,alt:$alt,data:$data}";
        imageUri =
        responseUpload['data']['uri']; //"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//response["data"]["avatar"];

        setState(() { loadImage=false;});
      }
    }}
  getStatusProvider()
  async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   File file = File(result.files.single.path!);
  //  String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
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
  createProvider()
  async {
    try {
     // String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
      // var response = await (Services()).addFile( file);

     // SharedPreferences prefs = await SharedPreferences.getInstance();
     // String? lang = prefs.getString("lang_id");
      if (lang != null && lang!.trim().length > 0) {
        setState(() {
          loginLoading = true;
        });
        if(_chosenSourceValue==null ||_chosenSourceValue=="")
           _chosenSourceValue="3";
        // _chosenWorkValue="sth";
        // _chosenLangValue="korea";
        // _chosenJobValue="lawyer";
        String job="lawyer";
        String support="korea";

        if(_chosenJobValue=="2")
          job="mentor";
        String choosenwork="1";
        if(_chosenWorkValue=="1")
          choosenwork="Less than 1 year";
        if(_chosenWorkValue==""||_chosenWorkValue=="2")
          choosenwork="1 year";
        else
        if(_chosenWorkValue=="3")
          choosenwork="2 year";
        else
        if(_chosenWorkValue=="4")
          choosenwork="3 year";
        else
        if(_chosenWorkValue=="5")
          choosenwork="4 year";
        else
        if(_chosenWorkValue=="6")
          choosenwork="5 year";
        else
        if(_chosenWorkValue=="7")
          choosenwork="More than 5 year";

        var response = await (Services()).createProvider(token1!,projectId!,_phoneController!.text,_ageController!.text,_addressCtrl!.text,choosenwork,_chosenSourceValue!,lang!,support,job,"bbb",uri,extension,name,alt,size,data,type);
        if (response['statusCode'] != null && response['statusCode'] == 200) {
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
      }}
    catch (error) {
      print(error);
      setState(() {
        loginLoading = false;
      });
    }

  }
  updateProvider()
  async {
    try {
    //  String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
      // var response = await (Services()).addFile( file);

      if (lang != null && lang!.trim().length > 0) {
        setState(() {
          loginLoading = true;
        });
        if(_chosenSourceValue==null ||_chosenSourceValue=="")
          _chosenSourceValue="3";
        // _chosenWorkValue="sth";
        // _chosenLangValue="korea";
        // _chosenJobValue="lawyer";
        String job="lawyer";
        String work="korea";
        if(_chosenWorkValue=="2")
          job="chinees";
        else
        if(_chosenWorkValue=="3")
          job="english";

        if(_chosenJobValue=="2")
          job="mentor";

        String choosenwork="1";
        if(_chosenWorkValue=="1")
          choosenwork="Less than 1 year";
        if(_chosenWorkValue==""||_chosenWorkValue=="2")
          choosenwork="1 year";
        else
        if(_chosenWorkValue=="3")
          choosenwork="2 year";
        else
        if(_chosenWorkValue=="4")
          choosenwork="3 year";
        else
        if(_chosenWorkValue=="5")
          choosenwork="4 year";
        else
        if(_chosenWorkValue=="6")
          choosenwork="5 year";
        else
        if(_chosenWorkValue=="7")
          choosenwork="More than 5 year";
        var response = await (Services()). UpdateProvider(token1!,projectId!,_phoneController!.text,_ageController!.text,_addressCtrl!.text,choosenwork,_chosenSourceValue!,lang!,work,job,"bbb",uri,extension,name,alt,size,data,type);
        if (response['statusCode'] != null && response['statusCode'] == 200) {
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
      }}
    catch (error) {
      print(error);
      setState(() {
        loginLoading = false;
      });
    }

  }
  updateProvider2()
  async {
    try {
      //  String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
      // var response = await (Services()).addFile( file);

      if (lang != null && lang!.trim().length > 0) {
        setState(() {
          updateLoading = true;
        });
        if(_chosenSourceValue==null ||_chosenSourceValue=="")
          _chosenSourceValue="3";
        // _chosenWorkValue="sth";
        // _chosenLangValue="korea";
        // _chosenJobValue="lawyer";
        String job="lawyer";
        String work="korea";
        // if(_chosenWorkValue=="2")
        //   job="chinees";
        // else
        // if(_chosenWorkValue=="3")
        //   job="english";
String choosenwork="1";
        if(_chosenJobValue=="2")
          job="mentor";

        if(_chosenWorkValue=="1")
          choosenwork="Less than 1 year";
        if(_chosenWorkValue==""||_chosenWorkValue=="2")
          choosenwork="1 year";
        else
        if(_chosenWorkValue=="3")
          choosenwork="2 year";
        else
        if(_chosenWorkValue=="4")
          choosenwork="3 year";
        else
        if(_chosenWorkValue=="5")
          choosenwork="4 year";
        else
        if(_chosenWorkValue=="6")
          choosenwork="5 year";
        else
        if(_chosenWorkValue=="7")
          choosenwork="More than 5 year";
        var response = await (Services()). UpdateProvider(token1!,projectId!,_phoneController!.text,_ageController!.text,_addressCtrl!.text,choosenwork,_chosenSourceValue!,lang!,work,job,"bbb",uri,extension,name,alt,size,data,type);
        if (response['statusCode'] != null && response['statusCode'] == 200) {
          setState(() {
            updateLoading = false;
          });
          customNotification(false, response["message"], MediaQuery
              .of(context)
              .size
              .width, MediaQuery
              .of(context)
              .size
              .height);
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
            updateLoading = false;
          });
        }
      }}
    catch (error) {
      print(error);
      setState(() {
        updateLoading = false;
      });
    }

  }
  showProvider()
  async {
   //! String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    setState(() { loadImage=true;});
    var response = await (Services()).ShowProvider(  token1!,lang!,projectId!);
    if (lang != null && lang!.trim().length > 0) {
      // setState(() {
      //   loginLoading = true;
      // });
      try {
        // var response = await (Services()).getStatusProvider(token1);
        //  var response = await (Services()).Uploader(token1,"en");
        //  var response = await (Services()).UpdateProvider(token1,"09126666661","1","abc","aaa","4","en","korea","lawyer","bbb","");
        if (response['statusCode'] != null && response['statusCode'] == 200) {
          _ageController!.text=response["data"]["age"]??"";
          _phoneController!.text=response["data"]["phone"]??"";
          _phoneController!.text=response["data"]["phone"]??"";
          _addressCtrl!.text=response["data"]["address"]??"";
         // _chosenWorkValue=response["data"]["work_experience"]??"";
           _chosenSourceValue=response["data"]["source_country_id"]==null?"3":response["data"]["source_country_id"].toString();
          if(response["data"]["work_experience"]!=null &&response["data"]["work_experience"].toString().trim().toLowerCase().contains("Less than 1 year"))
            _chosenWorkValue="1";
        else  if(response["data"]["work_experience"].toString().trim().toLowerCase().contains("1 year"))
            _chosenWorkValue="2";
          else  if(response["data"]["work_experience"].toString().trim().toLowerCase().contains("2 year"))
            _chosenWorkValue="3";
          else  if(response["data"]["work_experience"].toString().trim().toLowerCase().contains("3 year"))
            _chosenWorkValue="4";
          else  if(response["data"]["work_experience"].toString().trim().toLowerCase().contains("4 year"))
            _chosenWorkValue="5";
          else  if(response["data"]["work_experience"].toString().trim().toLowerCase().contains("5 year"))
            _chosenWorkValue="6";
          else  if(response["data"]["work_experience"].toString().trim().toLowerCase().contains("more than 5 year"))
            _chosenWorkValue="7";
          if(response["data"]["job_title"]!=null &&response["data"]["job_title"].toString().toLowerCase().contains("lawyer"))
            _chosenJobValue="1";
          if(response["data"]["job_title"]!=null &&response["data"]["job_title"].toString().toLowerCase().contains("mentor"))
            _chosenJobValue="2";
          uri=response["data"]["avatar"]??"https://petroskadeh.com//uploads/7ed149666af28514ee2db1ccbc916ea2febb8744.png";
          extension='png';
          type='avatar';
          size='150192';
          name='image.png';
          alt='image.png';
          data='';
          imageUri=uri;//"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//response["data"]["avatar"];
          setState(() { loadImage=false;});
          setState(() {
            //  loginLoading = false;
          });
          // _chosenSourceValue=
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
          setState(() { loadImage=false;});
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
    getCountries();
    // showProvider();
    getStatusProvider();
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
              Text("Personal Information",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color:  Colors.white24,))),
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
                          // Text("Personal Information",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                          // SizedBox(height: 15,),

                          Padding(
                              padding:  EdgeInsets.only(left: 20),child:
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              GestureDetector(
                              onTap: () async {
                          selectImage();
                          },
                              child:

                                Container(
                                    height: 140.sp,
                                    width: 150.sp,
                                    decoration: BoxDecoration(
                                      //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                        border: Border.all(color: Colors.white,width: 1.4),
                                        borderRadius: BorderRadius.circular(10)),
                                    child:
                                   (imageUri==null ||   imageUri!.length<5) && !hasData?
                                     Center(child:   Text("Add picture",maxLines: 3,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color:  Colors.white,height: 2 ))):

                                        !loadImage?
                                    Center(child:      SizedBox(
                                      height: 140,
                                      width:150,
                                      child:imageUri==null||imageUri.toString().trim()==""? Center(child: Text("Add picture",maxLines: 3,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color:  Colors.white,height: 2 ))):

                                      CachedNetworkImage(
                                        imageUrl: imageUri!,
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
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      )
                                    //  Image.network(imageUri!,fit: BoxFit.cover,),
                                      // Text("Add Picture",style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color:  Colors.white,))
                                    )):
                                    Center(child:    Container(
                                      width: 24,
                                      height: 24,
                                      padding: const EdgeInsets.all(2.0),
                                      child: const CircularProgressIndicator(
                                        color: bgbuttonRed,
                                        strokeWidth: 3,
                                      ),
                                    ))
                                )
                                ),SizedBox(width: 10.sp,),

                                    Container(
                                        height: 70.sp,
                                        width: 100.sp,
                                        decoration: BoxDecoration(
                                          //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                            borderRadius: BorderRadius.circular(10)),
                                        child:     SizedBox(
                                            height: 80,
                                            width:90,
                                            child:
                                            Text("Upload .jpg or png 500*500 px",maxLines: 3,style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color:  Colors.white,height: 2 ))
                                        ))]))
                          ,
                          Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:20),
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
                                  ))

                          ),

                          Padding(
                              padding:  EdgeInsets.only(left:20,right: 20,top:20),
                              child:
                              TextFormField(
                                style:TextStyle(color:Colors.white),
                                controller: _addressCtrl,
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
                                  labelStyle:TextStyle(color:Colors.white),
                                  hintText: "Address",
                                  labelText: "Address",
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
                              controller: _phoneController,
                              style:TextStyle(color:Colors.white,fontSize:14 ,),
                              onTap: (){

                              },
                              // style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: "Phone Number",
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
                                labelText: "Phone Number",
                                alignLabelWithHint: false,
                                filled: true,
                                // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                              ),
                            ),
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
                                    items: dropdownJobItems,
                                    // hint: new Text("Select"),
                                    dropdownColor: bgGray,
                                    value: _chosenJobValue,
                                    hint: Text("Job Title",    style:TextStyle(color:Colors.white,fontSize:14 ,),),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _chosenJobValue= value!;
                                      });
                                    },
                                  ))),
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
                                    items: dropdownLangItems,
                                    // hint: new Text("Select"),
                                    dropdownColor: bgGray,
                                    value: _chosenLangValue,
                                    hint: Text("Support Language",    style:TextStyle(color:Colors.white,fontSize:14 ,),),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _chosenLangValue = value!;
                                      });
                                    },
                                  ))),
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
                                    items: dropdownWorkItems,
                                    // hint: new Text("Select"),
                                    dropdownColor: bgGray,
                                    value: _chosenWorkValue,
                                    hint: Text("Work experience",    style:TextStyle(color:Colors.white,fontSize:14 ,),),
                                    onChanged: (String? value) {
                                      setState(() {
                                        _chosenWorkValue= value!;
                                      });
                                    },
                                  ))),
                          Padding(
                              padding:  EdgeInsets.only(left:20,top:10.sp,bottom: 10,right: 20),
                              child:
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          if(hasData)
                                            updateProvider();
                                            else
                                          createProvider();
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
                                          if(hasData)
                                            updateProvider2();

                                        },child:
                                    updateLoading?
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
                  GestureDetector(
                      onTap: () async {
                        // Navigator.pushReplacementNamed(context, "/verification");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => listTimeline()),
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
