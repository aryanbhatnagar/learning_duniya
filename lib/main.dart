import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:learning_duniya/IntroScreen.dart';
import 'package:learning_duniya/Login.dart';
import 'package:learning_duniya/SignUp.dart';
import 'package:learning_duniya/courseDesc.dart';
import 'package:learning_duniya/courses.dart';
import 'package:learning_duniya/landing.dart';
import 'package:learning_duniya/mentor.dart';
import 'package:learning_duniya/need_help_page.dart';
import 'package:learning_duniya/quiz.dart';
import 'package:learning_duniya/seeall.dart';
import 'package:learning_duniya/test.dart';
import 'Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
  print('A bg message just showed up :  ${message.messageId}');
}

Login1? log1=null;

Future <void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp1()
    );
  }
}

class MyApp1 extends StatefulWidget {
  const MyApp1({Key? key}) : super(key: key);

  @override
  _MyApp1State createState() => _MyApp1State();
}

class _MyApp1State extends State<MyApp1> {

  int _counter = 0;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken() async {
    final token = await _firebaseMessaging.getToken();
    print("dlllllllllllllllll $token");
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        theme: ThemeData(
          primaryColor: Colors.teal,
        ),
        home: IntroScreen(),
        routes: <String,WidgetBuilder>{
          "slider":(BuildContext context)=>IntroScreen(),
          "Login" : (BuildContext context)=>Login(),
          "SignUp": (BuildContext context)=>SignUp(),
          "Landing": (BuildContext context)=>landing(),

        }
    );
  }
}


