import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_duniya/screen3.dart';
import 'globals.dart';

var idclass="";
var subid="";
class screen2 extends StatefulWidget {
  //const screen2({Key? key}) : super(key: key);
  var subId;

  screen2(this.subId);

  @override
  State<screen2> createState() => _screen2State(subId);
}

Future<Analytics2> createRes1(String sub_id) async {
  final String apiUrl =
      "${BASE}api/mentee/result_analytics/assessment";

  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String> {
        "Authorization": "Bearer $token",
      },
      body: {
        "class_id":idclass,
        "subject_id":sub_id,
        "chapter_id":"0",
        "question_type_id":"0"
      }
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    debugPrint(responseString);
    return analytics2FromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

Analytics2 analytics2FromJson(String str) => Analytics2.fromJson(json.decode(str));
String analytics2ToJson(Analytics2 data) => json.encode(data.toJson());

class Analytics2 {
  Analytics2({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  var status;

  factory Analytics2.fromJson(Map<String, dynamic> json) => Analytics2(
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
    required this.res,
  });

  Res res;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    res: Res.fromJson(json["res"]),
  );

  Map<String, dynamic> toJson() => {
    "res": res.toJson(),
  };
}
class Res {
  Res({
    required this.overview,
    required this.chapters,
  });

  Overview overview;
  List<Chapter> chapters;

  factory Res.fromJson(Map<String, dynamic> json) => Res(
    overview: Overview.fromJson(json["overview"]),
    chapters: List<Chapter>.from(json["chapters"].map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overview": overview.toJson(),
    "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
  };
}
class Chapter {
  Chapter({
    required this.chapterId,
    required this.chapterName,
    required this.totalQuestion,
    required this.correctAnswer,
    required this.wrongAnser,
    required this.questionTypes,
  });

  var chapterId;
  var chapterName;
  var totalQuestion;
  var correctAnswer;
  var wrongAnser;
  List<QuestionType> questionTypes;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    chapterId: json["chapter_id"],
    chapterName: json["chapter_name"],
    totalQuestion: json["total_question"],
    correctAnswer: json["correct_answer"],
    wrongAnser: json["wrong_anser"],
    questionTypes: List<QuestionType>.from(json["question_types"].map((x) => QuestionType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chapter_id": chapterId,
    "chapter_name": chapterName,
    "total_question": totalQuestion,
    "correct_answer": correctAnswer,
    "wrong_anser": wrongAnser,
    "question_types": List<dynamic>.from(questionTypes.map((x) => x.toJson())),
  };
}
class QuestionType {
  QuestionType({
    required this.id,
    required this.catName,
    required this.totalQuestion,
    required this.wrongAnswer,
  });

  var id;
  var catName;
  var totalQuestion;
  var wrongAnswer;

  factory QuestionType.fromJson(Map<String, dynamic> json) => QuestionType(
    id: json["id"],
    catName: json["cat_name"],
    totalQuestion: json["total_question"],
    wrongAnswer: json["wrong_answer"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_name": catName,
    "total_question": totalQuestion,
    "wrong_answer": wrongAnswer,
  };
}
class Overview {
  Overview({
    required this.currentSuggestSolution,
    required this.totalTest,
    required this.totalQuestion,
    required this.correct,
    required this.wrong,
    required this.subjectName,
    required this.percentage,
  });

  var currentSuggestSolution;
  var totalTest;
  var totalQuestion;
 var correct;
  var wrong;
  var subjectName;
  var percentage;

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    currentSuggestSolution: json["current_suggest_solution"],
    totalTest: json["total_test"],
    totalQuestion: json["total_question"],
    correct: json["correct"],
    wrong: json["wrong"],
    subjectName: json["subject_name"],
    percentage: json["percentage"],
  );

  Map<String, dynamic> toJson() => {
    "current_suggest_solution": currentSuggestSolution,
    "total_test": totalTest,
    "total_question": totalQuestion,
    "correct": correct,
    "wrong": wrong,
    "subject_name": subjectName,
    "percentage": percentage,
  };
}


class _screen2State extends State<screen2> {
  var _subId;

  _screen2State(this._subId);

  @override
  Widget build(BuildContext context) {
    subid=_subId;
    double columnWidth = MediaQuery.of(context).size.width *0.9;
    if(classId=="LKG")
      idclass="1";
    else if(classId=="UKG")
      idclass="2";
    else
    {
      idclass=(2+int.parse(classId)).toString();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis Report'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: createRes1(subid),
          builder: (context,AsyncSnapshot<Analytics2> snapshot) {
            if(snapshot.hasData)
              return  SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Details', style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          ), Text('Knowing your Weakness', style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                          ),Icon(Icons.book, color: Colors.blue,)
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: columnWidth,
                        //height: 100,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.indigo
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Current Suggested Solution', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 10),),
                            SizedBox(
                              height: 10,
                            ),
                            Text("${snapshot.data!.data.res.overview.currentSuggestSolution}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subject Details', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 11),),
                            Text("${snapshot.data!.data.res.overview.subjectName}", style: TextStyle(fontWeight: FontWeight.bold),),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(Icons.star, color: Colors.blue,size: 20,),
                                    CircularProgressIndicator(
                                      backgroundColor: Color.fromRGBO(203, 203, 203, 100),
                                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                                      value: snapshot.data!.data.res.overview.percentage/100,
                                      strokeWidth: 3,
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Text("${snapshot.data!.data.res.overview.percentage.toStringAsPrecision(4)}%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: columnWidth,
                        //height: 200,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.indigo
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Performance By Chapter', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
                            for(var j=0;j<snapshot.data!.data.res.chapters.length;j++)
                              Container(
                              padding: EdgeInsets.all(5),
                              width: columnWidth-30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('Ques | Correct | Wrong', style: TextStyle(color: Colors.teal, fontSize: 11),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${snapshot.data!.data.res.chapters[j].chapterName}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),),
                                      Text("${snapshot.data!.data.res.chapters[j].totalQuestion} | ${snapshot.data!.data.res.chapters[j].correctAnswer} | ${snapshot.data!.data.res.chapters[j].wrongAnser}", style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  for(var k=0;k<snapshot.data!.data.res.chapters[j].questionTypes.length;k++)
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => screen3(subid,snapshot.data!.data.res.chapters[j].chapterId.toString(),snapshot.data!.data.res.chapters[j].questionTypes[k].id.toString())));
                                      },
                                      child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(snapshot.data!.data.res.chapters[j].questionTypes[k].catName),
                                          Text("Que ${snapshot.data!.data.res.chapters[j].questionTypes[k].totalQuestion} | Wrong ${snapshot.data!.data.res.chapters[j].questionTypes[k].wrongAnswer}")
                                        ],
                                      ),
                                  ),
                                    ),

                                  SizedBox(height: 20,),
                                  Text('Answered without readying, very fast', style: TextStyle(color: Colors.teal),),
                                ],
                              ),
                            ),



                            SizedBox(height: 20,),


                            Text('SUGGESTIONS', textAlign: TextAlign.center, style: TextStyle(
                                color: Colors.teal,
                                fontSize: 11,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: columnWidth,
                        height: 110,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.indigo
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("${snapshot.data!.data.res.overview.totalTest}", style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Total Questions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("${snapshot.data!.data.res.overview.totalQuestion}", style: TextStyle(fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Correct', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("${snapshot.data!.data.res.overview.correct}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Wrong', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("${snapshot.data!.data.res.overview.wrong}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text('All Subject assessment overflow', style: TextStyle(color: Colors.teal, fontSize: 11, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            else
              return Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
}
