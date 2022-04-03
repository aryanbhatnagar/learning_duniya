import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:learning_duniya/Dashboard.dart';
import 'package:learning_duniya/assessment.dart';
import 'package:learning_duniya/courseDesc.dart';
import 'package:learning_duniya/k12details.dart';
import 'package:learning_duniya/mentor.dart';
import 'package:learning_duniya/mentor_profile.dart';
import 'package:learning_duniya/profile.dart';
import 'package:learning_duniya/quiz.dart';
import 'package:group_button/group_button.dart';
import 'package:learning_duniya/seeall.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;
import 'globals.dart';


var CLASSid;
StuDashboard stuDashboardFromJson(String str) => StuDashboard.fromJson(json.decode(str));
String stuDashboardToJson(StuDashboard data) => json.encode(data.toJson());

class StuDashboard {
  StuDashboard({
    required this.data2,
    required this.message,
    required this.status,
  });

  Data3 data2;
  String message;
  int status;

  factory StuDashboard.fromJson(Map<String, dynamic> json) => StuDashboard(
    data2: Data3.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data2.toJson(),
    "message": message,
    "status": status,
  };
}
class Data3 {
  Data3({
    required this.subjects2,
    required this.assessments1,
    required this.results,
    required this.mentors,
  });

  List<Subject2> subjects2;
  List<AssessmentElement> assessments1;
  Results results;
  List<Mentor> mentors;

