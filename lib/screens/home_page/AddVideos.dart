
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/AvatarModel.dart';
import 'package:redJAY/screens/home_page/PersonalInfo.dart';
import 'package:redJAY/screens/home_page/listTimeline.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ExtraInfo.dart';
import 'bPlanCreate.dart';


class AddVideo extends StatefulWidget {
  const AddVideo({Key? key}) : super(key: key);

  @override
  State<AddVideo> createState() => AddVideoState();
}

class AddVideoState extends State<AddVideo> {
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

String?  token1="";
String?  lang="";
String?  projectId="";
selectImage()
async {

  FilePickerResult? result = await FilePicker.platform.pickFiles( allowedExtensions: ['jpg', 'pdf', 'png'],type: FileType.custom);
  if (result != null) {
    setState(() { loadImage=true;});
    File file = File(result.files.single.path!);
  //  String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    var responseUpload = await (Services()).Uploader(token1!, lang!, file);
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
      imageUri2 =
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
   // String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
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
      imageUri3 =
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
selectImage4()
async {

  FilePickerResult? result = await FilePicker.platform.pickFiles( allowedExtensions: ['jpg', 'pdf', 'png'],type: FileType.custom);
  if (result != null) {
    setState(() { loadImage4=true;});
    File file = File(result.files.single.path!);
    // token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    var responseUpload = await (Services()).Uploader(token1!, lang!, file);
    if (responseUpload['statusCode'] != null && responseUpload['statusCode'] == 200) {
      uri4=responseUpload['data']['uri'];//"https://petroskadeh.com/uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//responseUpload['data']['uri'];
      extension4=responseUpload['data']['extension'];
      alt4=responseUpload['data']['alt'];
      name4=responseUpload['data']['name'];
      type4=responseUpload['data']['type'];
      size4=responseUpload['data']['size'].toString();
      data4=responseUpload['data']['data']??"";
      //    avatar=  "[{\"uri\":\"$uri\",\"extension\":\"$extension\",\"type\":\"$type\",\"size\":\"$size\",\"name\":\"$name\",\"alt\":\"$alt\",\"data\":\"$data\"}]";
      imageUri4 =
      responseUpload['data']['uri']; //"https://petroskadeh.com//uploads/272b621c1b23ba0937c6e3fbf256523f514dd37d.png";//response["data"]["avatar"];

      setState(() { loadImage4=false;});
      if( responseUpload["message"]!=null)
        customNotification(false, responseUpload["message"], MediaQuery
            .of(context)
            .size
            .width, MediaQuery
            .of(context)
            .size
            .height);

    }
  }}
createPresentation()
async {
  try {
    //String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    // var response = await (Services()).addFile( file);

    if (lang != null && lang!.trim().length > 0) {
      setState(() {
        loginLoading = true;
      });
      if(uri.length>6) {
        var response = await (Services()).createPresentation(
            token1!,
         projectId!,
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

          setState(() {
            loginLoading = false;
          });
        }
      }
      if(uri2.length>6) {
        var response = await (Services()).createPresentation(
            token1!,
            projectId!,
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


          setState(() {
            loginLoading = false;
          });
        }
      }
      if(uri3.length>6) {
        var response = await (Services()).createPresentation(
            token1!,projectId!,
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

          setState(() {
            loginLoading = false;
          });
        }
      }
      if(uri4.length>6) {
        var response = await (Services()).createPresentation(
            token1!,projectId!,
            lang!,
            uri4,
            extension4,
            name4,
            alt4,
            size4,
            data4,
            type4);
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

updatePresentation()
async {
  try {
    //String token1 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
    // var response = await (Services()).addFile( file);

    if (lang != null && lang!.trim().length > 0) {
      setState(() {
        loginLoading = true;
      });
      if(uri.length>6 && avatarList.length>0) {
        var response = await (Services()).updatePresentation(
            token1!,
            projectId!,
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

          setState(() {
            loginLoading = false;
          });
        }
      }
      else
        {
          if(uri.length>6 && avatarList.length==0 )
            {
              var response = await (Services()).createPresentation(
                  token1!,
                  projectId!,
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

                setState(() {
                  loginLoading = false;
                });
              }

            }

        }
      if(uri2.length>6 && avatarList.length>1) {
        var response = await (Services()).updatePresentation(
            token1!,
            projectId!,
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


          setState(() {
            loginLoading = false;
          });
        }
      }
      else
        {
          if(uri2.length>6&&avatarList.length<2)
          {
            var response = await (Services()).createPresentation(
                token1!,
                projectId!,
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

              setState(() {
                loginLoading = false;
              });
            }

          }
        }
      if(uri3.length>6  && avatarList.length>2) {
        var response = await (Services()).updatePresentation(
            token1!,projectId!,
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

          setState(() {
            loginLoading = false;
          });
        }
      }
      else
        {
          if(uri3.length>6&&avatarList.length<3)
          {
            var response = await (Services()).createPresentation(
                token1!,
                projectId!,
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

              setState(() {
                loginLoading = false;
              });
            }

          }
        }
      if(uri4.length>6  && avatarList.length>3) {
        var response = await (Services()).updatePresentation(
            token1!,projectId!,
            lang!,
            uri4,
            extension4,
            name4,
            alt4,
            size4,
            data4,
            type4,avatarList[3].id);
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

          setState(() {
            loginLoading = false;
          });
        }
      }
      else{
        if(uri4.length>6&&avatarList.length<4)
        {
          var response = await (Services()).createPresentation(
              token1!,
              projectId!,
              lang!,
              uri4,
              extension4,
              name4,
              alt4,
              size4,
              data4,
              type4);
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

            setState(() {
              loginLoading = false;
            });
          }

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

getStatusPresent()
async {

  if (lang != null && lang!.trim().length > 0) {
    // setState(() {
    //   loginLoading = true;
    // });
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
  var response = await (Services()).ShowPresentation(  token1!,lang!,projectId!);
  if (lang != null && lang!.trim().length > 0) {
    // setState(() {
    //   loginLoading = true;
    // });
    try {
      if (response['statusCode'] != null && response['statusCode'] == 200) {
          response['data'].forEach((element){
            avatarList.add(AvatarModel .fromJson2(element));
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
     // setState(() {
        // loginLoading = false;
     // });
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
  // lang ="en"; //prefs!.getString("lang_id");
  // projectId = "1";//prefs!.getString("project_id");
  // token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";

  lang =prefs!.getString("lang_id");//"en";
  projectId = prefs!.getString("project_id");//"1"
  token1=prefs!.getString("token");//"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
  getStatusPresent();
}
@override
  initState()  {
    super.initState();
    // lang ="en"; //prefs!.getString("lang_id");
    // projectId = "1";//prefs!.getString("project_id");
    // token1="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3BldHJvc2thZGVoLmNvbS9hcGkvbG9naW4iLCJpYXQiOjE3MDAxNDE1MDEsImV4cCI6MTcwMjczNDEwMSwibmJmIjoxNzAwMTQxNTAxLCJqdGkiOiJNSjRJdnZ3R2RJRk96ZFZGIiwic3ViIjoiMiIsInBydiI6IjQxZWZiN2JhZDdmNmY2MzJlMjQwNWJkM2E3OTNiOGE2YmRlYzY3NzcifQ._h5aFO7nNYf2greKkJBciPddXirAIpPWksbd84VErW8";
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
            Text("Images and Videos",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color:  Colors.white24,))),

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
                        children: <Widget>[
                          SizedBox(height: 20,),
                          // Text("Personal Information",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white)),
                          // SizedBox(height: 15,),

                          Padding(
                            padding:  EdgeInsets.only(left:40,right: 20,top: 10),
                            child:
    Row(
    mainAxisAlignment:
    MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      GestureDetector(

          onTap: () async {
            selectImage();
          },
          child:
          Container(
              height: 140.sp,
              width: 130.sp,
              decoration: BoxDecoration(
                //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10)),
              child:
              loadImage?
              Container(
                margin: new EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                width: 10,
                height: 10,
                child: const CircularProgressIndicator(
                  color: bgbuttonRed,
                  strokeWidth: 3,
                ),
              ):
              imageUri.length>5?

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
              ):
         //   CachedNetworkImageProvider(imageUri!):
        //    Image.network(imageUri!,fit: BoxFit.fitWidth,):
              Center(child:  Text('Add Image',
                  style: const TextStyle(
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 15 ,
                    color:Colors.black  ,
                    //  fontWeight: FontWeight.bold,
                  )),
              )
          )

      ),
    SizedBox(width: 10.sp,),
    GestureDetector(
    onTap: () async {selectImage2();},
      child:
      Container(
          height: 140.sp,
          width: 130.sp,
          decoration: BoxDecoration(
            //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10)),
          child:
          loadImage2?
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
            width: 10,
            height: 10,
            child: const CircularProgressIndicator(
              color: bgbuttonRed,
              strokeWidth: 3,
            ),
          ):
          imageUri2.length>5?


          //Image.network(imageUri2!,fit: BoxFit.fitWidth,):
          Center(child:  Text('Add Image2',
              style: const TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
                fontSize: 15 ,
                color:Colors.black  ,
                //  fontWeight: FontWeight.bold,
              )),
          ):null
      )

    )])
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left:40,right: 20,top:10),
                              child:
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start
                                  ,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(

                                        onTap: () async {selectImage3();},
                                        child:
                                        Container(
                                            height: 140.sp,
                                            width: 130.sp,
                                            decoration: BoxDecoration(
                                              //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                                color: Colors.white24,
                                                borderRadius: BorderRadius.circular(10)),
                                            child:
                                            loadImage3?
                                            Container(
                                              margin: new EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                                              width: 10,
                                              height: 10,
                                              child: const CircularProgressIndicator(
                                                color: bgbuttonRed,
                                                strokeWidth: 3,
                                              ),
                                            ):
                                            imageUri3.length>5?
                                           // Image.network(imageUri3!,fit: BoxFit.fitWidth,):

                                            CachedNetworkImage(
                                              imageUrl: imageUri3!,
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
                                            ):
                                            Center(child:  Text('Add Image3',
                                                style: const TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15 ,
                                                  color:Colors.black  ,
                                                  //  fontWeight: FontWeight.bold,
                                                )),
                                            )
                                        )

                                    ),
                                    SizedBox(width: 10,),
                                    GestureDetector(

                                        onTap: () async {selectImage4();},
                                        child:
                                        Container(
                                            height: 140.sp,
                                            width: 130.sp,
                                            decoration: BoxDecoration(
                                              //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                                color: Colors.white24,
                                                borderRadius: BorderRadius.circular(10)),
                                            child:
                                     loadImage4?
                                     Container(
                                         margin: new EdgeInsets.symmetric(horizontal: 40.0,vertical: 40),
                                         width: 10,
                                         height: 10,
                                       child: const CircularProgressIndicator(
                                         color: bgbuttonRed,
                                         strokeWidth: 3,
                                       ),
                                     ):
                                     imageUri4.length>5?
                                   //  Image.network(imageUri4!,fit: BoxFit.fitWidth,):
                                     CachedNetworkImage(
                                       imageUrl: imageUri4!,
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
                                     ):
                                           Center(child:  Text('Add Image4',
                                                style: const TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15 ,
                                                  color:Colors.black  ,
                                                  //  fontWeight: FontWeight.bold,
                                                )),
                                              )
                                             )

                                    )])
                          ),
                          Padding(
                              padding:  EdgeInsets.only(left:40,top:20),
                              child:
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(

                                        onTap: () async {},
                                        child:
                                        Container(
                                            height: 230.sp,
                                            width: 270.sp,
                                            decoration: BoxDecoration(
                                              //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                                                color: Colors.white24,
                                                borderRadius: BorderRadius.circular(10)),
                                            child:Center(child:      SizedBox(
                                              height: 50,
                                              width:50,
                                              child:
                                              Text('Add Video',
                                                style: const TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15 ,
                                                  color:Colors.black  ,
                                                  //  fontWeight: FontWeight.bold,
                                                ),
                                              )

                                            )))

                                    ),
                                 ])
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
                                        if(hasData)
                                          updatePresentation();
                                        else
                                           createPresentation();
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
                                            //
                                            // if(hasData)
                                            //   updatePresentation();
                                            // else
                                            //   createPresentation();

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
                      )))
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
