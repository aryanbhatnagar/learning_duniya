import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_duniya/screen2.dart';
import 'package:pie_chart/pie_chart.dart';

import 'dart:convert';

import 'globals.dart';
var idclass="";
Analytics1 analytics1FromJson(String str) => Analytics1.fromJson(json.decode(str));
String analytics1ToJson(Analytics1 data) => json.encode(data.toJson());

class Analytics1 {
  Analytics1({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  int status;

  factory Analytics1.fromJson(Map<String, dynamic> json) => Analytics1(
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
    required this.subjects,
  });

  Overview overview;
  List<Subject> subjects;

  factory Res.fromJson(Map<String, dynamic> json) => Res(
    overview: Overview.fromJson(json["overview"]),
    subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "overview": overview.toJson(),
    "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
  };
}
class Overview {
  Overview({
    required this.ansVeryFast,
    required this.ansDonotThink,
    required this.totalTest,
    required this.totalQuestion,
    required this.correct,
    required this.wrong,
  });

  var ansVeryFast;
  var ansDonotThink;
  var totalTest;
  var totalQuestion;
  var correct;
  var wrong;

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    ansVeryFast: json["ans_very_fast"],
    ansDonotThink: json["ans_donot_think"],
    totalTest: json["total_test"],
    totalQuestion: json["total_question"],
    correct: json["correct"],
    wrong: json["wrong"],
  );

  Map<String, dynamic> toJson() => {
    "ans_very_fast": ansVeryFast,
    "ans_donot_think": ansDonotThink,
    "total_test": totalTest,
    "total_question": totalQuestion,
    "correct": correct,
    "wrong": wrong,
  };
}
class Subject {
  Subject({
    required this.subjectId,
    required this.subjectName,
    required this.correctAnswer,
    required this.wrongAnswer,
  });

  var subjectId;
  var subjectName;
  dynamic correctAnswer;
  dynamic wrongAnswer;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    subjectId: json["subject_id"],
    subjectName: json["subject_name"],
    correctAnswer: json["correct_answer"],
    wrongAnswer: json["wrong_answer"],
  );

  Map<String, dynamic> toJson() => {
    "subject_id": subjectId,
    "subject_name": subjectName,
    "correct_answer": correctAnswer,
    "wrong_answer": wrongAnswer,
  };
}



Future<Analytics1> createRes() async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/mentee/result_analytics/assessment";

  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String> {
        "Authorization": "Bearer $token",
      },
      body: {
        "class_id":idclass,
        "subject_id":"0",
        "chapter_id":"0",
        "question_type_id":"0"
      }
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    debugPrint(responseString);
    return analytics1FromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

List <Color> colorlist=<Color>[
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.purpleAccent,
  Colors.pink,
  Colors.teal,
  Colors.greenAccent,
  Colors.deepOrange,
  Colors.indigo,
  Colors.purple,

];
class screen1 extends StatefulWidget {
  const screen1({Key? key}) : super(key: key);

  @override
  State<screen1> createState() => _screen1State();
}

class _screen1State extends State<screen1> {

  @override
  Widget build(BuildContext context) {
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
      body : FutureBuilder(
        future: createRes(),
        builder: (context,AsyncSnapshot<Analytics1> snapshot){

          if(snapshot.hasData){
            var s=snapshot.data!.data.res.subjects;
            Map<String, double> datamap = {
            };
            for(var i=0;i<snapshot.data!.data.res.subjects.length;i++)
              datamap["${s[i].subjectName}"]=(s[i].correctAnswer/(s[i].correctAnswer+int.parse(s[i].wrongAnswer)))*100;
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Overview', style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        ), Text('Knowing your Weakness', style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                        ),Icon(Icons.book, color: Colors.blue,)
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        width: columnWidth,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.indigo
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(Icons.star, color: Colors.blue,size: 20,),
                                      CircularProgressIndicator(
                                        backgroundColor: Color.fromRGBO(203, 203, 203, 100),
                                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                                        value: snapshot.data!.data.res.overview.ansVeryFast/100,
                                        strokeWidth: 3,
                                      ),
                                    ],
                                  )
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${snapshot.data!.data.res.overview.ansVeryFast.toStringAsPrecision(4)} %", style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    Text(
                                      'Answered without readying, very fast',
                                      style: TextStyle(
                                          fontSize: 12
                                      ),
                                    ),
                                  ],
                                ),),
                              SizedBox(width: 10,),
                              Expanded(
                                  flex: 1,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Icon(Icons.star, color: Colors.greenAccent,size: 20,),
                                      CircularProgressIndicator(
                                        backgroundColor: Color.fromRGBO(203, 203, 203, 100),
                                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                                        value: snapshot.data!.data.res.overview.ansDonotThink/100,
                                        strokeWidth: 3,
                                      ),
                                    ],
                                  )
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${snapshot.data!.data.res.overview.ansDonotThink.toStringAsPrecision(3)} %", style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    Text(
                                      'Answered very quick, did not think',
                                      style: TextStyle(
                                          fontSize: 12
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: columnWidth,
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
                          Text('If both the above percentage found. Print here solution for level 1 and level 2 from table analytic_result. If only one of the above found, print solution for level 1 if level 1 is found above or print solution for level 2, if level 2 found above', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),),
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
                        children: [
                          PieChart(
                            dataMap: datamap,
                            chartType: ChartType.disc,
                            chartRadius: 150,
                            legendOptions: LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.right,
                              legendTextStyle: TextStyle(fontFamily: "Candara",fontSize: 12),
                            ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValues: true,
                              showChartValuesOutside: true,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              GridView.count(
                                shrinkWrap: true,
                                primary: false,
                                padding: const EdgeInsets.all(10),
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                crossAxisCount: 2,
                                children: <Widget>[
                                  for(var i=0;i<snapshot.data!.data.res.subjects.length;i++)
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context, MaterialPageRoute(builder: (context) => screen2(snapshot.data!.data.res.subjects[i].subjectId.toString())));
                                      },
                                      child: Container(
                                        //width: columnWidth/2 - 50,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(Icons.book, color: colorlist[i],),
                                            SizedBox(width: 5,),
                                            Text("${snapshot.data!.data.res.subjects[i].subjectName}"),
                                            SizedBox(width: 5,),
                                            Text("${snapshot.data!.data.res.subjects[i].correctAnswer}/${snapshot.data!.data.res.subjects[i].wrongAnswer}", style: TextStyle(fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ),
                                    ),

                                ],
                              ),

                            ],
                          ),
                          Text('Subject wise correct versus wrong answers. Click on subject to view details', textAlign: TextAlign.center, style: TextStyle(
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
                      //height: 110,
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
                                  Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),),
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


          }

          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },

      ),
    );
  }
}
