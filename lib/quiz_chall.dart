import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:learning_duniya/landing.dart';
import 'package:video_player/video_player.dart';

import 'globals.dart';

var opponent_name;
var opponent_img;
var chapID;
var qtId;
var challID;
var opposchool;


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
var qtype="";
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
  final String apiUrl = "${BASE}api/challenge/ansheet";
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
    required this.chapterId,

  });

  String chapterId;


  factory Data.fromJson(Map<String, dynamic> json) => Data(
    chapterId: json["chapter_id"],

  );

  Map<String, dynamic> toJson() => {
    "chapter_id": chapterId,
  };
}


Future<Questions> createQuestions(String id,String qt_id) async {
  final String apiUrl =
      "${BASE}api/chapter/questions";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "chapter_id":id,
    "question_type_id":qt_id,
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

    required this.questions,
  });


  List<Question> questions;

  factory Data2.fromJson(Map<String, dynamic> json) => Data2(
    questions: List<Question>.from(
        json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
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
  var media;
  var opt1;
  var opt2;
  var opt3;
  var opt4;
  dynamic opt5;
  int ans;
  String tags;
  String status;
  int school;
  int createdBy;
  int updatedBy;
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
    createdAt: json["created_at"],
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
    "updated_at": updatedAt
  };
}

class quiz_challenge extends StatefulWidget {

  var chapid;
  var qtid;
  var challid;
  var o_name;
  var o_photo;
  var o_school;

  quiz_challenge(this.chapid, this.qtid, this.challid,this.o_name,this.o_photo);
 //const quiz_challenge({Key? key}) : super(key: key);

  @override
  State<quiz_challenge> createState() => _quiz_challengeState(chapid,qtid,challid,o_name,o_photo);
}

class _quiz_challengeState extends State<quiz_challenge> {

  var chapid;
  var qtid;
  var challid;
  var o_name;
  var o_photo;
  var o_school;
  _quiz_challengeState(this.chapid, this.qtid, this.challid,this.o_name,this.o_photo);

  int qnum = 0;
  int score = 0;
  //int quiz_Id;


  bool buttonState = true;
  bool quesState = false;
  bool prevVis = false;
  bool nextVis = true;
  bool submitVis = true;

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
    chapID=chapid;
    qtId=qtid;
    challID=challid;
    opponent_name=o_name;
    opponent_img=o_photo;
    Size size = MediaQuery.of(context).size;
    final controllerr = GroupButtonController();
    bool back=true;

    List<Widget> vid_pho = <Widget>[
      Container(
        height: 150,
        width: 120,
        decoration: BoxDecoration(
          image: DecorationImage(image:AssetImage("images/hindiass.jpg"), fit: BoxFit.fill),
        ),
      ),
    ];

