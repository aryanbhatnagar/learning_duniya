import 'package:flutter/material.dart';
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => screen1()));
            }, child: Text('Screen 1')),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => screen2()));
            }, child: Text('Screen 2')),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => screen3()));
            }, child: Text('Screen 3')),
          ],
        ),
      ),
    );
  }
}
