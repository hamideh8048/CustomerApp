
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/ExtraModel.dart';
import 'package:redJAY/screens/home_page/AddVideos.dart';
import 'package:redJAY/screens/home_page/PersonalInfo.dart';
import 'package:redJAY/screens/home_page/listTimeline.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ExtraInfo extends StatefulWidget {
  const ExtraInfo({Key? key}) : super(key: key);

  @override
  State<ExtraInfo> createState() => ExtraInfoState();
}

class ExtraInfoState extends State<ExtraInfo> {
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
  TextEditingController _countCtrl= TextEditingController();
  TextEditingController _countCtrl2= TextEditingController();
  TextEditingController _countCtrl3= TextEditingController();
  TextEditingController _passCtrl= TextEditingController();
  TextEditingController _rePassCtrl= TextEditingController();
  bool repasswordVisible=false;
  bool passwordVisible=false;
String uri="";
String extension="png";
String type="avatar";
String alt="image.png";
String name="image.png";
String data="";
String size="140";
String uri2="";
String extension2="";
String type2="avatar";
String alt2="image.png";
String name2="image.png";
String data2="";
String size2="140";
String uri3="";
String extension3="";
String type3="avatar";
String alt3="image.png";
String name3="image.png";
String data3="";
String size3="140";
@override
void dispose() {
  // Clean up the controller when the widget is removed from the widget tree.
  // This also removes the _printLatestValue listener.
  _passCtrl.dispose();
  _rePassCtrl.dispose();
  _countCtrl.dispose();
  super.dispose();
}
bool loadImage=false;
bool loadImage2=false;
bool loadImage3=false;
String avatar="";
String imageUri ="";
bool hasData=false;
String?  token1="";
String?  lang="";
String?  projectId="";
selectImage()
async {

  FilePickerResult? result = await FilePicker.platform.pickFiles( allowedExtensions: ['jpg', 'pdf', 'png'],type: FileType.custom);
  if (result != null) {
   setState(() { loadImage=true;});
  File file = File(result.files.single.path!);
    //String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    var responseUpload = await (Services()).Uploader(token1!, "en", file);
    if (responseUpload['statusCode'] != null && responseUpload['statusCode'] == 200) {
      uri=responseUpload['data']['uri'];//"https://petroskadeh.com/uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//responseUpload['data']['uri'];
      extension=responseUpload['data']['extension'];
      alt=responseUpload['data']['alt'];
      name=responseUpload['data']['name'];
      type=responseUpload['data']['type'];
      size=responseUpload['data']['size'].toString();
      data=responseUpload['data']['data']??"";
     //    avatar=  "[{\"uri\":\"$uri\",\"extension\":\"$extension\",\"type\":\"$type\",\"size\":\"$size\",\"name\":\"$name\",\"alt\":\"$alt\",\"data\":\"$data\"}]";
      imageUri =
      responseUpload['data']['uri']; //"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//response["data"]["avatar"];
      loadImage=false;
      if( responseUpload["message"]!=null)
      customNotification(false, responseUpload["message"], MediaQuery
          .of(context)
          .size
          .width, MediaQuery
          .of(context)
          .size
          .height);
     setState(() {});
    }
  }}
selectImage2()
async {

  FilePickerResult? result = await FilePicker.platform.pickFiles( allowedExtensions: ['jpg', 'pdf', 'png'],type: FileType.custom);
  if (result != null) {
    setState(() { loadImage2=true;});
    File file = File(result.files.single.path!);
   // String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    var responseUpload = await (Services()).Uploader(token1!, lang!, file);
    if (responseUpload['statusCode'] != null && responseUpload['statusCode'] == 200) {
      uri2=responseUpload['data']['uri'];//"https://petroskadeh.com/uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//responseUpload['data']['uri'];
      extension2=responseUpload['data']['extension'];
      alt2=responseUpload['data']['alt'];
      name2=responseUpload['data']['name'];
      type2=responseUpload['data']['type'];
      size2=responseUpload['data']['size'].toString();
      data2=responseUpload['data']['data']??"";
      //    avatar=  "[{\"uri\":\"$uri\",\"extension\":\"$extension\",\"type\":\"$type\",\"size\":\"$size\",\"name\":\"$name\",\"alt\":\"$alt\",\"data\":\"$data\"}]";
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
      setState(() {});
    }
  }}
selectImage3()
async {

  FilePickerResult? result = await FilePicker.platform.pickFiles( allowedExtensions: ['jpg', 'pdf', 'png'],type: FileType.custom);
  if (result != null) {
    setState(() { loadImage3=true;});
    File file = File(result.files.single.path!);
    //String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    var responseUpload = await (Services()).Uploader(token1!, lang!, file);
    if (responseUpload['statusCode'] != null && responseUpload['statusCode'] == 200) {
      uri3=responseUpload['data']['uri'];//"https://petroskadeh.com/uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//responseUpload['data']['uri'];
      extension3=responseUpload['data']['extension'];
      alt3=responseUpload['data']['alt'];
      name3=responseUpload['data']['name'];
      type3=responseUpload['data']['type'];
      size3=responseUpload['data']['size'].toString();
      data3=responseUpload['data']['data']??"";
      //    avatar=  "[{\"uri\":\"$uri\",\"extension\":\"$extension\",\"type\":\"$type\",\"size\":\"$size\",\"name\":\"$name\",\"alt\":\"$alt\",\"data\":\"$data\"}]";
      imageUri =
      responseUpload['data']['uri']; //"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//response["data"]["avatar"];
      loadImage3=false;
      if( responseUpload["message"]!=null)
      customNotification(false, responseUpload["message"], MediaQuery
          .of(context)
          .size
          .width, MediaQuery
          .of(context)
          .size
          .height);
      setState(() {});
    }
  }}
createExtra()
async {
  try {
    //String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    // var response = await (Services()).addFile( file);

    if (lang != null && lang!.trim().length > 0) {
      setState(() {
        loginLoading = true;
      });
      if(uri.length>6) {
        var response = await (Services()).createExtra(
            token1!,projectId!,
            _countCtrl.text,
            lang!,
            uri,
            extension,
            name,
            alt,
            size,
            data,
            type);
        if (response['statusCode'] != null && response['statusCode'] == 200) {
          setState(() {
            loginLoading = false;
          });
          if( response["message"]!=null)
          customNotification(false, response["message"], MediaQuery
              .of(context)
              .size
              .width, MediaQuery
              .of(context)
              .size
              .height);
        }
        else {
          if( response["message"]!=null)
          customNotification(true, response["message"], MediaQuery
              .of(context)
              .size
              .width, MediaQuery
              .of(context)
              .size
              .height);
          _countCtrl.text = "";
          setState(() {
            loginLoading = false;
          });
        }
      }
      if(uri2.length>6) {
        var response = await (Services()).createExtra(
            token1!,projectId!,
            _countCtrl2.text,
            lang!,
            uri2,
            extension2,
            name2,
            alt2,
            size2,
            data2,
            type2);
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
          _countCtrl.text = "";

          setState(() {
            loginLoading = false;
          });
        }
      }
      if(uri3.length>6) {
        var response = await (Services()).createExtra(
            token1!,projectId!,
            _countCtrl3.text,
            lang!,
            uri3,
            extension3,
            name3,
            alt3,
            size3,
            data3,
            type3);
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
          _countCtrl.text = "";

          setState(() {
            loginLoading = false;
          });
        }
      }
    }}
  catch (error) {
    print(error);
    setState(() {
      loginLoading = false;
    });
  }

}
updateExtra()
async {
  try {
    //String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    // var response = await (Services()).addFile( file);

    if (lang != null && lang!.trim().length > 0) {
      setState(() {
        loginLoading = true;
      });

        if(uri.length>6 && avatarList.length>0) {
        var response = await (Services()).updateExtra(
            token1!,projectId!,
            _countCtrl.text,
            lang!,
            uri,
            extension,
            name,
            alt,
            size,
            data,
            type,avatarList[0].id);
        if (response['statusCode'] != null && response['statusCode'] == 200) {
          setState(() {
            loginLoading = false;
          });
          if( response["message"]!=null)
            customNotification(false, response["message"], MediaQuery
                .of(context)
                .size
                .width, MediaQuery
                .of(context)
                .size
                .height);
        }
        else {
          if( response["message"]!=null)
            customNotification(true, response["message"], MediaQuery
                .of(context)
                .size
                .width, MediaQuery
                .of(context)
                .size
                .height);
          _countCtrl.text = "";
          setState(() {
            loginLoading = false;
          });
        }
      }
        else
        {
          if(uri.length>6 && avatarList.length==0 )
          {
            var response = await (Services()).createExtra(
                token1!,projectId!,
                _countCtrl.text,
                lang!,
                uri,
                extension,
                name,
                alt,
                size,
                data,
                type);
            if (response['statusCode'] != null && response['statusCode'] == 200) {
              setState(() {
                loginLoading = false;
              });
              if( response["message"]!=null)
                customNotification(false, response["message"], MediaQuery
                    .of(context)
                    .size
                    .width, MediaQuery
                    .of(context)
                    .size
                    .height);
            }
            else {
              if( response["message"]!=null)
                customNotification(true, response["message"], MediaQuery
                    .of(context)
                    .size
                    .width, MediaQuery
                    .of(context)
                    .size
                    .height);
              _countCtrl.text = "";
              setState(() {
                loginLoading = false;
              });
            }
          }}
      if(uri2.length>6 && avatarList.length>1){
        var response = await (Services()).updateExtra(
            token1!,projectId!,
            _countCtrl2.text,
            lang!,
            uri2,
            extension2,
            name2,
            alt2,
            size2,
            data2,
            type2,avatarList[1].id);
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
          _countCtrl.text = "";

          setState(() {
            loginLoading = false;
          });
        }
      }
      else
      {
        if(uri2.length>6&&avatarList.length<2)
        {

          var response = await (Services()).createExtra(
              token1!,projectId!,
              _countCtrl2.text,
              lang!,
              uri2,
              extension2,
              name2,
              alt2,
              size2,
              data2,
              type2);
          if (response['statusCode'] != null && response['statusCode'] == 200) {
            setState(() {
              loginLoading = false;
            });
            if( response["message"]!=null)
              customNotification(false, response["message"], MediaQuery
                  .of(context)
                  .size
                  .width, MediaQuery
                  .of(context)
                  .size
                  .height);
          }
          else {
            if( response["message"]!=null)
              customNotification(true, response["message"], MediaQuery
                  .of(context)
                  .size
                  .width, MediaQuery
                  .of(context)
                  .size
                  .height);
            _countCtrl2.text = "";
            setState(() {
              loginLoading = false;
            });
          }
        }}
      if(uri3.length>6  && avatarList.length>2) {
        var response = await (Services()).updateExtra(
            token1!,projectId!,
            _countCtrl3.text,
            lang!,
            uri3,
            extension3,
            name3,
            alt3,
            size3,
            data3,
            type3,avatarList[2].id);
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
          _countCtrl3.text = "";

          setState(() {
            loginLoading = false;
          });
        }
      }
      else
      {
        if(uri3.length>6&&avatarList.length<3)
        {

          var response = await (Services()).createExtra(
              token1!,projectId!,
              _countCtrl3.text,
              lang!,
              uri3,
              extension3,
              name3,
              alt3,
              size3,
              data3,
              type3);
          if (response['statusCode'] != null && response['statusCode'] == 200) {
            setState(() {
              loginLoading = false;
            });
            if( response["message"]!=null)
              customNotification(false, response["message"], MediaQuery
                  .of(context)
                  .size
                  .width, MediaQuery
                  .of(context)
                  .size
                  .height);
          }
          else {
            if( response["message"]!=null)
              customNotification(true, response["message"], MediaQuery
                  .of(context)
                  .size
                  .width, MediaQuery
                  .of(context)
                  .size
                  .height);
            _countCtrl.text = "";
            setState(() {
              loginLoading = false;
            });
          }
        }}
    }}
  catch (error) {
    print(error);
    setState(() {
      loginLoading = false;
    });
  }

}
getStatusExtra()
async {
  // FilePickerResult? result = await FilePicker.platform.pickFiles();
  // if (result != null) {
  //   File file = File(result.files.single.path!);
  //String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
  //imageUri="https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//response["data"]["avatar"];

  if (lang != null && lang!.trim().length > 0) {
    // setState(() {
    //   loginLoading = true;
    // });
    try {

      //  var response = await (Services()).UpdateProvider(token1,"09126666661","1","abc","aaa","4","en","korea","lawyer","bbb","");
      var response = await (Services()).getStatusExtra(token1!,projectId!,lang!);
      if (response['statusCode'] != null && response['statusCode'] == 200) {
        // setState(() {
        //   loginLoading = false;
        // });
        hasData=response['data']['status'];
        if(hasData)
        {
          showExtra();
        }

      } else {
        customNotification(true, response["message"], MediaQuery
            .of(context)
            .size
            .width, MediaQuery
            .of(context)
            .size
            .height);
        _countCtrl.text = "";
        _countCtrl2.text = "";
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
List<ExtraModel> avatarList = [];
showExtra()
async {
 // String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
  var response = await (Services()).ShowExtra(  token1!,lang!,projectId!);

  if (lang != null && lang!.trim().length > 0) {
    // setState(() {
    //   loginLoading = true;
    // });
    try {
      if (response['statusCode'] != null && response['statusCode'] == 200) {
        response['data'].forEach((element){
          avatarList.add(ExtraModel .fromJson2(element));
          //  taradods.add(TaradodListModel.fromJson(element));
        });
        int index=0;
        if(avatarList.length>3)
        index=avatarList.length-3;
        for(int i = index; i < avatarList.length; i++){
          if(i==index) {
            _countCtrl!.text = avatarList[i].count;
            uri=avatarList[i].uri;

          }
          if(i==index+1) {
            _countCtrl2!.text = avatarList[i].count;
           uri2=avatarList[i].uri;
          }
          if(i==index+2)
            _countCtrl3!.text=avatarList[i].count;
          uri3=avatarList[i].uri;
        }
       // uri=response["data"]["avatar"]??"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";
       //  extension='png';
       //  type='avatar';
       //  size='150192';
       //  name='image.png';
       //  alt='image.png';
       //  data='';
       //  imageUri=uri;//"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//response["data"]["avatar"];
        setState(() {
          //  loginLoading = false;
        });


      } else {
        customNotification(true, response["message"], MediaQuery
            .of(context)
            .size
            .width, MediaQuery
            .of(context)
            .size
            .height);
       _countCtrl.text = "";
        //_passCtrl.text = "";
        // setState(() {
        //   loginLoading = false;
        // });
      }
    } catch (error) {
      print(error);
      setState(() {
       // loginLoading = false;
      });
    }
  }
}
getValueFromPref()async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // lang ="en"; //prefs!.getString("lang_id");
  // projectId = "1";//prefs!.getString("project_id");
  // token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";

  lang =prefs!.getString("lang_id");//"en";
  projectId = prefs!.getString("project_id");//"1"
  token1=prefs!.getString("token");//"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
  getStatusExtra();
}
@override
  initState()  {
    super.initState();
    getValueFromPref();
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
            Text("Extra Information",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color:  Colors.white24,))),

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
                          SizedBox(height: 70,),
                          // Text("Personal Information",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                          // SizedBox(height: 15,),
                          Padding(
                            padding:  EdgeInsets.only(left:20,right: 20),
                            child:
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox( width: 250.sp,child:
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _countCtrl,
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
                                  )),
                                  SizedBox(width: 10.sp,),
                                  Container(
                                      height: 50.sp,
                                      width: 50.sp,
                                      decoration: BoxDecoration(
                                        //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                          border: Border.all(color: Colors.white,width: 1.4),
                                          borderRadius: BorderRadius.circular(10)),
                                      child:
                                     loadImage?
                                        Container(
                                          margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                          width: 10,
                                          height: 10,
                                          child:  CircularProgressIndicator(
                                          color: bgbuttonRed,
                                          strokeWidth: 3,
                                        ),
                                      )
                                      :
                                      GestureDetector(
                                          onTap: () async {
                                            selectImage();
                                          },
                                          child:
                                      Center(child:

                                      Image.asset("assets/images/attachment.png", fit: BoxFit.cover,width: 25.sp,),
                                      )

                                  ))
                                ])
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left:20,right: 20,top:20),
                            child:
                                Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox( width: 250.sp,child:
                                 TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _countCtrl2,
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
                            )),
                                  SizedBox(width: 10.sp,),
                                      Container(
                                          height: 50.sp,
                                          width: 50.sp,
                                          decoration: BoxDecoration(
                                            //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                              border: Border.all(color: Colors.white,width: 1.4),
                                              borderRadius: BorderRadius.circular(10)),
                                          child:
                                          loadImage2?

                                          Container(
                                            margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                            width: 10,
                                            height: 10,
                                            child:  CircularProgressIndicator(
                                              color: bgbuttonRed,
                                              strokeWidth: 3,
                                            ),
                                          )
                                              :
                                          GestureDetector(
                                              onTap: () async {
                                                selectImage();
                                              },
                                              child:
                                              Center(child:

                                              Image.asset("assets/images/attachment.png", fit: BoxFit.cover,width: 25.sp,),
                                              )

                                          ))
                                ])
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left:20,top:20.sp,bottom: 0,right: 20),
                              child:
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox( width: 250.sp,child:
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _countCtrl3,
                                      style:TextStyle(color:Colors.white,fontSize:14 ,),
                                      onTap: (){
                                      },
                                      // style: Theme.of(context).textTheme.bodyText1,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        hintText: "Successful Businesses",
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
                                        labelText: "Successful Businesses",
                                        alignLabelWithHint: false,
                                        filled: true,
                                        // prefixIcon: Icon(prefixIcon, color: Colors.black12),
                                      ),
                                    )),
                                    SizedBox(width: 10.sp,),
                                    Container(
                                        height: 50.sp,
                                        width: 50.sp,
                                        decoration: BoxDecoration(
                                          //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                            border: Border.all(color: Colors.white,width: 1.4),
                                            borderRadius: BorderRadius.circular(10)),
                                        child:
                                        loadImage3?

                                        Container(
                                          margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                          width: 10,
                                          height: 10,
                                          child:  CircularProgressIndicator(
                                            color: bgbuttonRed,
                                            strokeWidth: 3,
                                          ),
                                        )
                                            :
                                        GestureDetector(
                                            onTap: () async {
                                              selectImage();
                                            },
                                            child:
                                            Center(child:

                                            Image.asset("assets/images/attachment.png", fit: BoxFit.cover,width: 25.sp,),
                                            )

                                        ))
                                  ])
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left:20,top:50.sp,bottom: 10,right: 20),
                              child:
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
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
                                    GestureDetector(
                                        onTap: () async {
                                          if(hasData)
                                            updateExtra();
                                          else
                                            createExtra();
                                 //   createExtra();

                                        },child:
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
                                    ))),
                                    GestureDetector(
                                        onTap: () async {

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
                  GestureDetector(
                      onTap: () async {
                        // Navigator.pushReplacementNamed(context, "/verification");
                        Navigator.push(
                          context,
                         // MaterialPageRoute(builder: (context) =>  PersonalInfo()),
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
                      )))
              )
            ]))
    );



  }

}
