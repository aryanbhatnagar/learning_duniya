import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_duniya/sharedPreferences.dart';
import 'Login.dart';
import 'globals.dart';
import 'courses.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'mentor.dart';


var CLASSid;
StuDashboard stuDashboardFromJson(String str) => StuDashboard.fromJson(json.decode(str));
String stuDashboardToJson(StuDashboard data) => json.encode(data.toJson());

class StuDashboard {
  StuDashboard({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  int status;

  factory StuDashboard.fromJson(Map<String, dynamic> json) => StuDashboard(
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
    required this.subjects,
    required this.assessments,
    required this.results,
    required this.mentors,
  });

  List<Subject> subjects;
  List<AssessmentElement> assessments;
  Results results;
  List<Mentor> mentors;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
    assessments: List<AssessmentElement>.from(json["assessments"].map((x) => AssessmentElement.fromJson(x))),
    results: Results.fromJson(json["results"]),
    mentors: List<Mentor>.from(json["mentors"].map((x) => Mentor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
    "assessments": List<dynamic>.from(assessments.map((x) => x.toJson())),
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
class Mentor {
  Mentor({
    required this.id,
    required this.eduName,
    required this.specilization,
    required this.exp,
    required this.img,
  });

  int id;
  String eduName;
  String specilization;
  String exp;
  String img;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
    id: json["id"],
    eduName: json["edu_name"],
    specilization: json["specilization"],
    exp: json["exp"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "edu_name": eduName,
    "specilization": specilization,
    "exp": exp,
    "img": img,
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
class Subject {
  Subject({
    required this.id,
    required this.subjectName,
    required this.icon
  });

  int id;
  String subjectName;
  var icon;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
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

SharedPref s = SharedPref();
class Dashboard extends StatelessWidget {
  //const Dashboard({Key? key}) : super(key: key);

  late String cid;

  Dashboard(this.cid);

  @override
  Widget build(BuildContext context) {
    CLASSid=cid;
    classId=cid;
    return MaterialApp(
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

late String name="";
class _DashboardPageState extends State<DashboardPage> {

  getloginDetails() async {

    }

  int _selectedIndex = 0;
  List<Widget> add = [];



  static List<Widget> _widgetOptions = <Widget>[
    FutureBuilder(
        future: createDash(CLASSid),
        builder: (context,AsyncSnapshot<StuDashboard> snapshot) {
          //print(snapshot.data!.data.toString());
          if (snapshot.hasData)
          {
            print(snapshot.data?.message.toString());
            //LandingApi? landApi=snapshot.data;
            List<bool> isSelected = List.generate(snapshot.data!.data.subjects.length, (index) => false);
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
                            for(var i=0;i<snapshot.data!.data.subjects.length.toInt();i++)
                              GestureDetector(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                        NetworkImage('${snapshot.data!.data.subjects[i].icon.toString()}')),
                                    SizedBox(height: 10),
                                    Text(
                                      "${snapshot.data!.data.subjects[i].subjectName}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: "Candara"),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {},
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: <Widget>[
                          TextButton(
                              onPressed: () {},
                              child: Image.asset("images/ad.png",
                                  height: 100, width: 200)),
                          TextButton(
                              onPressed: () {},
                              child: Image.asset("images/ad.png",
                                  height: 100, width: 200)),
                          TextButton(
                              onPressed: () {},
                              child: Image.asset("images/ad.png",
                                  height: 100, width: 200)),
                          TextButton(
                              onPressed: () {},
                              child:
                              Image.asset("images/ad.png", height: 100, width: 200))
                        ])),
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
                                          child: Text("  ${snapshot.data!.data.results.assessment.total}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: Colors.black,
                                                  fontFamily: "Candara")),
                                        ),
                                        Center(
                                          child: Text("    ${snapshot.data!.data.results.assessment.totalQuestions}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: Colors.black,
                                                  fontFamily: "Candara")),
                                        ),
                                        Center(
                                          child: Text("    ${snapshot.data!.data.results.assessment.correctAnswer}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: Colors.green,
                                                  fontFamily: "Candara")),
                                        ),
                                        Center(
                                          child: Text("${snapshot.data!.data.results.assessment.wrongAnswer}",
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
                                          child: Text("  ${snapshot.data!.data.results.k12.total}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: Colors.black,
                                                  fontFamily: "Candara")),
                                        ),
                                        Center(
                                          child: Text("    ${snapshot.data!.data.results.k12.totalQuestions}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: Colors.black,
                                                  fontFamily: "Candara")),
                                        ),
                                        Center(
                                          child: Text("    ${snapshot.data!.data.results.k12.correctAnswer}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: Colors.green,
                                                  fontFamily: "Candara")),
                                        ),
                                        Center(
                                          child: Text("${snapshot.data!.data.results.k12.wrongAnswer}",
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
                          for(var i=0;i<snapshot.data!.data.mentors.length.toInt();i++)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) =>
                                        mentor(snapshot.data!.data.mentors[i]
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
                                        image: DecorationImage(image: NetworkImage("${snapshot.data!.data.mentors[i].img.toString()}"),fit: BoxFit.fill),
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
                                                Text(snapshot.data!.data.mentors[i].eduName,
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
    ),

    MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: coursepage(),
      ),
    )),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Future<void> _initState() async {
    super.initState();
    getloginDetails();
    build(context);

  }


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: true,
        actions: <Icon>[
          Icon(Icons.notifications, color: Colors.teal, size: 30)
        ],
        title: Text("DASHBOARD",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontFamily: "Candara",
                fontSize: 25)),
      ),
      drawer: Drawer(
          elevation: 5,
          child: ListView(
            // Important: Remove any padding from the ListView.
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ],
          )),
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
              icon: Icon(Icons.assignment_outlined, size: 30),
              label: 'Courses',
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
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}


