import 'package:flutter/material.dart';
//import 'package:learning_duniya/screen1%20(2).dart';
//import 'package:learning_duniya/screen2%20(1).dart';
import 'package:learning_duniya/challenge_page.dart';
import 'package:learning_duniya/screen4.dart';
import 'package:learning_duniya/screen5.dart';
import 'screen2.dart';
import 'screen1 (1).dart';
import 'screen3.dart';

class navigationScreenPage extends StatefulWidget {
  const navigationScreenPage({Key? key}) : super(key: key);

  @override
  State<navigationScreenPage> createState() => _navigationScreenPageState();
}

class _navigationScreenPageState extends State<navigationScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
             }, child: Text('Screen 1')),
            ElevatedButton(onPressed: () {
             // Navigator.push(context, MaterialPageRoute(builder: (context) => quiz_challenge()));
            }, child: Text('Screen 2')),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => challenge_page()));
            }, child: Text('Screen 3')),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => screen4()));
            }, child: Text('Screen 4')),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => screen5()));
            }, child: Text('Screen 5')),
          ],
        ),
      ),
    );
  }
}
