import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:group_button/group_button.dart';
import 'package:video_player/video_player.dart';

class quiz extends StatelessWidget {
  const quiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: quizpage(),
    );
  }
}



class quizpage extends StatefulWidget {
  const quizpage({Key? key}) : super(key: key);


  @override
  _quizpageState createState() => _quizpageState();
}

class _quizpageState extends State<quizpage> with TickerProviderStateMixin {

  int qnum = 0;

  int score = 0;

  List<String> question = [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.'
  ];

  late AnimationController controller;

  bool isPlaying = false;

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }
  double progress = 1.0;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 180),
    );

    controller.addListener(() {
      //notify();
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }







  @override
  Widget build(BuildContext context) {

    Size size =MediaQuery.of(context).size;
    final controllerr = GroupButtonController();

    List <Widget> vid_pho =<Widget>[
      Image(image: AssetImage("images/hindiass.jpg"),fit: BoxFit.fill),

    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: (size.height)/4,
            width: (size.width),
            decoration: BoxDecoration(
                color: Colors.lightGreen,
                //image: DecorationImage(image: AssetImage("images/"),fit: BoxFit.fill)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Assessment Name",style: TextStyle(fontSize: 35,fontFamily: "Candara",color: Colors.white)),
                Text("Specialization",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                SizedBox(height: 10),
                Text("QUES: 1 of 10",style: TextStyle(fontSize: 25,fontFamily: "Candara",color: Colors.orange[200]))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(20),
              height: (size.height)-(size.height)/5,
              width: (size.width),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(34)),
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [

                                  AnimatedBuilder(
                                    animation: controller,
                                    builder: (context, child) => Text(
                                      countText,
                                      style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10))),

                                      padding: EdgeInsets.all(10),
                                      textColor: Colors.white,
                                      color: Colors.orange,
                                      child: Text(
                                        'START QUIZ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      onPressed: () {
                                        controller.reverse(
                                            from: controller.value == 0 ? 1.0 : controller.value);
                                        setState(() {
                                          isPlaying = true;
                                        });
                                      },
                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      Container(
                        width: size.width-80,
                        height: size.width-225,
                        decoration: BoxDecoration(color: Colors.lightGreen,borderRadius: BorderRadius.circular(20)),
                        child: vid_pho[0],

                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text("Q."+
                            question[qnum],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      GroupButton(
                          controller: controllerr,
                          buttons: ['OPTION 1', 'OPTION 2', 'OPTION 3','OPTION 4'],
                          onSelected: (i, selected) => debugPrint('Button #$i $selected'),
                          selectedTextStyle: const TextStyle(
                              fontFamily: "Candara",
                              fontSize: 20,
                              color: Colors.white),
                          direction: Axis.vertical,
                          unselectedTextStyle: const TextStyle(
                              fontFamily: "Candara",
                              fontSize: 20,
                              color: Colors.black),
                          unselectedColor: Colors.transparent,
                          buttonWidth: size.width - 40,
                          selectedColor: Colors.lightGreen,
                          selectedShadow: const <BoxShadow>[BoxShadow(color: Colors.transparent)],
                          unselectedShadow: const <BoxShadow>[BoxShadow(color: Colors.transparent)],
                          borderRadius: BorderRadius.circular(10.0)
                      ),

                      SizedBox(height: 20),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(child: Text("<< PREV",style: TextStyle(fontSize: 25,fontFamily: "Candara",color: Colors.grey))),
                            GestureDetector(child: Text("NEXT >>",style: TextStyle(fontSize: 25,fontFamily: "Candara",color: Colors.grey))),
                          ],
                        )
                      )


                    ],
                  )
              ),

            ),
          )

        ],
      ),
    );
  }
}