  factory Data3.fromJson(Map<String, dynamic> json) => Data3(
    subjects2: List<Subject2>.from(json["subjects"].map((x) => Subject2.fromJson(x))),
    assessments1: List<AssessmentElement>.from(json["assessments"].map((x) => AssessmentElement.fromJson(x))),
    results: Results.fromJson(json["results"]),
    mentors: List<Mentor>.from(json["mentors"].map((x) => Mentor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "subjects": List<dynamic>.from(subjects2.map((x) => x.toJson())),
    "assessments": List<dynamic>.from(assessments1.map((x) => x.toJson())),
    "results": results.toJson(),
    "mentors": List<dynamic>.from(mentors.map((x) => x.toJson())),
  };
}
class AssessmentElement {
  AssessmentElement({
    required this.id,
    required this.assessmentName,
    required this.img,
    required this.price,
  });

  int id;
  String assessmentName;
  String img;
  int price;

  factory AssessmentElement.fromJson(Map<String, dynamic> json) => AssessmentElement(
    id: json["id"],
    assessmentName: json["assessment_name"],
    img: json["img"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "assessment_name": assessmentName,
    "img": img,
    "price": price,
  };
}
class Results {
  Results({
    required this.assessment,
    required this.k12,
  });

  K12Class assessment;
  K12Class k12;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    assessment: K12Class.fromJson(json["assessment"]),
    k12: K12Class.fromJson(json["k12"]),
  );

  Map<String, dynamic> toJson() => {
    "assessment": assessment.toJson(),
    "k12": k12.toJson(),
  };
}
class K12Class {
  K12Class({
    required this.total,
    required this.totalQuestions,
    required this.correctAnswer,
    required this.wrongAnswer,
  });

  var total;
  var totalQuestions;
  var correctAnswer;
  var wrongAnswer;

  factory K12Class.fromJson(Map<String, dynamic> json) => K12Class(
    total: json["total"],
    totalQuestions: json["total_questions"],
    correctAnswer: json["correct_answer"],
    wrongAnswer: json["wrong_answer"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "total_questions": totalQuestions,
    "correct_answer": correctAnswer,
    "wrong_answer": wrongAnswer,
  };
}
class Subject2 {
  Subject2({
    required this.id,
    required this.subjectName,
    required this.icon
  });

  int id;
  String subjectName;
  var icon;

  factory Subject2.fromJson(Map<String, dynamic> json) => Subject2(
      id: json["id"],
      subjectName: json["subject_name"],
      icon: json["icon"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject_name": subjectName,
    "icon": icon
  };
}

Future<StuDashboard> createDash(String id) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/mentee/dashboard";

  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String> {
        "Authorization": "Bearer $token",
      },
      body: {
        "class_id": id
      }
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return stuDashboardFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}


var sublen;
K12Card k12CardFromJson(String str) => K12Card.fromJson(json.decode(str));
String k12CardToJson(K12Card data) => json.encode(data.toJson());
LandingApi landingApiFromJson(String str) => LandingApi.fromJson(json.decode(str));
String landingApiToJson(LandingApi data) => json.encode(data.toJson());

class K12Card {
  K12Card({
    required this.success,
    required this.data1,
    required this.message,
  });

  bool success;
  Data1 data1;
  String message;

  factory K12Card.fromJson(Map<String, dynamic> json) => K12Card(
    success: json["success"],
    data1: Data1.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data1.toJson(),
    "message": message,
  };
}
class Data1 {
  Data1({
    required this.k12,
  });

  List<K12_c> k12;

  factory Data1.fromJson(Map<String, dynamic> json) => Data1(
    k12: List<K12_c>.from(json["k12"].map((x) => K12_c.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "k12": List<dynamic>.from(k12.map((x) => x.toJson())),
  };
}
class K12_c {
  K12_c({
    required this.id,
    required this.courseName,
    required this.img,
    required this.chapter,
  });

  int id;
  int chapter;
  String courseName;
  String img;

  factory K12_c.fromJson(Map<String, dynamic> json) => K12_c(
    id: json["id"],
    courseName: json["course_name"],
    img: json["img"],
    chapter : json["chapter"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_name": courseName,
    "img": img,
    "chapter": chapter,
    };
}
Future<K12Card> createK12card(String id) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/getk12";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "subject_id": id
  }
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return k12CardFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}
Future<LandingApi> getLanding() async {

    final String apiUrl = "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/dashboard";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return landingApiFromJson(responseString);
    }
    else {
      throw Exception('Failed to load album');
    }
  }


class LandingApi {
  LandingApi({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory LandingApi.fromJson(Map<String, dynamic> json) => LandingApi(
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
    required this.subjects,
    required this.mentors,
    required this.assessments,
    required this.dataClass,
    required this.k12,
    required this.competitiveExams,
    required this.popularCourses,
  });

  List<Subject> subjects;
  List<Mentor> mentors;
  List<Assessment> assessments;
  List<Class> dataClass;
  List<K12> k12;
  List<Compete> competitiveExams;
  List<popular> popularCourses;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
    mentors: List<Mentor>.from(json["mentors"].map((x) => Mentor.fromJson(x))),
    assessments: List<Assessment>.from(json["assessments"].map((x) => Assessment.fromJson(x))),
    dataClass: List<Class>.from(json["class"].map((x) => Class.fromJson(x))),
    k12: List<K12>.from(json["k12"].map((x) => K12.fromJson(x))),
    competitiveExams: List<Compete>.from(json["competitive_exams"].map((x) => Compete.fromJson(x))),
    popularCourses: List<popular>.from(json["popular_courses"].map((x) => popular.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
    "mentors": List<dynamic>.from(mentors.map((x) => x.toJson())),
    "assessments": List<dynamic>.from(assessments.map((x) => x.toJson())),
    "class": List<dynamic>.from(dataClass.map((x) => x.toJson())),
    "k12": List<dynamic>.from(k12.map((x) => x.toJson())),
    "competitive_exams": List<dynamic>.from(competitiveExams.map((x) => x.toJson())),
    "popular_courses": List<dynamic>.from(popularCourses.map((x) => x.toJson())),
  };
}
class Assessment {
  Assessment({
    required this.id,
    required this.assessmentName,
    required this.img,
    required this.price,

  });

  int id;
  String assessmentName;
  String img;
  var price;


  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
    id: json["id"],
    assessmentName: json["assessment_name"],
    img: json["img"],
    price: json["price"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "assessment_name": assessmentName ,
    "img": img,
    "price": [price],

  };
}
class Class {
  Class({
    required this.id,
    required this.className,
  });

  int id;
  String className;

  factory Class.fromJson(Map<String, dynamic> json) => Class(
    id: json["id"],
    className: json["class_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class_name": className,
  };
}
class K12 {
  K12({
    required this.id,
    required this.courseName,
    required this.img,
    required this.chapter,
  });

  int id;
  String courseName;
  String img;
  int chapter;

  factory K12.fromJson(Map<String, dynamic> json) => K12(
    id: json["id"],
    courseName: json["course_name"],
    img: json["img"],
    chapter: json["chapter"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_name": courseName,
    "img": img,
    "chapter": chapter,
  };
}
class Mentor {
  Mentor({
    required this.id,
    required this.eduName,
    required this.img,
    required this.specilization
  });

  int id;
  String eduName;
  String img;
  var specilization;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
    id: json["id"],
    eduName: json["edu_name"],
    img: json["img"],
    specilization: json["specilization"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "edu_name": eduName,
    "img": img,
    "specilization": specilization
  };
}
class Subject {
  Subject({
    required this.id,
    required this.subjectName,
  });

  int id;
  String subjectName;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    subjectName: json["subject_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject_name": subjectName,
  };
}
class Compete{
  Compete({
    required this.id,
    required this.img,
    required this.price,
    required this.subjectName,
  });

  int id;
  String img;
  String price;
  String subjectName;

  factory Compete.fromJson(Map<String, dynamic> json) => Compete(
    id: json["id"],
    img: json["img"],
    price: json["price"],
    subjectName: json["subject_name"]

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "img": img,
    "price": [price],
    "subject_name": subjectName
  };
}
class popular{
  popular({
    required this.id,
    required this.img,
    required this.price,
    required this.subjectName,
    required this.subject,
  });

  int id;
  String img;
  String price;
  String subjectName;
  String subject;

  factory popular.fromJson(Map<String, dynamic> json) => popular(
    id: json["id"],
    img: json["img"],
    price: json["price"],
    subjectName: json["subject_name"] ,
    subject: json["subject"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "img": img,
    "price": [price],
    "subject_name": subjectName ,
    "subject": subject
  };
}


class landing extends StatelessWidget {
  const landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: landingPage(),
    );
  }
}

class landingPage extends StatefulWidget {
  const landingPage({Key? key}) : super(key: key);

  @override
  _landingPageState createState() => _landingPageState();
}



class _landingPageState extends State<landingPage> {

  int _selectedIndex = 0;
  String sub="Chemistry";
  List<Widget> add = [];
  List<int> butind=[];


  //list for views
  List <Widget> pop_c= <Widget>[];
  List <Widget> asses= <Widget>[];
  List <Widget> k12= <Widget>[];
  List <Widget> k12_copy= <Widget>[];
  int k12_pos=1;
  List<bool> isSelected =List.generate(5, (index) => false);
  List <Widget> comp_e= <Widget>[];
  List <Widget> mento= <Widget>[];

  //for k-12 subjects, list
  List <Widget> sci= <Widget>[];
  List <Widget> hin= <Widget>[];
  List <Widget> eng= <Widget>[];
  List <Widget> comp= <Widget>[];

  void indexSelect(int i){
    setState(() {
      _selectedIndex=i;
    });
  }


  Future<void> _onItemTapped(int index) async {
    if(index==1)
      {
        if (token!="")
          if(classId=="")
            {
              Future<ConfirmAction?> action =
                  await _asyncConfirmDialog(
                  context,
                  'Mentor Name',
                  'Mentor Bio',
                  'Communication',
                  [],
                  'None');
            }
      }
    if(index==1 && classId!="")
    indexSelect(index);
    else
      indexSelect(index);
  }

  @override
  void initState()  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    //isSelected[0]=true;
      final controller = GroupButtonController();
      List<Widget> _widgetOptions = <Widget>[

        FutureBuilder(
          future: getLanding(),
          builder: (context,AsyncSnapshot<LandingApi> snapshot) {
            print(snapshot.data);
            if (snapshot.hasData)
            {
              LandingApi? landApi=snapshot.data;
              if(pop_c.isEmpty) {
                isSelected[0]=true;
                for (var i = 0; i < landApi!.data.popularCourses.length; i++)
                  pop_c.add(GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => k12_det(landApi!.data.popularCourses[i].id.toString(),landApi!.data.popularCourses[i].img.toString())));
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 120,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage("${landApi!.data.popularCourses[i].img}"),fit: BoxFit.fill),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                            child: Container(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                            "${landApi.data.popularCourses[i]
                                                .subjectName}\n",
                                            maxLines: 2,
                                            style: TextStyle(fontSize: 15,
                                                fontFamily: "Candara",
                                                color: Colors.black)),
                                      ),
                                      //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                      FavoriteButton(
                                        iconSize: 24,
                                        isFavorite: false,
                                        // iconDisabledColor: Colors.white,
                                        valueChanged: (_isFavorite) {
                                          print('Is Favorite : $_isFavorite');
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            child: Text("Gone"),
                            visible: false,
                          ),
                        ],
                      ),

                    ),
                  ));
                for (var i = 0; i < landApi!.data.assessments.length; i++)
                  asses.add(GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                          assess(landApi!.data.assessments[i].id,landApi.data.assessments[i].img.toString())));
                    },
                    child: Container(
                      //width: 220,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 2.5),
                            Container(
                              height: 125,
                              width: 125,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("${landApi!.data.assessments[i].img}"),fit: BoxFit.fill),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Container(
                                width: 135,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                              "${landApi!.data.assessments[i]
                                                  .assessmentName}\n",
                                              overflow: TextOverflow.clip,
                                              maxLines: 2,
                                              style: TextStyle(fontSize: 16,
                                                  fontFamily: "Candara",
                                                  color: Colors.black)),
                                        ),
                                        //SizedBox(width: 5),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "${landApi!.data.assessments[i].price}",
                                            style: TextStyle(fontSize: 18,
                                            fontFamily: "Candara",
                                            color: Colors.red)),
                                        FavoriteButton(
                                          iconSize: 24,
                                          isFavorite: false,
                                          // iconDisabledColor: Colors.white,
                                          valueChanged: (_isFavorite) {
                                            print('Is Favorite : $_isFavorite');
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                    ),
                  ));
                for (var i = 0; i < landApi!.data.competitiveExams.length; i++)
                  comp_e.add(GestureDetector(
                    onTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 135,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage("${landApi!.data.competitiveExams[i].img.toString()}"),fit: BoxFit.fill),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                            child: Container(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(landApi.data.competitiveExams[i]
                                          .subjectName,
                                          style: TextStyle(fontSize: 16,
                                              fontFamily: "Candara",
                                              color: Colors.black)),
                                      //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                      FavoriteButton(
                                        iconSize: 30,
                                        isFavorite: false,
                                        // iconDisabledColor: Colors.white,
                                        valueChanged: (_isFavorite) {
                                          print('Is Favorite : $_isFavorite');
                                        },
                                      )
                                    ],
                                  ),

                                  Text(landApi.data.competitiveExams[i]
                                      .price.toString(), style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Candara",
                                      color: Colors
                                          .red))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                    ),
                  ));
                for (var i = 0; i < landApi!.data.mentors.length; i++)
                  mento.add(GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) =>
                              mentor(landApi!.data.mentors[i]
                                  .id)));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage("${landApi!.data.mentors[i].img.toString()}"),fit: BoxFit.fill),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                            child: Container(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(landApi!.data.mentors[i].eduName,
                                          style: TextStyle(fontSize: 16,
                                              fontFamily: "Candara",
                                              color: Colors.black)),
                                      //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data!.data.mentors[i].specilization.toString(), style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Candara",
                                          color: Colors.grey))
                                    ],

                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                    ),
                  ));

                for(int j=0;j<snapshot.data!.data.subjects.length;j++)
                  butind.add(snapshot.data!.data.subjects[j].id.toInt());
               // isSelected = List.generate(snapshot.data!.data.subjects.length, (index) => false);

              }
              return Container(
                color: Colors.teal,
                child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Popular Courses", style: TextStyle(
                                  fontFamily: "Candara",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                            ],
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: pop_c,

                              )
                          ),
                          SizedBox(height: 15),


                        ],
                      ),


                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      color: Colors.teal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Assessment", style: TextStyle(
                                  fontFamily: "Candara",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                              GestureDetector(
                                child: Text("See all", style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.lightBlueAccent,
                                    fontFamily: "Candara")),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          seeallpage("Assessment", 2)));
                                },)
                            ],
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: asses
                              )
                          ),
                          SizedBox(height: 15),

                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white),
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("K12", style: TextStyle(fontFamily: "Candara",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                              //GestureDetector(child: Text("See all",style: TextStyle(fontSize: 20,color: Colors.blue,fontFamily: "Candara")))
                            ],
                          ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ToggleButtons(
                                    children: <Widget>[
                                      for(int j=0;j<snapshot.data!.data.subjects.length;j++)
                                        Text(" ${snapshot.data!.data.subjects[j].subjectName}  ",style: TextStyle(fontFamily: "Candara",fontSize: 17),)
                                  ],

                                  selectedBorderColor: Colors.teal,
                                  selectedColor: Colors.white,
                                  borderColor: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  disabledColor: Colors.transparent,
                                  disabledBorderColor: Colors.transparent,
                                  focusColor: Colors.teal,
                                  fillColor: Colors.teal,
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                                        if (buttonIndex == index) {
                                          isSelected[buttonIndex] = true;
                                        } else {
                                          isSelected[buttonIndex] = false;
                                        }
                                      }
                                      k12_pos=butind[index];
                                    });
                                  },
                                  isSelected: isSelected,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          FutureBuilder(
                              future: createK12card(k12_pos.toString()),
                              builder: (context,AsyncSnapshot<K12Card> snapshot2){
                                if(snapshot2.hasData){
                                  K12Card? k12_obj = snapshot2.data;
                                  return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: <Widget>[
                                      for (var i = 0; i <k12_obj!.data1.k12.length; i++)
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => k12_det(k12_obj!.data1.k12[i].id.toString(),landApi!.data.popularCourses[i].img)));
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(10))),
                                            elevation: 5,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(image: NetworkImage("${k12_obj!.data1.k12[i].img.toString()}"),fit: BoxFit.fill),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                  child: Container(
                                                    height: 100,
                                                    width: 150,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              child: Text("${k12_obj!.data1.k12[i].courseName}\n",
                                                                  style: TextStyle(fontSize: 15,
                                                                      fontFamily: "Candara",
                                                                      color: Colors.black),
                                                                maxLines: 2,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                            //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 15),color: Colors.grey,)

                                                          ],
                                                        ),
                                                        SizedBox(height: 8),
                                                        Text("${k12_obj.data1.k12[i].chapter} Chapters", style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: "Candara",
                                                            color: Colors
                                                                .grey)),
                                                        Text("${k12_obj.data1.k12[i].chapter} Chapters", style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: "Candara",
                                                            color: Colors
                                                                .grey)),
                                                        SizedBox(height: 5),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),

                                          ),
                                        )

                                    ],


                                  )
                              );
                                }
                                else
                                  return Container(child: Center(child: CircularProgressIndicator()));
                              }
                              ),

                          SizedBox(height: 15),


                        ],
                      ),

                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)), color: Colors.teal),
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Competitive Exam", style: TextStyle(
                                  fontFamily: "Candara",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                              GestureDetector(
                                  child: Text("See all", style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.lightBlueAccent,
                                      fontFamily: "Candara")),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            seeallpage("Competitive Exam", 3)));
                                  })
                            ],
                          ),
                          SizedBox(height: 20),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: comp_e
                              )
                          ),
                          SizedBox(height: 15),
                        ],
                      ),


                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      decoration: BoxDecoration(borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)), color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Mentor", style: TextStyle(
                                  fontFamily: "Candara",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                              GestureDetector(
                                  child: Text("See all", style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.lightBlueAccent,
                                      fontFamily: "Candara")),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            seeallpage("Mentors", 4)));
                                  })
                            ],
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>mentorProfile()));
                          },
                            child: Text("Become a mentor"),),
                          SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: mento
                              )
                          ),
                          SizedBox(height: 30)
                        ],
                      ),
                    )
                  ],
                )
          ),
              );
            }
            else
              return Container(child: CircularProgressIndicator());
          }
        ),
        FutureBuilder(
          future: getLanding(),
          builder: (context,AsyncSnapshot<LandingApi> snapshot1) {
            if (token=="")
              return Column(
                children: [
                  Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("images/login.jpg"),fit: BoxFit.fill),
                    ),
                  ),
                  Center(child: Text("Please Login to view Dashboard", style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Candara",
                      color: Colors.teal),),),
                  SizedBox(height: 15,),
                  Center(
                    child:  RaisedButton(
                      onPressed: (){
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text('LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontFamily: "Candara")),
                      color: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    )
            ),
                ],
              );
            else
              return FutureBuilder(
                  future: createDash(classId),
                  builder: (context,AsyncSnapshot<StuDashboard> snapshot) {
                    //print(snapshot.data!.data.toString());
                    if (snapshot.hasData)
                    {
                      print(snapshot.data!.message.toString());
                      //LandingApi? landApi=snapshot.data;
                      List<bool> isSelected = List.generate(snapshot.data!.data2.subjects2.length, (index) => false);
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 25, top: 10),
                              child: Text(
                                'Hi $userName',
                                style: TextStyle(
                                    fontSize: 17.5, color: Colors.black, fontFamily: "Candara"),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 25, bottom: 10),
                              child: Text(
                                "Choose your courses",
                                style: TextStyle(
                                    fontFamily: "Candara", fontSize: 12.5, color: Colors.grey),
                              ),
                            ),
                            Container(
                              //height: 100,
                              padding: EdgeInsets.only(left: 1, right: 1, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  GridView.count(
                                    shrinkWrap: true,
                                    primary: false,
                                    padding: const EdgeInsets.all(20),
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 3,
                                    children: <Widget>[
                                      for(var i=0;i<snapshot.data!.data2.subjects2.length.toInt();i++)
                                        GestureDetector(
                                          onTap:(){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => k12_det(snapshot.data!.data2.subjects2[i].id.toString(),"images/english.png")));

                                          },
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                    radius: 35,
                                                    backgroundImage:
                                                    NetworkImage('${snapshot.data!.data2.subjects2[i].icon.toString()}')),
                                                SizedBox(height: 10),
                                                Text(
                                                  "${snapshot.data!.data2.subjects2[i].subjectName}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: "Candara"),
                                                )
                                              ],
                                            ),
                                          ),

                                        ),

                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text("Assessments", style: TextStyle(
                                  fontFamily: "Candara",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                            ),
                            Container(
                              child: SingleChildScrollView(
                                padding: EdgeInsets.all(20),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: <Widget>[
                                        for (var i = 0; i < snapshot.data!.data2.assessments1.length; i++)
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) =>
                                                  assess(snapshot.data!.data2.assessments1[i].id,snapshot.data!.data2.assessments1[i].img.toString())));
                                            },
                                            child: Container(
//width: 220,
                                              child: Card(
                                                elevation: 5,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(
                                                        10))),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    SizedBox(height: 2.5),
                                                    Container(
                                                      height: 120,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(image: NetworkImage("${snapshot.data!.data2.assessments1[i].img}"),fit: BoxFit.fill),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                      child: Container(
                                                        width: 130,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize: MainAxisSize.max,
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Flexible(
                                                                  child: Text(
                                                                      "${snapshot.data!.data2.assessments1[i]
                                                                          .assessmentName}\n",
                                                                      overflow: TextOverflow.clip,
                                                                      maxLines: 2,
                                                                      style: TextStyle(fontSize: 16,
                                                                          fontFamily: "Candara",
                                                                          color: Colors.black)),
                                                                ),
//SizedBox(width: 5),
                                                              ],
                                                            ),
                                                            SizedBox(height: 10),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                    "${snapshot.data!.data2.assessments1[i].price.toString()}", style: TextStyle(fontSize:18,
                                                                    fontFamily: "Candara",
                                                                    color: Colors.red)),
                                                                FavoriteButton(
                                                                  iconSize: 24,
                                                                  isFavorite: false,
// iconDisabledColor: Colors.white,
                                                                  valueChanged: (_isFavorite) {
                                                                    print('Is Favorite : $_isFavorite');
                                                                  },
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),

                                              ),
                                            ),
                                          )
                                      ]
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25, right: 20, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("ScoreCard",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontFamily: "Candara")),
                                  RaisedButton(
                                    onPressed: () {},
                                    child: Text('Browse all mock tests',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0,
                                            fontFamily: "Candara")),
                                    color: Colors.teal,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 20, right: 10),
                                      width: 400,
                                      height: 220,
                                      child: Card(
                                        color: Colors.white,
                                        shadowColor: Colors.grey,
                                        borderOnForeground: true,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: 10, top: 10),
                                              child: Text(
                                                "ASSESSMENTS",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.indigo,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Candara"),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 10, bottom: 5),
                                              child: Text(
                                                "Drive your competency",
                                                style: TextStyle(
                                                    fontFamily: "Candara",
                                                    fontSize: 17.5,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text("Total Tests",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                          fontFamily: "Candara")),
                                                  Text("Total Questions",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                          fontFamily: "Candara")),
                                                  Text("Correct",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                          fontFamily: "Candara")),
                                                  Text("Wrong",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                          fontFamily: "Candara"))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20, top: 5, bottom: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Center(
                                                    child: Text("  ${snapshot.data!.data2.results.assessment.total}",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 25,
                                                            color: Colors.black,
                                                            fontFamily: "Candara")),
                                                  ),
                                                  Center(
                                                    child: Text("    ${snapshot.data!.data2.results.assessment.totalQuestions}",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 25,
                                                            color: Colors.black,
                                                            fontFamily: "Candara")),
                                                  ),
                                                  Center(
                                                    child: Text("    ${snapshot.data!.data2.results.assessment.correctAnswer}",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 25,
                                                            color: Colors.green,
                                                            fontFamily: "Candara")),
                                                  ),
                                                  Center(
                                                    child: Text("${snapshot.data!.data2.results.assessment.wrongAnswer}",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 25,
                                                            color: Colors.red,
                                                            fontFamily: "Candara")),
                                                  )
                                                ],
                                              ),
                                            ),
                                            //SizedBox(height: 10),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                              child: RaisedButton(
                                                onPressed: () {},
                                                child: Text('PRACTICE AGAIN',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.0,
                                                        fontFamily: "Candara")),
                                                color: Colors.deepOrange,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10, right: 20),
                                      width: 400,
                                      height: 220,
                                      child: Card(
                                        color: Colors.white,
                                        shadowColor: Colors.grey,
                                        borderOnForeground: true,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: 10, top: 10),
                                              child: Text(
                                                "K12-ASSESSMENTS",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.indigo,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Candara"),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 10, bottom: 5),
                                              child: Text(
                                                "Drive your competency",
                                                style: TextStyle(
                                                    fontFamily: "Candara",
                                                    fontSize: 17.5,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text("Total Tests",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                          fontFamily: "Candara")),
                                                  Text("Total Questions",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                          fontFamily: "Candara")),
                                                  Text("Correct",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                          fontFamily: "Candara")),
                                                  Text("Wrong",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                          fontFamily: "Candara"))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20, top: 5, bottom: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Center(
                                                    child: Text("  ${snapshot.data!.data2.results.k12.total}",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 25,
                                                            color: Colors.black,
                                                            fontFamily: "Candara")),
                                                  ),
                                                  Center(
                                                    child: Text("    ${snapshot.data!.data2.results.k12.totalQuestions}",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 25,
                                                            color: Colors.black,
                                                            fontFamily: "Candara")),
                                                  ),
                                                  Center(
                                                    child: Text("    ${snapshot.data!.data2.results.k12.correctAnswer}",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 25,
                                                            color: Colors.green,
                                                            fontFamily: "Candara")),
                                                  ),
                                                  Center(
                                                    child: Text("${snapshot.data!.data2.results.k12.wrongAnswer}",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 25,
                                                            color: Colors.red,
                                                            fontFamily: "Candara")),
                                                  )
                                                ],
                                              ),
                                            ),
                                            //SizedBox(height: 10),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                              child: RaisedButton(
                                                onPressed: () {},
                                                child: Text('PRACTICE AGAIN',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15.0,
                                                        fontFamily: "Candara")),
                                                color: Colors.deepOrange,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: <Widget>[
                                    for(var i=0;i<snapshot.data!.data2.mentors.length.toInt();i++)
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (context) =>
                                                  mentor(snapshot.data!.data2.mentors[i]
                                                      .id)));
                                        },
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10))),
                                          elevation: 5,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                height: 120,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(image: NetworkImage("${snapshot.data!.data2.mentors[i].img.toString()}"),fit: BoxFit.fill),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                                                child: Container(
                                                  width: 150,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(snapshot.data!.data2.mentors[i].eduName,
                                                              style: TextStyle(fontSize: 16,
                                                                  fontFamily: "Candara",
                                                                  color: Colors.black)),
                                                          //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text(snapshot.data!.data2.mentors[i].specilization.toString(), style: TextStyle(
                                                              fontSize: 15,
                                                              fontFamily: "Candara",
                                                              color: Colors.grey))
                                                        ],

                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),

                                        ),
                                      )
                                  ])),
                            ),
                          ],
                        ),
                      );
                    }
                    else
                      return Container(child: CircularProgressIndicator());
                  }
              );
          },
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white,
                height: 100,
                padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Card(
                  color: Colors.blue,
                  shadowColor: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                height: 100,
                padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Card(
                  color: Colors.blue,
                  shadowColor: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                height: 100,
                padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Card(
                  color: Colors.blue,
                  shadowColor: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white,
                height: 100,
                padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Card(
                  color: Colors.orange,
                  shadowColor: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                height: 100,
                padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Card(
                  color: Colors.orange,
                  shadowColor: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                height: 100,
                padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Card(
                  color: Colors.orange,
                  shadowColor: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        )

      ];


      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed:(){ Scaffold.of(context).openDrawer();},
                icon: Icon(Icons.menu,color: Colors.teal,),
              );
            },
          ),
          toolbarHeight: 70,
          backgroundColor: Colors.white70,
          //leading:
          //Icon(Icons.menu, color: Colors.black, size: 30,),
          //centerTitle: true,
          actions: <IconButton>[
            IconButton(
                /*onPressed: () async {
              if(token=="")
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
              else if(token!="" && classId!=""){
                print(userName);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Dashboard(classId)));
              }
              else{
                final Future<ConfirmAction?> action =
                    await _asyncConfirmDialog(
                    context,
                    'Mentor Name',
                    'Mentor Bio',
                    'Communication',
                    x,
                    'None');
              }
            }*/
                icon: Icon(Icons.notifications, color: Colors.teal, size: 30),
              onPressed: (){},
            )
          ],
          title: Text("Let's Start Learning", style: TextStyle(
              fontSize: 20,
              fontFamily: "Candara",
              color: Colors.teal),)

        ),
        drawer: Drawer(
          elevation: 5,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Text('MENU'),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  setState(()  {
                    userName = "";
                    userEmail = "";
                    userId = 0;
                    token = "";
                    classId="";
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: true,
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.grey,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, size: 30),
                  label: 'Home',
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined, size: 30),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.school_outlined,
                  size: 30,
                ),
                label: 'Scholarship',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_active_outlined, size: 30),
                  label: 'Exam Alert'),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            elevation: 5),
        body: FutureBuilder(
            future: getLanding(),
            builder: (context, AsyncSnapshot<LandingApi> snapshot){
              if(snapshot.hasData){
                //sublen=snapshot.data?.data.subjects.length.toInt();
                return SafeArea(child:_widgetOptions.elementAt(_selectedIndex));
              }
              else{
                return Container(child: Center(child: CircularProgressIndicator()));
              }
            },
          )

      );
    }

}
final TextEditingController classController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

