import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
class FirebaseApi {
  final firebasemessaging = FirebaseMessaging.instance;
  final navigatorkey =  GlobalKey<NavigatorState>();
  Future<void> hanleBackgroundMesage(RemoteMessage message) async {
    print(message.notification!.title);
    print(message.notification!.body);
  }

  void handleMessage(RemoteMessage? message)
  {
    //Navigator.of(context).
    if(message==null) return;
   navigatorkey.currentState?.pushNamed("/notification",arguments: message);

  }
  Future initPushNotification()async
  {
await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions
  (alert: true,
badge: true,sound: true
);
FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
FirebaseMessaging.onBackgroundMessage(hanleBackgroundMesage);
  }
Future<void> initNotifications()async
{
  firebasemessaging.requestPermission();
 final tocken=await firebasemessaging.getToken();
 print("Token${tocken}");
 // FirebaseMessaging.onBackgroundMessage(hanleBackgroundMesage );
  //initNotifications();
}
}