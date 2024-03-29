import 'dart:convert';
import 'dart:developer';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/views/signup_view/signup_view.dart';

enum NotificationState {
  foreground,
  background,
  terminated
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  log('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

requestPerm() async {
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestNotificationsPermission();
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'multiplayer', // id
    'multiplayer', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
  //Initialize Notification settings
  var initializationSettings = const InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'), 
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:(NotificationResponse details) async {
      String? payload = details.payload;
      if (payload != null && payload.isNotEmpty) {
        // routeFromNotification(NotificationState.foreground, )
        Map<String, dynamic> data = jsonDecode(payload);
        String? newsUrl = data["URL"];
        if (newsUrl != null) {
          Get.to(() => const SignUpView(), transition: Transition.rightToLeft);
        }
      }
    },
  );
}

void showForegroundNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_notification',
        ),
      ),
      payload: jsonEncode(message.data)
    );
  }
}

//Detect and Get Push Notification
getPushedNotification(context){
  //On App Terminated
  FirebaseMessaging.instance.getInitialMessage().then((message){
    if(message != null ){
      //Route on App Terminated
      routeFromNotification(NotificationState.terminated, message);
    }
  });

  //On Foreground Message
  FirebaseMessaging.onMessage.listen((message) {
    debugPrint(message.data["payload"].toString());
    showForegroundNotification(message);
  });

  //On Backgorund Message
  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    routeFromNotification(NotificationState.background, message);
  });
}

routeFromNotification(NotificationState type, RemoteMessage message){
  if(message.data.isNotEmpty){
    String? newsUrl = message.data["URL"];
    if (newsUrl != null) {
      Timer(Duration(seconds: type == NotificationState.terminated ? 4 : 0), () async {
        Get.to(() => const SignUpView(), transition: Transition.rightToLeft);
      });
    }
  }
}

String extractLastPathSegment(String url) {
  // Parse the URL using Uri class
  final uri = Uri.parse(url);
  
  // Return the last segment of the path
  return uri.pathSegments.last;
}