enum ConfirmAction { Confirm }
Future<Future<ConfirmAction?>> _asyncConfirmDialog(
    BuildContext context,
    String userName,
    String userBio,
    String modeOfC,
    List<String> selected,
    String comments) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        //title: Text('Delete This Contact?'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Image.asset(
          'images/english.png',
          height: 50,
          width: 50,
        ),
        content: Container(
          width: double.infinity,
          //height: Wrap(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Text(
                    "Please Enter your Class",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Candara',
                    ),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(

                        controller: classController,
                        validator: (input) {
                          if (input!.isEmpty) return 'Enter Class';
                        },
                        decoration: InputDecoration(
//fillColor: Colors.white,

                          enabledBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.teal,width: 2.0),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          labelText: 'CLASS',
                          labelStyle: TextStyle(fontFamily: "Candara"),
                          prefixIcon: Icon(Icons.school,color: Colors.teal),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey,
                        ),
// onSaved: (input) => _email = input!
                      ),
                    ),
                  ),
                ],
              ),
              /*Divider(
                color: Colors.grey,
              ),
              SizedBox(height: 10),*/

            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.teal)),
                  child: Text(
                    'CONFIRM',
                    style: TextStyle(
                      fontFamily: 'Candara',
                    ),
                  ),
                  onPressed: () {
                    if(_formKey.currentState!.validate())
                      {
                        classId=classController.text.toString();
                        if(classId!="")
                          {
                            Navigator.of(context).pop(ConfirmAction.Confirm);
                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) => landing()));
                          }


                      }
                    //Navigator.of(context).pop(ConfirmAction.Confirm);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

