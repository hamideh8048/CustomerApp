import 'package:flutter/material.dart';
class BoxSwapWidget extends StatelessWidget {
  final Animation<Offset> position;
  final Function callBack;
  final Widget widget;


  const BoxSwapWidget(
      { Key? key, required this.position, required this.callBack, required this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: position,
      child: GestureDetector(
          //onTap: () => callBack(),
          child:
          widget
      ),);
  }}