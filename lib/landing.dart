import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:learning_duniya/assessment.dart';
import 'package:learning_duniya/courseDesc.dart';
import 'package:learning_duniya/k12details.dart';
import 'package:learning_duniya/mentor.dart';
import 'package:learning_duniya/quiz.dart';
import 'package:group_button/group_button.dart';
import 'package:learning_duniya/seeall.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;

Future<LandingApi> getLanding() async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/dashboard";
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return landingApiFromJson(responseString);
  } else {
    throw Exception('Failed to load album');
  }
}

//late LandingApi? _landApi;
LandingApi landingApiFromJson(String str) =>
    LandingApi.fromJson(json.decode(str));
String landingApiToJson(LandingApi data) => json.encode(data.toJson());

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
        subjects: List<Subject>.from(
            json["subjects"].map((x) => Subject.fromJson(x))),
        mentors:
            List<Mentor>.from(json["mentors"].map((x) => Mentor.fromJson(x))),
        assessments: List<Assessment>.from(
            json["assessments"].map((x) => Assessment.fromJson(x))),
        dataClass:
            List<Class>.from(json["class"].map((x) => Class.fromJson(x))),
        k12: List<K12>.from(json["k12"].map((x) => K12.fromJson(x))),
        competitiveExams: List<Compete>.from(
            json["competitive_exams"].map((x) => Compete.fromJson(x))),
        popularCourses: List<popular>.from(
            json["popular_courses"].map((x) => popular.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
        "mentors": List<dynamic>.from(mentors.map((x) => x.toJson())),
        "assessments": List<dynamic>.from(assessments.map((x) => x.toJson())),
        "class": List<dynamic>.from(dataClass.map((x) => x.toJson())),
        "k12": List<dynamic>.from(k12.map((x) => x.toJson())),
        "competitive_exams":
            List<dynamic>.from(competitiveExams.map((x) => x.toJson())),
        "popular_courses":
            List<dynamic>.from(popularCourses.map((x) => x.toJson())),
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
  String price;

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
        id: json["id"],
        assessmentName: json["assessment_name"],
        img: json["img"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "assessment_name": assessmentName,
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
  });

  int id;
  String eduName;
  String img;

  factory Mentor.fromJson(Map<String, dynamic> json) =>
      Mentor(id: json["id"], eduName: json["edu_name"], img: json["img"]);

  Map<String, dynamic> toJson() => {"id": id, "edu_name": eduName, "img": img};
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

class Compete {
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
      subjectName: json["subject_name"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "price": [price],
        "subject_name": subjectName
      };
}

class popular {
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
      subjectName: json["subject_name"],
      subject: json["subject"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "img": img,
        "price": [price],
        "subject_name": subjectName,
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
  String sub = "Chemistry";
  List<Widget> add = [];

  //list for views
  List<Widget> pop_c = <Widget>[];
  List<Widget> asses = <Widget>[];
  List<Widget> k12 = <Widget>[];
  List<Widget> comp_e = <Widget>[];
  List<Widget> mento = <Widget>[];

  //for k-12 subjects, list
  List<Widget> sci = <Widget>[];
  List<Widget> hin = <Widget>[];
  List<Widget> eng = <Widget>[];
  List<Widget> comp = <Widget>[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void update_k12(int i) {
    switch (i) {
      case 0:
        setState(() {
          k12 = sci;
        });
        break;
      case 1:
        setState(() {
          k12 = hin;
        });
        break;
      case 2:
        setState(() {
          k12 = eng;
        });
        break;
      case 3:
        setState(() {
          k12 = comp;
        });
        break;
    }
  }

  Future<void> callapi() async {}

  @override
  void initState() {
    super.initState();
    callapi();
  }

  @override
  Widget build(BuildContext context) {
    final controller = GroupButtonController();
    List<bool> isSelected = [false, false, false];

    //update.list

    k12 = sci;

    List<Widget> _widgetOptions = <Widget>[
      FutureBuilder(
          future: getLanding(),
          builder: (context, AsyncSnapshot<LandingApi> snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              LandingApi? landApi = snapshot.data;

              for (var i = 0; i < landApi!.data.popularCourses.length; i++)
                pop_c.add(GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => courseDesc()));
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                                child: Image(
                                    image: AssetImage("images/sci.jfif"),
                                    height: 120,
                                    width: 150))),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                          child: Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                          landApi.data.popularCourses[i]
                                              .subjectName,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Candara",
                                              color: Colors.black)),
                                    ),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {},
                                        icon: Icon(Icons.person,
                                            size: 20, color: Colors.grey)),
                                    Text("Name",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: "Candara",
                                            color: Colors.grey))
                                  ],
                                ),
                                Text("\$1234",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Candara",
                                        color: Colors.red))
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
              for (var i = 0; i < landApi.data.assessments.length; i++)
                asses.add(GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                assess(landApi.data.assessments[i].id)));
                  },
                  child: Container(
                    //width: 220,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                  image: AssetImage("images/hindiass.jpg"),
                                  height: 120,
                                  width: 200,
                                  fit: BoxFit.fitWidth)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Container(
                              //width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                            landApi.data.assessments[i]
                                                .assessmentName,
                                            overflow: TextOverflow.clip,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: "Candara",
                                                color: Colors.black)),
                                      ),
                                      //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                      SizedBox(width: 5),
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
                                  SizedBox(height: 10),
                                  Text("\$1234",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Candara",
                                          color: Colors.red))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
              for (var i = 0; i < landApi.data.competitiveExams.length; i++)
                comp_e.add(GestureDetector(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                    image: AssetImage("images/hindiass.jpg"),
                                    height: 120,
                                    width: 150))),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                          child: Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        landApi.data.competitiveExams[i]
                                            .subjectName,
                                        style: TextStyle(
                                            fontSize: 17,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: () {},
                                        icon: Icon(Icons.person,
                                            size: 20, color: Colors.grey)),
                                    Text("Name",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: "Candara",
                                            color: Colors.grey))
                                  ],
                                ),
                                Text("\$1234",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Candara",
                                        color: Colors.red))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ));
              for (var i = 0; i < landApi.data.mentors.length; i++)
                mento.add(GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                mentor(landApi.data.mentors[i].id)));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image(
                            image: AssetImage("images/mentor1.PNG"),
                            height: 250,
                            width: 120),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                          child: Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(landApi.data.mentors[i].eduName,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Candara",
                                            color: Colors.black)),
                                    //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Specialisation",
                                        style: TextStyle(
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

              for (var i = 0; i <= 7; i++)
                sci.add(GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => k12_det()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                    image: AssetImage("images/sci.jfif"),
                                    height: 120,
                                    width: 150))),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                          child: Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Course Title",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: "Candara",
                                            color: Colors.black)),
                                    //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                  ],
                                ),
                                Text("22 Chapters",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Candara",
                                        color: Colors.grey)),
                                SizedBox(height: 5),
                                Center(
                                  child: RaisedButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    color: Colors.indigo,
                                    child: (Text("Subscribe",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Candara",
                                            color: Colors.white))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ));
              for (var i = 0; i <= 7; i++)
                hin.add(GestureDetector(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                    image: AssetImage("images/hindiass.jpg"),
                                    height: 120,
                                    width: 150))),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                          child: Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Course Title",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: "Candara",
                                            color: Colors.black)),
                                    //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                  ],
                                ),
                                Text("22 Chapters",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Candara",
                                        color: Colors.grey)),
                                SizedBox(height: 5),
                                Center(
                                  child: RaisedButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    color: Colors.indigo,
                                    child: (Text("Subscribe",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Candara",
                                            color: Colors.white))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ));
              for (var i = 0; i <= 7; i++)
                eng.add(GestureDetector(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                    image: AssetImage("images/sci.jfif"),
                                    height: 120,
                                    width: 150))),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                          child: Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Course Title",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: "Candara",
                                            color: Colors.black)),
                                    //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                  ],
                                ),
                                Text("22 Chapters",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Candara",
                                        color: Colors.grey)),
                                SizedBox(height: 5),
                                Center(
                                  child: RaisedButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    color: Colors.indigo,
                                    child: (Text("Subscribe",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Candara",
                                            color: Colors.white))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ));
              for (var i = 0; i <= 3; i++)
                comp.add(GestureDetector(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                    image: AssetImage("images/hindiass.jpg"),
                                    height: 120,
                                    width: 150))),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                          child: Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Course Title",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: "Candara",
                                            color: Colors.black)),
                                    //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                  ],
                                ),
                                Text("22 Chapters",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Candara",
                                        color: Colors.grey)),
                                SizedBox(height: 5),
                                Center(
                                  child: RaisedButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    color: Colors.indigo,
                                    child: (Text("Subscribe",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "Candara",
                                            color: Colors.white))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ));

              return SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Let's Start Learning",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Candara",
                              color: Colors.teal),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Popular Courses",
                                style: TextStyle(
                                    fontFamily: "Candara",
                                    fontSize: 22,
                                    color: Colors.black)),
                            GestureDetector(
                              child: Text("See all",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.blue,
                                      fontFamily: "Candara")),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            seeallpage("Popular Courses", 1)));
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: pop_c,
                            )),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                    color: Colors.teal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Assessment",
                                style: TextStyle(
                                    fontFamily: "Candara",
                                    fontSize: 22,
                                    color: Colors.white)),
                            GestureDetector(
                              child: Text("See all",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.lightBlueAccent,
                                      fontFamily: "Candara")),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            seeallpage("Assessment", 2)));
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: asses)),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("K12",
                                style: TextStyle(
                                    fontFamily: "Candara",
                                    fontSize: 22,
                                    color: Colors.black)),
                            //GestureDetector(child: Text("See all",style: TextStyle(fontSize: 20,color: Colors.blue,fontFamily: "Candara")))
                          ],
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              GroupButton(
                                  controller: controller,
                                  buttons: [
                                    'Science',
                                    'Hindi',
                                    'English',
                                    'Computer',
                                    'SST'
                                  ],
                                  onSelected: (i, selected) {
                                    if (i == 1) {}
                                  },
                                  selectedTextStyle: const TextStyle(
                                      fontFamily: "Candara",
                                      fontSize: 16,
                                      color: Colors.white),
                                  unselectedTextStyle: const TextStyle(
                                      fontFamily: "Candara",
                                      fontSize: 16,
                                      color: Colors.black),
                                  unselectedColor: Colors.transparent,
                                  selectedColor: Colors.teal,
                                  selectedShadow: const <BoxShadow>[
                                    BoxShadow(color: Colors.transparent)
                                  ],
                                  unselectedShadow: const <BoxShadow>[
                                    BoxShadow(color: Colors.transparent)
                                  ],
                                  borderRadius: BorderRadius.circular(5.0)),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        //ListView.builder(itemBuilder: itemBuilder)
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: k12)),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.teal),
                    padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Competitive Exam",
                                style: TextStyle(
                                    fontFamily: "Candara",
                                    fontSize: 22,
                                    color: Colors.white)),
                            GestureDetector(
                                child: Text("See all",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.lightBlueAccent,
                                        fontFamily: "Candara")),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => seeallpage(
                                              "Competitive Exam", 3)));
                                })
                          ],
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: comp_e)),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("MENTORS",
                                style: TextStyle(
                                    fontFamily: "Candara",
                                    fontSize: 25,
                                    color: Colors.black)),
                            GestureDetector(
                                child: Text("See all",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.lightBlueAccent,
                                        fontFamily: "Candara")),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              seeallpage("Mentors", 4)));
                                })
                          ],
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: mento)),
                        SizedBox(height: 30)
                      ],
                    ),
                  )
                ],
              ));
            } else
              return Container(child: CircularProgressIndicator());
          }),
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.only(left: 25, top: 10),
              child: Text(
                "Hi Aryan!",
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
              color: Colors.white,
              //height: 100,
              padding: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Card(
                color: Colors.white,
                shadowColor: Colors.grey,
                borderOnForeground: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/maths.png')),
                                  SizedBox(height: 5),
                                  Text(
                                    "MATHS",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.5,
                                        fontFamily: "Candara"),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/chemistry.png')),
                                  SizedBox(height: 5),
                                  Text(
                                    "SCIENCE",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.5,
                                        fontFamily: "Candara"),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/hindi.png')),
                                  SizedBox(height: 5),
                                  Text(
                                    "HINDI",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.5,
                                        fontFamily: "Candara"),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/english.png')),
                                  SizedBox(height: 5),
                                  Text(
                                    "ENGLISH",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.5,
                                        fontFamily: "Candara"),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/sst.png')),
                                  SizedBox(height: 5),
                                  Text(
                                    "SST",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.5,
                                        fontFamily: "Candara"),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          AssetImage('images/computer.png')),
                                  SizedBox(height: 5),
                                  Text(
                                    "COMPUTER",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.5,
                                        fontFamily: "Candara"),
                                  )
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
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
        backgroundColor: Colors.teal,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.white70,
          //leading:
          //Icon(Icons.menu, color: Colors.black, size: 30,),
          //centerTitle: true,
          actions: <IconButton>[
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                icon: Icon(Icons.person, color: Colors.white, size: 30))
          ],
          title: Container(
            //height: 40,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //Text("Let's Start Learning",style: TextStyle(fontSize: 25,fontFamily: "Candara" ,color: Colors.white)),
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,

                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Search',
                    labelStyle:
                        TextStyle(fontFamily: "Candara", color: Colors.white),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    //fillColor: Colors.grey,
                    focusColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
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
                  // Update the state of the app
                  // ...
                  // Then close the drawer
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
                  label: 'Dashboard',
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline, size: 30),
                label: 'Favourites',
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
          builder: (context, AsyncSnapshot<LandingApi> snapshot) {
            if (snapshot.hasData) {
              return SafeArea(child: _widgetOptions.elementAt(_selectedIndex));
            } else {
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            }
          },
        ));
  }
}
