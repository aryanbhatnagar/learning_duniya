// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:group_button/group_button.dart';
import 'package:video_player/video_player.dart';

import 'dart:convert';

Questions questionsFromJson(String str) => Questions.fromJson(json.decode(str));

String questionsToJson(Questions data) => json.encode(data.toJson());

var quizId = "1";

Future<Questions> createQuestions(String id) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/question";

  final response = await http.post(Uri.parse(apiUrl), body: {"id": id});

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return questionsFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

class Questions {
  Questions({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    required this.assessment,
    required this.questions,
  });

  Assessment assessment;
  List<Question> questions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    assessment: Assessment.fromJson(json["assessment"]),
    questions: List<Question>.from(
        json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "assessment": assessment.toJson(),
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}

class Assessment {
  Assessment({
    required this.id,
    required this.assessmentName,
    required this.subjectId,
    required this.subject,
    required this.classId,
    required this.assessmentClass,
    required this.bookId,
    required this.book,
    required this.chapterId,
    required this.chapter,
  });

  int id;
  String assessmentName;
  int subjectId;
  String subject;
  int classId;
  String assessmentClass;
  int bookId;
  String book;
  int chapterId;
  String chapter;

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
    id: json["id"],
    assessmentName: json["assessment_name"],
    subjectId: json["subject_id"],
    subject: json["subject"],
    classId: json["class_id"],
    assessmentClass: json["class"],
    bookId: json["book_id"],
    book: json["book"],
    chapterId: json["chapter_id"],
    chapter: json["chapter"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "assessment_name": assessmentName,
    "subject_id": subjectId,
    "subject": subject,
    "class_id": classId,
    "class": assessmentClass,
    "book_id": bookId,
    "book": book,
    "chapter_id": chapterId,
    "chapter": chapter,
  };
}

class Question {
  Question({
    required this.id,
    required this.assessChapterId,
    required this.assessmentId,
    required this.que,
    required this.mediaType,
    required this.media,
    required this.opt1,
    required this.opt2,
    required this.opt3,
    required this.opt4,
    required this.opt5,
    required this.ans,
    required this.tags,
    required this.status,
    required this.school,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int assessChapterId;
  int assessmentId;
  String que;
  String mediaType;
  String media;
  String opt1;
  String opt2;
  String opt3;
  String opt4;
  dynamic opt5;
  int ans;
  String tags;
  String status;
  int school;
  int createdBy;
  int updatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    assessChapterId: json["assess_chapter_id"],
    assessmentId: json["assessment_id"],
    que: json["que"],
    mediaType: json["media_type"],
    media: json["media"],
    opt1: json["opt_1"],
    opt2: json["opt_2"],
    opt3: json["opt_3"],
    opt4: json["opt_4"],
    opt5: json["opt_5"],
    ans: json["ans"],
    tags: json["tags"],
    status: json["status"],
    school: json["school"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "assess_chapter_id": assessChapterId,
    "assessment_id": assessmentId,
    "que": que,
    "media_type": mediaType,
    "media": media,
    "opt_1": opt1,
    "opt_2": opt2,
    "opt_3": opt3,
    "opt_4": opt4,
    "opt_5": opt5,
    "ans": ans,
    "tags": tags,
    "status": status,
    "school": school,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class quiz extends StatelessWidget {
  //const quiz({Key? key}) : super(key: key);
  late int id;
  quiz(this.id);

  @override
  Widget build(BuildContext context) {
    quizId = id.toString();
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
  bool buttonState = true;
  bool quesState = false;

  var answers = [''];
  int j = 0;

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
    Size size = MediaQuery.of(context).size;
    final controllerr = GroupButtonController();

    List<Widget> vid_pho = <Widget>[
      Image(image: AssetImage("images/hindiass.jpg"), fit: BoxFit.fill),
    ];

    return Scaffold(
      /*appBar: AppBar(
          title: Text('Quiz'),
          centerTitle: true,
        ),*/
        body: FutureBuilder(
          future: createQuestions(quizId),
          builder: (context, AsyncSnapshot<Questions> snapshot) {
            if (snapshot.hasData) {
              Questions? que = snapshot.data;
              print(snapshot.data);

              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    //height: (size.height) / 4,
                    width: (size.width),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      //image: DecorationImage(image: AssetImage("images/"),fit: BoxFit.fill)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(que!.data.assessment.assessmentName,
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: "Candara",
                                color: Colors.white)),
                        Text(que.data.assessment.chapter,
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Candara",
                                color: Colors.black)),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: (size.height) - (size.height) / 5,
                      width: (size.width),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(34)),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: FlatButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10))),
                                              padding: EdgeInsets.all(10),
                                              textColor: Colors.white,
                                              color: Colors.orange,
                                              child: buttonState
                                                  ? Text(
                                                'START QUIZ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                ),
                                              )
                                                  : Text(
                                                'STOP QUIZ',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                              onPressed: () {
                                                controller.reverse(
                                                    from: controller.value == 0
                                                        ? 1.0
                                                        : controller.value);
                                                setState(() {
                                                  isPlaying = true;
                                                  buttonState = !buttonState;
                                                  quesState = !quesState;
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
                                width: size.width - 80,
                                height: size.width - 225,
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen,
                                    borderRadius: BorderRadius.circular(20)),
                                child: vid_pho[0],
                              ),
                              SizedBox(height: 20),
                              Visibility(
                                  maintainState: true,
                                  visible: quesState,
                                  child: Container(
                                    child: Column(children: [
                                      Text(
                                          "QUES: " + (j+1).toString() + " of " +
                                              que.data.questions.length.toString(),
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontFamily: "Candara",
                                              color: Colors.orange[200])),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            "Q." + que.data.questions[j].que,
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
                                          buttons: [
                                            que.data.questions[j].opt1.toString(),
                                            que.data.questions[j].opt2.toString(),
                                            que.data.questions[j].opt3.toString(),
                                            que.data.questions[j].opt4.toString()
                                          ],
                                          onSelected: (i, selected) {
                                            debugPrint('Button #$i $selected');
                                            answers.add(i.toString());
                                            debugPrint(answers.toString());
                                          },
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
                                          selectedShadow: const <BoxShadow>[
                                            BoxShadow(color: Colors.transparent)
                                          ],
                                          unselectedShadow: const <BoxShadow>[
                                            BoxShadow(color: Colors.transparent)
                                          ],
                                          borderRadius: BorderRadius.circular(10.0)),
                                      SizedBox(height: 20),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            GestureDetector(
                                                onTap: () {
                                                  if (j != 0)
                                                    j -= 1;
                                                  else
                                                    debugPrint("No Previous Question");
                                                },
                                                child: Text("<< PREV",
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontFamily: "Candara",
                                                        color: Colors.grey))),
                                            GestureDetector(
                                                onTap: () {
                                                  if (j !=
                                                      que.data.questions.length - 1)
                                                    j += 1;
                                                  else {
                                                    debugPrint(
                                                        "Max Number of Questions");
                                                  }
                                                },
                                                child: Text("NEXT >>",
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontFamily: "Candara",
                                                        color: Colors.grey))),
                                          ],
                                        ),
                                      )
                                    ]),
                                  )),
                              SizedBox(height: 20),
                            ],
                          )),
                    ),
                  )
                ],
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }
}