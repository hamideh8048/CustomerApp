
import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redJAY/models/LangModel.dart';
import 'package:redJAY/screens/home_page/widgets/CircleList%20.dart';
import 'package:redJAY/screens/home_page/widgets/RadialDragGestureDetector.dart';
import 'package:redJAY/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

import 'package:video_player/video_player.dart';

class Sample extends StatefulWidget {
  const Sample({Key? key}) : super(key: key);
  @override
  State<Sample> createState() => _SampleState();
}
class _SampleState extends State<Sample> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  String jayTitle="";
  String jayDetail="";

  void storeProject(String projectId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("project_id", projectId);
    // getUserInfo(tokenResult);
  }
  @override
  void initState() {
    Timer(Duration(seconds: 15), () {
      storeProject("1");
      Navigator.pushReplacementNamed(context, "/lang");
    });

    getProject();
    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //     'https://drive.google.com/file/d/1EloO_5RjFVYXX1O6L4J92iLdCT-oPeY0/view?usp=drive_link',
    //     //'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    //   ),
    _controller = VideoPlayerController.asset('assets/video/first.mp4',);
    animationController = AnimationController(
      upperBound: pi * 2,
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    //   _secondController.play();
    _controller.play();
    super.initState();
  }
double iconSi=170;
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  Color jayColor=Colors.grey;
String name="jayText3";
  List<int> elements = List.generate(6, (index) => index);
int selecteIndex=0;
  _center(int index) {
  //  double angle = (pi * 2)*0.9 ;
    if(index==0)
      {
       LangModel? model= langList.where((elemen) => elemen.id=="4").firstOrNull;
       jayDetail=model!.detail;
       //jayTitle=model.title;
        jayColor=Colors.pink;
      }
    else  if(index==1)
    {jayColor=Colors.yellow;
    LangModel? model= langList.where((elemen) => elemen.id=="1").firstOrNull;
    jayDetail=model!.detail;

    }
    else  if(index==2)
    {jayColor=Colors.red;
    LangModel? model= langList.where((elemen) => elemen.id=="2").first;
    jayDetail=model.detail;
    }
    else  if(index==3)
    {jayColor=Colors.green;
    LangModel? model= langList.where((elemen) => elemen.id=="5").first;
    jayDetail=model.detail;
    }
    else  if(index==4)
    {jayColor=Colors.grey;
    LangModel? model= langList.where((elemen) => elemen.id=="6").firstOrNull;
    jayDetail=model!.detail;
    }
    else  if(index==5)
    {jayColor=Colors.white;
    LangModel? model= langList.where((elemen) => elemen.id=="3").first;
    jayDetail=model.detail;
    }
  final  angle =(pi * 2) * (index / 6);
//  final  angle =(pi * 2) * (0.15*index );
   // final angle = (pi * 2);
    //animationController.animateTo(angle);
    print("angel"+angle.toString());
    //if(angle>0)
   // if(angle>1){

    selecteIndex=index;
      print("angel"+angle.toString());
   setState(() { iconSi=170.sp;name="jayText"+index.toString();});

    animationController.forward();//.animateTo(angle);
   // animationController.animateTo(angle);//.animateTo(angle);
    }
  List<LangModel>langList = [];
  getProject()
  async {
    var response = await (Services()).getProjects();
    if (response['statusCode'] != null&&response['statusCode']==200)
      response["data"].forEach((element){
        langList .add(LangModel.fromJson2(element));
      });
    // for (LangModel lang in langList) {
    //   var newItem = DropdownMenuItem(
    //     child: Text(lang.title,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white)),
    //     value: lang.id,
    //   );
    //   dropdownItems.add(newItem);
    // }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future:_initializeVideoPlayerFuture ,
        //  future:_initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return
              Stack(
                  alignment: Alignment.topCenter,
                  children: [

                    Center(child: AspectRatio(
                      // aspectRatio:_controller.value.aspectRatio,
                      aspectRatio:_controller.value.aspectRatio,
                      // Use the VideoPlayer widget to display the video.
                      child: VideoPlayer(_controller),)
                      //  child: VideoPlayer(_controller),)
                    ),
                    Padding(padding: EdgeInsets.only(top:70,right:200.sp ),child:
                    //  Text("Extra Information",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color:  Colors.blue,))
                    Image.asset("assets/images/$name.png",width: 180,)
                    ),
                    Padding(padding: EdgeInsets.only(top:140.sp,right: 230.sp ),child:
                    Container(
                        height: 80.sp,
                        width:MediaQuery.of(context).size.width*0.35,
                        decoration: BoxDecoration(
                          //color: _tabController!.index == 1 ? bgGray : Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child:
                        DottedBorder(
                            color: jayColor,
                            dashPattern: [8, 4],
                            strokeWidth: 2,
                            child:
                            Padding(padding:EdgeInsets.only(left: 10),child:
                            Text("$jayDetail",maxLines: 3,
                                style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.bold,color:  Colors.black,height: 2 )
                            ))))),
                    AnimatedBuilder(
                      animation: animationController,
                      builder: ((context, child) {
                        return CircleList(
                          onDragEnd: () => {},
                          initialAngle: -animationController.value - pi / 4,
                          centerWidget:
                          Text(''),
                          rotateMode: RotateMode.onlyChildrenRotate,
                          origin: Offset(150, -10),
                          children: elements
                              .map(
                                (index) => IconButton(
                              onPressed: () => _center(index),
                              icon: (new Image.asset("assets/images/jay$index.png")),iconSize:selecteIndex==index? iconSi:110,
                              // icon:new  Image.asset("assets/images/yellow.png", size: 35),
                              color: Colors.blue.withOpacity(index * 0.05 + .3),
                            ),
                          )
                          //   https://drive.google.com/file/d/1EloO_5RjFVYXX1O6L4J92iLdCT-oPeY0/view?usp=sharing
                              .toList(),
                        );
                      }),
                    ),
                  ]);
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

    );
  }
}
