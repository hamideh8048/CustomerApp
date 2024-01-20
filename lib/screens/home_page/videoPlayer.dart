import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redJAY/components/constants.dart';
import 'package:redJAY/screens/home_page/selectCustomer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late VideoPlayerController _secondController;
  late Future<void> _initializeVideoPlayerFuture;
  late Future<void> _initializeSecondVideoPlayerFuture;
 bool secondVideo=false;
  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://www.petroskadeh.com/11.mp4',
        //'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    );

    _secondController = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://www.petroskadeh.com/12.mp4',
        //'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();
  _initializeSecondVideoPlayerFuture = _secondController.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

 //   _secondController.play();
    _controller.play();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
   // _secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.black,
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future:!secondVideo? _initializeVideoPlayerFuture: _initializeSecondVideoPlayerFuture ,
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
             aspectRatio:!secondVideo ?_controller.value.aspectRatio:_secondController.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
             child: VideoPlayer(!secondVideo ?_controller:_secondController),)
            //  child: VideoPlayer(_controller),)
            ),
                  Positioned(
                      top:MediaQuery.of(context).size.width*0.78,
                      right: 60.sp,
                      child:
                      !secondVideo?
                      GestureDetector(
                      onTap: (){
                        Timer(Duration(seconds: 5), () {
                         // Navigator.push(context, MaterialPageRoute(builder: (_) => PersonalInfo()));
                          Navigator.push(context, MaterialPageRoute(builder: (_) => SelectCustomer()));
                        });
                        setState(() {
                         secondVideo=true;
                      //   _controller.dispose();
                        //_initializeVideoPlayerFuture=_secondController.initialize();
                         _secondController.play();
                        });
                      },child:
                      Container(
                        height: 30.sp,
                        width: 110.sp,
                        //  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            color:bgGray2 //.withOpacity(0.1)
                        ),
                        child:Center(child: Text('Human',
                          style: const TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 15 ,
                            color: greyColor3   ,
                            //  fontWeight: FontWeight.bold,
                          ),
                        )),
                      )):Container()
                  ),
                  Positioned(
                      top:MediaQuery.of(context).size.width*0.78,
                      right: 190.sp,
                      child:
                          !secondVideo?
                      Container(
                        height: 30.sp,
                        width: 110.sp,
                        //  padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.sp),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.sp),
                            color:bgGray2 //.withOpacity(0.1)
                        ),
                        child:Center(child: Text('Robot',
                          style: const TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 15 ,
                            color: greyColor3   ,
                            //  fontWeight: FontWeight.bold,
                          ),
                        )),
                      ):Container()
                  )
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
  }}