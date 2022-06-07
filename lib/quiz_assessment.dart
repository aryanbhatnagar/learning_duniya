import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:group_button/group_button.dart';
import 'package:learning_duniya/assessment.dart';
import 'package:learning_duniya/landing.dart';
import 'package:learning_duniya/trial.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'globals.dart';
import 'main.dart';

ConvJson convJsonFromJson(String str) => ConvJson.fromJson(json.decode(str));
String convJsonToJson(ConvJson data) => json.encode(data.toJson());
class ConvJson {
  ConvJson({
    required this.assessmentId,
    required this.startTime,
    required this.endTime,
    required this.ansSheet,
    required this.result,
    required this.status,
  });

  String assessmentId;
  String startTime;
  String endTime;
  List<dynamic> ansSheet;
  Result result;
  String status;

  factory ConvJson.fromJson(Map<String, dynamic> json) => ConvJson(
    assessmentId: json["assessment_id"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    ansSheet: List<AnsSheet>.from(json["ans_sheet"].map((x) => AnsSheet.fromJson(x))),
    result: Result.fromJson(json["result"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => <String,dynamic>{
    "assessment_id": assessmentId,
    "start_time": startTime,
    "end_time": endTime,
    "ans_sheet": List<dynamic>.from(ansSheet.map((x) => x.toJson())),
  "result": jsonEncode(this.result) ,
    "status": status,
  };
}
class AnsSheet {
  AnsSheet({
    required this.que,
    required this.ans,
    required this.correctAnswer,
    required this.result,
  });

  String que;
  String ans;
  int correctAnswer;
  bool result;

  factory AnsSheet.fromJson(Map<String, dynamic> json) => AnsSheet(
    que: json["que"],
    ans: json["ans"],
    correctAnswer: json["correctAnswer"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "que": que,
    "ans": ans,
    "correctAnswer": correctAnswer,
    "result": result,
  };
}
class Result {
  Result({
    required this.total,
    required this.correct,
    required this.wrong,
    required this.left,
  });

  int total;
  int correct;
  int wrong;
  int left;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    total: json["total"],
    correct: json["correct"],
    wrong: json["wrong"],
    left: json["left"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "correct": correct,
    "wrong": wrong,
    "left": left,
  };
}


SendData sendDataFromJson(String str) => SendData.fromJson(json.decode(str));
String sendDataToJson(SendData data) => json.encode(data.toJson());

Questions questionsFromJson(String str) => Questions.fromJson(json.decode(str));
String questionsToJson(Questions data) => json.encode(data.toJson());

var quizId = "";
var ASSid="";
var qtid="";
late List allQuestionData = [];
late List quizInputData = [];
late List assignQuizData = [];
late String ass_id, start_time, end_time, status;
late int total, correct = 0, wrong = 0, left = 0;
late String que_id, ans;
late String currentAns;
late int correctAnswer;
late bool result;
late int quesStartTime;
late int quesEndTime;
late int quesTimeDiff;

late List timeData = [];

Map <String,dynamic>allData = {};
var quizAns = {};
Map<String,dynamic> quesResult = {};

int j = 0;
int ComCode=0;
late SendData? _sendData;

Future<SendData> createData(String startTime,String endTime,List ansdata,Result result) async {
  //ConvJson con=new ConvJson(assessmentId: assId, startTime: startTime, endTime: endTime, ansSheet: ansdata, result: result, status: "successful");
  final String apiUrl = "${BASE}api/assessmet/ansheet";
  //debugPrint(allData.toString());

  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String> {
      "Authorization": "Bearer $token",
        'Content-Type' : 'application/json'
      },
      body:jsonEncode(allData)
  );

  if(response.statusCode == 200) {
    ComCode = 200;
    debugPrint("Communication Code" + ComCode.toString());
    final String responseString = response.body;
    debugPrint(responseString.toString());
    return sendDataFromJson(responseString);
  }
  if(response.statusCode == 401) {
    ComCode=401;
    print(ComCode);
    throw Exception("failed");
  }
  else{
    debugPrint(allData.toString());
    print(0);
    throw Exception("failed");
  }
}
class SendData {
  SendData({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  int status;

  factory SendData.fromJson(Map<String, dynamic> json) => SendData(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "status": status,
  };
}
class Data {
  Data({
    required this.assessmentId,
    required this.userId,
    required this.testToken,
    required this.startTime,
    required this.endTime,
    required this.ansSheet,
    required this.result,
    required this.sheetStatus,
  });

  String assessmentId;
  int userId;
  String testToken;
  String startTime;
  String endTime;
  List<AnsSheet> ansSheet;
  Result result;
  String sheetStatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    assessmentId: json["assessment_id"],
    userId: json["user_id"],
    testToken: json["test_token"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    ansSheet: List<AnsSheet>.from(json["ans_sheet"].map((x) => AnsSheet.fromJson(x))),
    result: Result.fromJson(json["result"]),
    sheetStatus: json["sheet_status"],
  );

  Map<String, dynamic> toJson() => {
    "assessment_id": assessmentId,
    "user_id": userId,
    "test_token": testToken,
    "start_time": startTime,
    "end_time": endTime,
    "ans_sheet": List<dynamic>.from(ansSheet.map((x) => x.toJson())),
    "result": result.toJson(),
    "sheet_status": sheetStatus,
  };
}


Future<Questions> createQuestions(String id,String assID,String qtypeId) async {
  final String apiUrl =
      "${BASE}api/question";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "assessment_id":assID,
    "chapter_id":id,
    "question_type_id":qtypeId,
  });

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
  Data2 data;
  String message;

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
    success: json["success"],
    data: Data2.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}
class Data2 {
  Data2({
    required this.assessment,
    required this.questions,
  });

  Assessment assessment;
  List<Question> questions;

  factory Data2.fromJson(Map<String, dynamic> json) => Data2(
    assessment: Assessment.fromJson(json["assessment"]),
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
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

  var id;
  var assessmentName;
  var subjectId;
  var subject;
  var classId;
  var assessmentClass;
  var bookId;
  var book;
  var chapterId;
  var chapter;

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

  var id;
  var assessChapterId;
  var assessmentId;
  var que;
  var mediaType;
  var media;
  var opt1;
  var opt2;
  var opt3;
  var opt4;
  dynamic opt5;
  var ans;
  var tags;
  var status;
  var school;
  var createdBy;
  var updatedBy;
  var createdAt;
  var updatedAt;

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
    createdAt:json["created_at"],
    updatedAt: json["updated_at"],
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
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}



class quiz_assessment extends StatelessWidget {
  //const quiz({Key? key}) : super(key: key);
  late int id;
  late int asid;
  late int qt_id;
  quiz_assessment(this.id,this.asid,this.qt_id);


  @override
  Widget build(BuildContext context) {
    quizId = id.toString();
    ASSid=asid.toString();
    qtid=qt_id.toString();
    print(quizId);
    return MaterialApp(
      home: quizpage(id),
    );
  }
}

class quizpage extends StatefulWidget {
  //const quizpage({Key? key}) : super(key: key);
  int quiz_id;
  quizpage(this.quiz_id);

  @override
  _quizpageState createState() => _quizpageState(quiz_id);
}

class _quizpageState extends State<quizpage> with TickerProviderStateMixin {

  int qnum = 0;
  int score = 0;
  int quiz_Id;

  _quizpageState(this.quiz_Id);

  bool buttonState = true;
  bool quesState = false;
  bool prevVis = false;
  bool nextVis = true;
  bool submitVis = false;

  var answers = [];

  /*
  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${controller.duration!.inHours}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${count.inHours}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }*/

  double progress = 1.0;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    final controllerr = GroupButtonController();

    List<Widget> vid_pho = <Widget>[

    ];

    return Scaffold(
      /*appBar: AppBar(
          title: Text('Quiz'),
          centerTitle: true,
        ),*/
        body: FutureBuilder(
          future: createQuestions(quizId,ASSid,qtid),
          builder: (context, AsyncSnapshot<Questions> snapshot) {
            int noq=0;
            late VideoPlayerController _controller;
            if (snapshot.hasData) {
              print(quizId);
              Questions? que = snapshot.data;
              debugPrint(snapshot.data.toString());

              noq = que!.data.questions.length;
              debugPrint(noq.toString() + ' Number of questions');

              if(timeData.isEmpty)
                for(int i = 0; i < noq; i++) {
                  timeData.add(0);
                }

              debugPrint(timeData.toString());

              if(noq>0){
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
                          Text("${que.data.assessment.assessmentName.toString()}",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: "Candara",
                                  color: Colors.white)),
                          Text("${que.data.assessment.subject.toString()}",
                              style: TextStyle(
                                  fontSize: 18,
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
                                    /*
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
                                  ),*/
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
                                                  start_time = DateTime.now().toString();
                                                  ass_id = que.data.assessment.id.toString();
                                                  total = noq;

                                                  quesStartTime = DateTime.now().second + (DateTime.now().minute * 60);

                                                  //debugPrint(DateTime.now().toString());
                                                  debugPrint(quesStartTime.toString());

                                                  /*controller.reverse(
                                                    from: controller.value == 0
                                                        ? 1.0
                                                        : controller.value);*/
                                                  setState(() {
                                                    //isPlaying = true;
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
                                  //width: size.width - 80,
                                  //height: size.width - 225,
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if(snapshot.data!.data.questions[j].mediaType=="Image")
                                          return Container(
                                            height: 150,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(image:NetworkImage("${snapshot.data!.data.questions[j].media.toString()}"), fit: BoxFit.fill),
                                            ),
                                          );
                                          if(snapshot.data!.data.questions[j].mediaType=="video")
                                            {
                                          _controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',);
                                          _controller.play();
                                          _controller.setLooping(true);
                                          return Container(
                                            height: 150,
                                                width: 120,
                                                child: AspectRatio(
                                                    aspectRatio: _controller.value.aspectRatio,
                                                    child: VideoPlayer(_controller)
                                                )
                                          );
                                            }

                                              else
                                            return Container();
                                        }
                                      ),
                                    ],
                                  ),
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

                                            que_id = que.data.questions[j].id.toString();
                                            ans = ('x').toString();
                                            currentAns = (i+1).toString();
                                            correctAnswer = que.data.questions[j].ans;
                                            if(i+1 == que.data.questions[j].ans){
                                              result = true;
                                              correct++;
                                            }else{
                                              result = false;
                                              wrong++;
                                            }
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
                                          unselectedBorderColor: Colors.grey,
                                          buttonWidth: size.width - 40,
                                          selectedColor: Colors.lightGreen,
                                          selectedShadow: const <BoxShadow>[
                                            BoxShadow(color: Colors.transparent)
                                          ],
                                          unselectedShadow: const <BoxShadow>[
                                            BoxShadow(color: Colors.transparent)
                                          ],
                                          borderRadius: BorderRadius.circular(10.0),
                                          textPadding: EdgeInsets.all(10),
                                          enableDeselect: true,
                                          isRadio: true,
                                        ),
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
                                                    setState(() {
                                                      if(j+1 == que.data.questions.length) {
                                                        submitVis = true;
                                                        nextVis = false;
                                                      }
                                                      else {
                                                        submitVis = false;
                                                        nextVis = true;
                                                      }

                                                      if(j == 0)
                                                        prevVis = false;
                                                      else
                                                        prevVis = true;

                                                    });
                                                  },
                                                  child: Visibility(
                                                    visible: prevVis,
                                                    child: Container(
                                                      decoration: BoxDecoration(color:Colors.lightGreen,borderRadius: BorderRadius.circular(10)),
                                                      padding: EdgeInsets.all(8),
                                                      child: Text("<< PREV",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: "Candara",
                                                              color: Colors.white)),
                                                    ),
                                                  )),
                                              GestureDetector(
                                                  onTap: () {
                                                    if (j !=
                                                        que.data.questions.length - 1){
                                                      j += 1;

                                                      debugPrint((j).toString());

                                                      /*
                                                    quizInputData.add(que_id);
                                                    quizInputData.add(currentAns);
                                                    quizInputData.add(correctAnswer);
                                                    quizInputData.add(result);
                                                    */


                                                      quesTimeDiff = timeData[j-1];

                                                      quesEndTime = DateTime.now().second + (DateTime.now().minute * 60);
                                                      debugPrint(quesEndTime.toString());
                                                      quesTimeDiff += (quesEndTime - quesStartTime);
                                                      timeData[j-1] = quesTimeDiff;
                                                      debugPrint('total time: ' + quesTimeDiff.toString());
                                                      quesStartTime = quesEndTime;

                                                      quizAns = {
                                                        "que" : que_id,
                                                        "ans" : currentAns,
                                                        "correctAnswer" : correctAnswer,
                                                        "result" : result,
                                                        "time" : quesTimeDiff
                                                      };

                                                      allQuestionData.add(quizAns);

                                                      debugPrint(quizInputData.toString());
                                                    }else {



                                                      debugPrint(
                                                          "Max Number of Questions");
                                                    }

                                                    //quizInputData.clear();

                                                    setState(() {
                                                      if(j == 0)
                                                        prevVis = false;
                                                      else
                                                        prevVis = true;

                                                      if(j+1 == que.data.questions.length) {
                                                        submitVis = true;
                                                        nextVis = false;
                                                      }
                                                      else {
                                                        submitVis = false;
                                                        nextVis = true;
                                                      }
                                                    });

                                                  },
                                                  child: Visibility(
                                                    visible: nextVis,
                                                    //que.data.questions.length == j+1 ? "SUBMIT >>" :
                                                    child: Container(
                                                      decoration: BoxDecoration(color:Colors.lightGreen,borderRadius: BorderRadius.circular(10)),
                                                      padding: EdgeInsets.all(8),
                                                      child: Text("NEXT >>",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: "Candara",
                                                              color: Colors.white)),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Visibility(
                                          visible: submitVis,
                                          child: FlatButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            padding: EdgeInsets.all(10),
                                            textColor: Colors.white,
                                            color: Colors.orange,
                                            child: Text(
                                              'Submit Quiz',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                            onPressed: () async {
                                              end_time = DateTime.now().toString();

                                              debugPrint((j).toString());

                                              quesTimeDiff = timeData[j];

                                              quesEndTime = DateTime.now().second + (DateTime.now().minute * 60);
                                              debugPrint(quesEndTime.toString());
                                              quesTimeDiff += (quesEndTime - quesStartTime);
                                              timeData[j] = quesTimeDiff;
                                              debugPrint('total time: ' + quesTimeDiff.toString());
                                              quesStartTime = quesEndTime;

                                              quizAns = {
                                                "que" : que_id,
                                                "ans" : currentAns,
                                                "correctAnswer" : correctAnswer,
                                                "result" : result,
                                                "time" : quesTimeDiff
                                              };
                                              allQuestionData.add(quizAns);
                                              assignData(quizInputData);
                                            },
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
              }
              else
                return Container(child: Center(child: Text("There are no questions in this test")));

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

  Future<void> assignData(List quizInputData) async {

    debugPrint(allQuestionData.toString());
    debugPrint("From: " + start_time + " To: " + end_time);
    quesResult = {
      "total" : total,
      "correct" : correct,
      "wrong" : wrong,
      "left" : total-(wrong+correct),
    };

    allData = {
      "assessment_id" : ass_id,
      "chapter_id":quizId,
      "start_time" : start_time,
      "end_time" : end_time,
      "ans_sheet":allQuestionData,
      "result":quesResult,
      "status":"successful"
    };



    debugPrint(allData.toString());
    Result R=new Result(total: quesResult["total"], correct: quesResult["correct"], wrong: quesResult["wrong"], left: quesResult["left"]);
    SendData sendData = await createData(start_time,end_time,allQuestionData,R);
    setState(() {
      _sendData = sendData;
    });

    if(ComCode == 200) {
      final Future<ConfirmActionQuiz?> action =
      await _asyncConfirmDialog(context);
      debugPrint("Confirm Action $action");
    } if(ComCode==401)
    {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Cant send request"),
          content: Text("Unauthenticated"),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK',style: TextStyle(color: Colors.teal))
            ),
          ],
        ),
      );
    }
  }
}

enum ConfirmActionQuiz {Accept}
Future<Future<ConfirmActionQuiz?>> _asyncConfirmDialog(
    BuildContext context) async {
  return showDialog<ConfirmActionQuiz>
    (context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title:
          Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
          image: DecorationImage(image:AssetImage('images/tick.png') ,fit: BoxFit.fill),
      ),
      ),
        content: Text('Test Submitted Successfully'),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Ok'),
            onPressed: () {
              correct=0;
              j=0;
              wrong=0;
              allQuestionData=[];
              timeData.clear();
              Navigator.of(context).pop(ConfirmActionQuiz.Accept);
              Navigator.pop(context);
              Navigator.push(context,MaterialPageRoute(builder: (context) => landing()),);
            },
          )
        ],
      );
    },
  );
}