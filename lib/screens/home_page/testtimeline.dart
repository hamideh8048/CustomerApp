
import 'dart:io';
import 'dart:ui';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/rendering.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/models/BussinessModel.dart';
import 'package:redJAY/models/LangModel.dart';
import 'package:redJAY/models/PartModel.dart';
import 'package:redJAY/models/ProviderModel.dart';
import 'package:redJAY/screens/home_page/AddVideos.dart';
import 'package:redJAY/screens/home_page/ExtraInfo.dart';
import 'package:redJAY/screens/home_page/listTimeline.dart';
import 'package:redJAY/screens/home_page/widgets/part_dialog.dart';
import 'package:redJAY/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelines/timelines.dart';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
class testtimeline extends StatefulWidget {
  const  testtimeline({Key? key,this.bussinessModel}) : super(key: key);
 // const  testtimeline({Key? key}) : super(key: key);
final BussinessModel? bussinessModel;
  @override
  State< testtimeline> createState() =>  testtimelineState();
}

class  testtimelineState extends State<testtimeline> {
  String _chosenValue="es";
  static GlobalKey previewContainer = new GlobalKey();
  int _counter = 0;
  List<LangModel>langList = [];
  String companyLogo="";
  List<DropdownMenuItem<String>> dropdownItems = [];
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
  getLang()
  async {

    var response = await (Services()).getLang();

    if (response['statusCode'] != null&&response['statusCode']==200)
      response["data"].forEach((element){
        langList .add(LangModel.fromJson(element));
      });
    for (LangModel lang in langList) {
      var newItem = DropdownMenuItem(
        child: Text(lang.label,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
        value: lang.title,
      );
      dropdownItems.add(newItem);
    }
    setState(() {

    });
  }
  @override
  initState()  {
    super.initState();
    if(mounted){
      getLang();
    }
  }
  @override
  Widget build(BuildContext context) {

    return RepaintBoundary(
        key: previewContainer,
        child: new Scaffold(
          appBar: new AppBar(

            title: new Text("salam"),
          ),
          body:
          Center(child:
          SizedBox(
              height: MediaQuery.of(context).size.height*.42,
              width: MediaQuery.of(context).size.width*0.66,
              child:
              Container(

                  decoration: BoxDecoration(
                    //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                    color:   greyLangColor,//Colors.white60,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0)),
                  ),child:
              Column(
                //  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Please slect language",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
                    SizedBox(height: 10,),
                    DropdownButton<String>(
                      items: dropdownItems,
                      dropdownColor: bgGray,
                      value: _chosenValue,
                      // hint: Text("select language"),
                      onChanged: (String? value) {
                        setState(() {
                          _chosenValue = value!;
                        });
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top:100.sp),child:
                    GestureDetector(child:

                    Container(
                      width: 130,
                      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.sp),
                          color: Colors.white//.withOpacity(0.1)
                      ),
                      child:Center(child: Text('Next',
                        style: const TextStyle(
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                          fontSize: 16 ,
                          color:bgbuttonRed ,
                          //  fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),onTap:() {
                      _captureSocialPng();
                      //   storeLang(_chosenValue);
                      // Navigator.pushNamed(context,"/login");
                    },
                    ),
                    ),
                  ])))),
          // new Center(
          //   child: new Column(
          //
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       new Text(
          //         'You have pushed the button this many times:',
          //       ),
          //       new Text(
          //         '$_counter',
          //
          //       ),
          //       new ElevatedButton(
          //         onPressed: _captureSocialPng,
          //         child: const Text('Take a Screenshot'),
          //       ),
          //     ],
          //   ),
          // ),
          floatingActionButton: new FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        )
    );
  }
  takeScreenShot() async{
    // var scr= new GlobalKey();
    // RenderRepaintBoundary boundary1 =
    // scr.currentContext!.findRenderObject() as RenderRepaintBoundary;
    // var image2 = await boundary.toImage();
    // var byteData = await image.toByteData(format: ImageByteFormat.png);
    // var pngBytes = byteData!.buffer.asUint8List();
    // print(pngBytes);


    RenderRepaintBoundary boundary = previewContainer.currentContext!.findRenderObject()as RenderRepaintBoundary;;
    ui.Image image = await boundary!.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    print(pngBytes);
    File imgFile =new File('$directory/screenshot.png');
    imgFile.writeAsBytes(pngBytes);

  }
  Future<void> _captureSocialPng() {
    List<String> imagePaths = [];
    final RenderBox box = context.findRenderObject() as RenderBox;
    return new Future.delayed(const Duration(milliseconds: 20), () async {
      RenderRepaintBoundary? boundary = previewContainer.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage();

      // nternal Root Dir
      String downloadsPath = (await DownloadsPath.downloadsDirectory())?.path ??
          "Downloads path doesn't exist";
      //final extDir = await getExternalStorageDirectory();
      final directory = (await getApplicationDocumentsDirectory()).path;

      print("direct"+directory);
      ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
 //    File imgFile = new File('$directory/screenshot.png');
     File imgFile = new File('$downloadsPath/screenshot.png');


      imagePaths.add(imgFile.path);
      imgFile.writeAsBytes(pngBytes).then((value) async {
        await Share.shareFiles(imagePaths,
            subject: 'Share',
            text: 'Check this Out!',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      }).catchError((onError) {
        print(onError);
      });
    });
  }
}
