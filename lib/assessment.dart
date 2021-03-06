import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:http/http.dart' as http;
import 'package:learning_duniya/Login2.dart';
import 'package:learning_duniya/quiz.dart';
import 'package:learning_duniya/quiz_assessment.dart';
import 'package:learning_duniya/test.dart';

import 'Login.dart';
import 'globals.dart';

Assess assessFromJson(String str) => Assess.fromJson(json.decode(str));

String assessToJson(Assess data) => json.encode(data.toJson());
var assId = "";
var ass_Image="";
Future<Assess> createAssess(String id) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/assessment";
  final response = await http.post(Uri.parse(apiUrl), body: {"id": id});

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return assessFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

class Assess {
  Assess({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory Assess.fromJson(Map<String, dynamic> json) => Assess(
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
    required this.chapters,
  });

  Assessment assessment;
  List<Chapter> chapters;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    assessment: Assessment.fromJson(json["assessment"]),
    chapters: List<Chapter>.from(
        json["chapters"].map((x) => Chapter.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "assessment": assessment.toJson(),
    "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
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
  });

  int id;
  String assessmentName;
  int subjectId;
  String subject;
  int classId;
  String assessmentClass;
  int bookId;
  String book;

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
    id: json["id"],
    assessmentName: json["assessment_name"],
    subjectId: json["subject_id"],
    subject: json["subject"],
    classId: json["class_id"],
    assessmentClass: json["class"],
    bookId: json["book_id"],
    book: json["book"],
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
  };
}

class Chapter {
  Chapter({
    required this.id,
    required this.chapterName,
  });

  int id;
  String chapterName;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    id: json["id"],
    chapterName: json["chapter_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "chapter_name": chapterName,
  };
}

class assess extends StatelessWidget {
  late int id;
  var image;
  assess(this.id,this.image); //const assess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ass_Image=image;
    assId = id.toString();
    return MaterialApp(
      home: assessment(),
    );
  }
}

class assessment extends StatefulWidget {
  assessment({Key? key}) : super(key: key);

  @override
  _assessmentState createState() => _assessmentState();
}

class _assessmentState extends State<assessment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = GroupButtonController();
    List<bool> isSelected = [false, false, false];

    return Scaffold(
        body: FutureBuilder(
          future: createAssess(assId),
          builder: (context, AsyncSnapshot<Assess> snapshot) {
            if (snapshot.hasData) {
              Assess? ass = snapshot.data;

              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(25),
                    height: (size.height) / 2.5,
                    width: (size.width),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        image: DecorationImage(
                            image: NetworkImage("${ass_Image}"),
                            fit: BoxFit.fill)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Text("Mentor Name",style: TextStyle(fontSize: 50,fontFamily: "Candara",color: Colors.white)),
                        //SizedBox(height: 5),
                        //Text("Specialization",style: TextStyle(fontSize: 30,fontFamily: "Candara",color: Colors.greenAccent))
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      height: (size.height) - (size.height) / 3,
                      width: (size.width),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(34)),
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(ass!.data.assessment.assessmentName,
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontFamily: "Candara",
                                            color: Colors.black)),
                                  ),
                                  //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                ],
                              ),
                              //Text("Specialization",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey)),
                              //SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.book, color: Colors.teal, size: 22),
                                  Text(ass.data.assessment.book,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Candara",
                                          color: Colors.teal)),
                                  SizedBox(width: 30),
                                  Icon(Icons.people, color: Colors.yellow, size: 25),
                                  Text(ass.data.assessment.assessmentClass,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Candara",
                                          color: Colors.grey))
                                  //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                ],
                              ),
                              SizedBox(height: 20),
                              Text("Assessment Description",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Candara",
                                      color: Colors.black)),
                              //SizedBox(height: 10),
                              Text(ass.data.assessment.book,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Candara",
                                      color: Colors.grey)),
                              SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [

                                          Icon(Icons.sticky_note_2,color: Colors.orange,size: 20),
                                          Text(" Subject",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Candara",
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Text("      ${ass.data.assessment.subject}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Candara",
                                              color: Colors.grey)),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [

                                          Icon(Icons.content_paste,color: Colors.teal,size: 20),
                                          Text(" Chapters",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Candara",
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Text("      ${ass.data.chapters.length.toString()}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Candara",
                                              color: Colors.grey)),
                                    ],
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Icon(Icons.class_,color: Colors.teal,size: 20),
                                          Text(" Class",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Candara",
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Text("      ${ass.data.assessment.assessmentClass}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Candara",
                                              color: Colors.grey)),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [
                                          Icon(Icons.menu_book,color: Colors.teal,size: 20),
                                          Text(" Book",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Candara",
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Text("      ${ass.data.assessment.book}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Candara",
                                              color: Colors.grey)),
                                    ],
                                  )
                                ],
                              ),

                              SizedBox(height: 25),
                              for (int i = 0;
                              i < snapshot.data!.data.chapters.length;
                              i++)
                                GestureDetector(
                                  onTap: () {
                                    if(token!=""){
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => quiz_assessment(snapshot.data!.data.chapters[i].id,snapshot.data!.data.assessment.id)));}
                                    else{
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => Login2()));
                                    }
                                  },
                                  child: Card(
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  snapshot.data!.data.chapters[i]
                                                      .chapterName,
                                                  style: TextStyle(
                                                      fontFamily: "Candara",
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward_ios,
                                              color: Colors.black, size: 30)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
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