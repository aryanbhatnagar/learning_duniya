import 'package:flutter/material.dart';
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


Login1? log1=null;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

