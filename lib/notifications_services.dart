import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tourify/adventure_categories.dart';

class NotificationServices{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true, // notifications can be display on user device
      announcement: true, // allow to read your notification to read by siri
      badge: true, // indicators on app icon
      carPlay: true, //
      criticalAlert: true,
      sound: true, // sounds for notification
      provisional: true, // ask for notification when you deny at fore-ground
    );

    //To check if user allow notification on a device
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('User allow permission');
    }
    else if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('User allow provisional permission');
    }
    else{
      AppSettings.openAppSettings();
      print('User Deny permission');
    }
  }

  void initLocalNotifications(BuildContext context,RemoteMessage message) async {
    var androidInitialization = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
        android: androidInitialization
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: (payload){
      handleMessage(message, context);
    });
  }

  void firebaseInit(BuildContext context){
    FirebaseMessaging.onMessage.listen((message) {
      if(kDebugMode){
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }
      initLocalNotifications(context,message);
      showNotification(message);
    });
  }

  Future<void> showNotification(RemoteMessage message)async{

    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(),
        'High Importance Notification',
    importance: Importance.max);
    AndroidNotificationDetails  androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
        channelDescription: 'Your channel description',
    importance: Importance.high,
    priority: Priority.high,
    ticker: 'ticker');
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    Future.delayed(Duration.zero, (){
      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  Future<void> setupInteractMessages(BuildContext context) async{
    //When app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage!= null){
      handleMessage(initialMessage, context);
    }

    // When app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(event, context);
    });
  }

  void handleMessage(RemoteMessage message, BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> AdventureCategory()));
  }
}