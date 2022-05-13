import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'globals.dart';
import 'dart:convert';

Analytics3 analytics3FromJson(String str) => Analytics3.fromJson(json.decode(str));
String analytics3ToJson(Analytics3 data) => json.encode(data.toJson());
var qcount=0;
var idclass="";
var subid="";
var chapid="";
var qtid="";
class Analytics3 {
  Analytics3({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  var message;
  var status;

  factory Analytics3.fromJson(Map<String, dynamic> json) => Analytics3(
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
    required this.id,
    required this.catName,
    required this.questions,
  });

  var id;
  var catName;
  List<Question> questions;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    id: json["id"],
    catName: json["cat_name"],
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cat_name": catName,
    "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
  };
}
class Question {
  Question({
    required this.que,
  });

  String que;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    que: json["que"],
  );

  Map<String, dynamic> toJson() => {
    "que": que,
  };
}
class Overview {
  Overview({
    required this.answerWithoutReading,
    required this.answerVeryQuick,
  });

  var answerWithoutReading;
  var answerVeryQuick;

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    answerWithoutReading: json["answer_without_reading"],
    answerVeryQuick: json["answer_very_quick"],
  );

  Map<String, dynamic> toJson() => {
    "answer_without_reading": answerWithoutReading,
    "answer_very_quick": answerVeryQuick,
  };
}

Future<Analytics3> createRes3(String sub_id,String chap_id,String qt_id) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/mentee/result_analytics/assessment";

  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String> {
        "Authorization": "Bearer $token",
      },
      body: {
        "class_id":idclass,
        "subject_id":sub_id,
        "chapter_id":chap_id,
        "question_type_id":qt_id
      }
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    debugPrint(responseString);
    return analytics3FromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

class screen3 extends StatefulWidget {
  //const screen3({Key? key}) : super(key: key);

  var subId;
  var chapId;
  var qtId;


  screen3(this.subId, this.chapId, this.qtId);

  @override
  State<screen3> createState() => _screen3State(subId,chapId,qtId);
}

class _screen3State extends State<screen3> {
  var subId;
  var chapId;
  var qtId;
  _screen3State(this.subId, this.chapId, this.qtId);

  @override
  Widget build(BuildContext context) {
    subid=subId;
    chapid=chapId;
    qtid=qtId;
    double columnWidth = MediaQuery.of(context).size.width *0.8;
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
          future: createRes3(subid,chapid,qtid),
          builder: (context,AsyncSnapshot<Analytics3> snapshot){
            if (snapshot.hasData)
            return Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: columnWidth,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.indigo
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                      value: snapshot.data!.data.res.overview.answerWithoutReading/100,
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
                                  Text("${snapshot.data!.data.res.overview.answerWithoutReading.toStringAsPrecision(4)}%", style: TextStyle(
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
                                      value: snapshot.data!.data.res.overview.answerVeryQuick/100,
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
                                  Text("${snapshot.data!.data.res.overview.answerVeryQuick.toStringAsPrecision(4)}", style: TextStyle(
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
                      ),
                      Container(
                        width: columnWidth,
                        margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.indigo
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: columnWidth-20,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Chapter: ${snapshot.data!.data.res.chapters[0].catName}", style: TextStyle(
                                      color: Colors.teal, fontSize: 10
                                  ),),
                                  Text("Type: ${snapshot.data!.data.res.chapters[0].catName}", style: TextStyle(
                                      color: Colors.teal, fontSize: 10
                                  ),),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text("Ques: ${snapshot.data!.data.res.chapters[0].questions[qcount].que}", style: TextStyle(
                                color: Colors.teal, fontSize: 10
                            ),),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    if(qcount!=0)
                                      setState(() {
                                        qcount=qcount-1;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.indigo
                                        ),
                                        color: Color.fromRGBO(182, 182, 182, 100),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Center(child: Text('Previous', style: TextStyle(
                                        color: Colors.white
                                    ),)),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                GestureDetector(
                                  onTap:(){
                                    if(qcount!=snapshot.data!.data.res.chapters[0].questions.length-1)
                                    setState(() {
                                      qcount=qcount+1;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.indigo
                                        ),
                                        color: Color.fromRGBO(182, 182, 182, 100),
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: Center(child: Text('Next', style: TextStyle(
                                        color: Colors.white
                                    ),)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
            else
              return Center(child: CircularProgressIndicator());
          }
      )

    );
  }
}