    return WillPopScope(
      onWillPop: () async => back,
      child: Scaffold(
        /*appBar: AppBar(
            title: Text('Quiz'),
            centerTitle: true,
          ),*/
          body: FutureBuilder(
            future: createQuestions(chapID,qtId),
            builder: (context, AsyncSnapshot<Questions> snapshot) {
              int noq=0;
              if (snapshot.hasData) {
                print(chapID);
                Questions? que = snapshot.data;
                debugPrint(snapshot.data.toString());
                late VideoPlayerController _controller;
                noq = que!.data.questions.length;
                debugPrint(noq.toString() + ' Number of questions');

                if(timeData.isEmpty)
                  for(int i = 0; i < noq; i++) {
                    timeData.add(0);
                  }

                debugPrint(timeData.toString());

                if(noq>0){
                  return SingleChildScrollView(
                      child:Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              height: 65,
                              color: Colors.teal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage("${userImg}"),
                                          backgroundColor: Colors.amber,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "$userName",
                                              style: TextStyle(
                                                fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "$schools",
                                              style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  /*Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Icon(
                                          Icons.watch_later_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          '08',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),*/
                                  Container(
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              opponent_name,
                                              style: TextStyle(
                                                fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "",
                                              style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(opponent_img),
                                          backgroundColor: Colors.lightGreen,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            SizedBox(
                              //width: 125,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(Colors.blue)),
                                onPressed: () {
                                  start_time = DateTime.now().toString();
                                  //ass_id = que.data.assessment.id.toString();
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
                                    back=!back;
                                    buttonState = !buttonState;
                                    quesState = !quesState;
                                  });

                                },
                                child: buttonState
                                    ? Text(
                                  'START QUIZ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                )
                                    : Text(
                                  'STOP QUIZ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: quesState,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(20),
                                            padding: EdgeInsets.all(30),
                                            height: 200,
                                            color: Color.fromRGBO(255, 210, 73, 1),
                                            child: Center(
                                              child: Text(
                                                que.data.questions[j].que,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromRGBO(48, 48, 48, 1),
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top: 5,
                                              right: MediaQuery.of(context).size.width / 2 - 60,
                                              child: Container(
                                                width: 70,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(10)),
                                                child: Center(
                                                  child: Text(
                                                    "${j+1}/${noq}",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.teal),
                                                  ),
                                                ),
                                              )),
                                          Positioned(
                                              bottom: 5,
                                              right: MediaQuery.of(context).size.width / 2 - 40,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20)),
                                                child: Icon(
                                                  Icons.question_mark,
                                                  color: Colors.teal,
                                                ),
                                              ))
                                        ],
                                      ),

                                      /*Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width - 130,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.teal),
                                              borderRadius: BorderRadius.circular(5)),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    Colors.teal)),
                                            onPressed: () {},
                                            child: Text(
                                              'Sculptor',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold, fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width - 130,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.teal),
                                              borderRadius: BorderRadius.circular(5)),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    Colors.white)),
                                            onPressed: () {},
                                            child: Text(
                                              'Potter',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.teal),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width - 130,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.red),
                                              borderRadius: BorderRadius.circular(5)),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    Colors.red)),
                                            onPressed: () {},
                                            child: Text(
                                              'Weaver',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        height: 50,
                                        width: MediaQuery.of(context).size.width - 130,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.teal),
                                              borderRadius: BorderRadius.circular(5)),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    Colors.white)),
                                            onPressed: () {},
                                            child: Text(
                                              'Painter',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.teal),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),*/
                                      SizedBox(
                                        height: 20,
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
                                            fontSize: 16,
                                            color: Colors.white),
                                        direction: Axis.vertical,
                                        unselectedTextStyle: const TextStyle(
                                            fontFamily: "Candara",
                                            fontSize: 16,
                                            color: Colors.black),
                                        unselectedColor: Colors.transparent,
                                        unselectedBorderColor: Colors.grey,
                                        textAlign: TextAlign.center,
                                        buttonWidth: size.width - 90,
                                        selectedColor: Colors.teal,
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
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Visibility(
                                            visible: prevVis,
                                            child: SizedBox(
                                              width: 100,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all<Color>(
                                                        Colors.teal)),
                                                onPressed: () {

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
                                                child: Text('PREV'),
                                              ),
                                            ),
                                          ),
                                          if(j!=snapshot.data!.data.questions.length-1)
                                            Visibility(
                                              visible: nextVis,
                                              child: SizedBox(
                                                width: 100,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(
                                                          Colors.teal)),
                                                  onPressed: () {
                                                    if (j != que.data.questions.length - 1){
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
                                                  child: Text('NEXT'),
                                                ),
                                              ),
                                            ),
                                          if(j==snapshot.data!.data.questions.length-1)
                                            Visibility(
                                              visible: submitVis,
                                              child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(5))),
                                                padding: EdgeInsets.all(10),
                                                textColor: Colors.white,
                                                color: Colors.orange,
                                                child: Text(
                                                  'Submit',
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
                                        ],
                                      ),
                                      SizedBox(height: 20,),


                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
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
          )),
    );
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
      "chapter_id" : chapID,
      "challenge_id":challID.toString(),
      "question_type_id": qtId,
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
        Image.asset(
          'images/tick.png',
          height: 50,
          width: 50,
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
