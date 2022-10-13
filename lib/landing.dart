import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_duniya/Dashboard.dart';
import 'package:learning_duniya/assessment.dart';
import 'package:learning_duniya/courseDesc.dart';
import 'package:learning_duniya/k12details.dart';
import 'package:learning_duniya/k12subjects.dart';
import 'package:learning_duniya/mentor.dart';
import 'package:learning_duniya/mentor_profile.dart';
import 'package:learning_duniya/navigationScreen.dart';
import 'package:learning_duniya/profile.dart';
import 'package:learning_duniya/quiz.dart';
import 'package:group_button/group_button.dart';
import 'package:learning_duniya/quiz_chall.dart';
import 'package:learning_duniya/screen1%20(1).dart';
import 'package:learning_duniya/challenge_page.dart';
import 'package:learning_duniya/seeall.dart';
import 'package:learning_duniya/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'Login.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'globals.dart';

import 'dart:convert';

var play=0;
PlayLater playLaterFromJson(String str) => PlayLater.fromJson(json.decode(str));
String playLaterToJson(PlayLater data) => json.encode(data.toJson());

class PlayLater {
  PlayLater({
    required this.data7,
    required this.message,
    required this.status,
  });

  Data7 data7;
  var message;
  var status;

  factory PlayLater.fromJson(Map<String, dynamic> json) => PlayLater(
    data7: Data7.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data7.toJson(),
    "message": message,
    "status": status,
  };
}
class Data7 {
  Data7({
    required this.requests,
  });

  Requests requests;

  factory Data7.fromJson(Map<String, dynamic> json) => Data7(
    requests: Requests.fromJson(json["requests"]),
  );

  Map<String, dynamic> toJson() => {
    "requests": requests.toJson(),
  };
}
class Requests {
  Requests({
    this.challengeId,
    this.subjectId,
    this.bookId,
    this.chapterId,
    this.questionTypeId,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  var challengeId;
  var subjectId;
  var bookId;
 var chapterId;
  var questionTypeId;
  var userId;
  var updatedAt;
  var createdAt;
  var id;

  factory Requests.fromJson(Map<String, dynamic> json) => Requests(
    challengeId: json["challenge_id"],
    subjectId: json["subject_id"],
    bookId: json["book_id"],
    chapterId: json["chapter_id"],
    questionTypeId: json["question_type_id"],
    userId: json["user_id"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "challenge_id": challengeId,
    "subject_id": subjectId,
    "book_id": bookId,
    "chapter_id": chapterId,
    "question_type_id": questionTypeId,
    "user_id": userId,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}


Challengerlist challengerlistFromJson(String str) => Challengerlist.fromJson(json.decode(str));
String challengerlistToJson(Challengerlist data) => json.encode(data.toJson());

class Challengerlist {
  Challengerlist({
    required this.data6,
    required this.message,
    required this.status,
  });

  Data6 data6;
  String message;
  int status;

  factory Challengerlist.fromJson(Map<String, dynamic> json) => Challengerlist(
    data6: Data6.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data6.toJson(),
    "message": message,
    "status": status,
  };
}
class Data6 {
  Data6({
    required this.alerts,
  });

  List<Alert> alerts;

  factory Data6.fromJson(Map<String, dynamic> json) => Data6(
    alerts: List<Alert>.from(json["alerts"].map((x) => Alert.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "alerts": List<dynamic>.from(alerts.map((x) => x.toJson())),
  };
}
class Alert {
  Alert({
    this.challengeId,
    this.name,
    this.img,
    this.subjectId,
    this.subjectName,
    this.bookId,
    this.book,
    this.chapterId,
    this.chapter,
    this.questionTypeId,
    this.questionType,
    this.date,
    this.time
  });

  var challengeId;
  var name;
  var img;
 var subjectId;
  var subjectName;
  var bookId;
  var book;
  var chapterId;
  var chapter;
  var questionTypeId;
  var questionType;
  var date;
  var time;

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
    challengeId: json["challenge_id"],
    name: json["name"],
    img: json["img"],
    subjectId: json["subject_id"],
    subjectName: json["subject_name"],
    bookId: json["book_id"],
    book: json["book"],
    chapterId: json["chapter_id"],
    chapter: json["chapter"],
    questionTypeId: json["question_type_id"],
    questionType: json["question_type"],
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "challenge_id": challengeId,
    "name": name,
    "img": img,
    "subject_id": subjectId,
    "subject_name": subjectName,
    "book_id": bookId,
    "book": book,
    "chapter_id": chapterId,
    "chapter": chapter,
    "question_type_id": questionTypeId,
    "question_type": questionType,
    "date" : date,
    "time" : time
  };
}
Future<Challengerlist> getChalList() async {

  final String apiUrl = "${BASE}api/student/challenge/play_later/list";
  final response = await http.get(Uri.parse(apiUrl),headers: <String, String>{
    "Authorization": "Bearer $token",
    "Content-Type" : "application/json"
  });

  if (response.statusCode == 200) {
    debugPrint("hello");
    final String responseString = response.body;
    return challengerlistFromJson(responseString);
  }
  else {
    throw Exception('Failed to load album');
  }
}

var LOGOUT=0;
Future<dynamic> getLogout() async {

  final String apiUrl = "${BASE}api/logout";
  final response = await http.get(Uri.parse(apiUrl),headers: <String, String>{
    "Authorization": "Bearer $token",
    "Content-Type" : "application/json"
  });

  if (response.statusCode == 200) {
    LOGOUT=200;
    debugPrint("hello");
    final String responseString = response.body;
    return 200;
  }
  else {
    throw Exception('Failed to load album');
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.',
    // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
  print('A bg message just showed up :  ${message.messageId}');
}

Future<K12Card> getMentorApi(String cls, String sub) async {
  final String apiUrl =
      "${BASE}api/getk12";
  final response = await http.post(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  }, body: {"class_id": cls, "subject_id": sub});

  if (response.statusCode == 200) {
    print(response.statusCode.toString());
    final String responseString = response.body;
    debugPrint(response.body);
    return k12CardFromJson(responseString);
  } else {
    throw Exception('Failed to load album');
  }
}

Future<PlayLater> PlayLaterApi(String cls) async {
  final String apiUrl =
      "${BASE}api/student/challenge/play_later";
  final response = await http.post(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  }, body:
  {
    "challenge_id" : cls
  });

  if (response.statusCode == 200) {
    play=200;
    final String responseString = response.body;
    debugPrint(response.body);
    return playLaterFromJson(responseString);
  } else {
    throw Exception('Failed to load album');
  }
}

var mentorDataMap = <String, dynamic>{};
var Mcode=0;
bool formvis=true;


Future<void> _logout() async {
  /*final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('role');
  prefs.remove('token');*/
  SharedPreferences.getInstance().then(
        (prefs) {
      prefs.remove("is_logged_in");
      prefs.remove("token");
      prefs.remove("role");
      prefs.clear();
    },
  );

}

Studentdp studentdpFromJson(String str) => Studentdp.fromJson(json.decode(str));
String studentdpToJson(Studentdp data4) => json.encode(data4.toJson());
class Studentdp {
  Studentdp({
    required this.data4,
    required this.status,
  });

  Data4 data4;
  var status;

  factory Studentdp.fromJson(Map<String, dynamic> json) => Studentdp(
    data4: Data4.fromJson(json["data"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data4.toJson(),
    "status": status,
  };
}
class Data4 {
  Data4({
    required this.id,
    required this.name,
    required this.email,
    required this.contactNo,
    required this.img,
    required this.registerRegion,
    required this.registerCity,
    required this.role,
    required this.school,
    required this.isOnline,
    required this.classId,
  });

  var id;
  var name;
  var email;
  var contactNo;
  var img;
  dynamic registerRegion;
  var registerCity;
  var role;
  var school;
  var isOnline;
  var classId;

  factory Data4.fromJson(Map<String, dynamic> json) => Data4(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    contactNo: json["contact_no"],
    img: json["img"],
    registerRegion: json["register_region"],
    registerCity: json["register_city"],
    role: json["role"],
    school: json["school"],
    isOnline: json["is_online"],
    classId: json["class_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "contact_no": contactNo,
    "img": img,
    "register_region": registerRegion,
    "register_city": registerCity,
    "role": role,
    "school": school,
    "is_online": isOnline,
    "class_id": classId,
  };
}


Future<Studentdp> getProfileApi() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  final String apiUrl =
      "${BASE}api/profile";
  final response = await http.get(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  });

  if (response.statusCode == 200) {
    print(response.statusCode.toString());
    final String responseString = response.body;
    debugPrint(response.body);
    return studentdpFromJson(responseString);
  } else {
    throw Exception('Failed to load album');
  }
}

Future createStuDp(Map mentorData, File image) async {
  int responseCode;
  Map<String, String> headers = {"Authorization": "Bearer $token"};
  String apiUrl =
      "${BASE}api/profile";
  var uri = Uri.parse(apiUrl);

  var request = http.MultipartRequest("POST", uri);
  request.headers.addAll(headers);

  http.MultipartFile multipartFile =
  await http.MultipartFile.fromPath('img', image.path);
  request.files.add(multipartFile);
  request.fields["school"] = mentorData['school'];
  request.fields["city"] = mentorData['city'];


  // listen for response
  http.Response response = await http.Response.fromStream(await request.send());
  print("Result: ${response.statusCode}");
  //return response.body;

  if (response.statusCode == 200) {
    Mcode=200;
    final String responseString = response.body;
    debugPrint(responseString.toString());
    //debugPrint(response.stream..toString());
    return studentdpFromJson(responseString);

  }
  if (response.statusCode == 404) {
    return throw Exception("failed");
  }

}


var CLASSid;
//dynamic imageTemp;
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
    required this.user,
    required this.assessments1,
    required this.results,
    required this.experience,
    required this.mentors,
  });

  List<Subject2> subjects2;
  User user;
  List<AssessmentElement> assessments1;
  Results results;
  var experience;
  List<Mentor1> mentors;

  factory Data3.fromJson(Map<String, dynamic> json) => Data3(
    user: User.fromJson(json["user"]),
    subjects2: List<Subject2>.from(json["subjects"].map((x) => Subject2.fromJson(x))),
    assessments1: List<AssessmentElement>.from(json["assessments"].map((x) => AssessmentElement.fromJson(x))),
    results: Results.fromJson(json["results"]),
    experience: json["exp"],
    mentors: List<Mentor1>.from(json["mentors"].map((x) => Mentor1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "subjects": List<dynamic>.from(subjects2.map((x) => x.toJson())),
    "assessments": List<dynamic>.from(assessments1.map((x) => x.toJson())),
    "results": results.toJson(),
    "exp" : experience,
    "mentors": List<dynamic>.from(mentors.map((x) => x.toJson())),
  };
}
class User {
  User({
    this.name,
    this.email,
    this.img,
    this.role,
  });

  var name;
  var email;
  var img;
  var role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    img: json["img"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "img": img,
    "role": role,
  };
}
class Mentor1 {
  Mentor1({
    required this.id,
    required this.eduName,
    required this.img,
    required this.specilization
  });

  int id;
  String eduName;
  String img;
  var specilization;

  factory Mentor1.fromJson(Map<String, dynamic> json) => Mentor1(
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
      "${BASE}api/mentee/dashboard";

  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String> {
        "Authorization": "Bearer $token",
      },
      body: {
        "class_name": id
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
    required this.classname,
    required this.subjectname,
    required this.mcqcount,
    required this.totalvideos
  });

  int id;
  var chapter;
  String courseName;
  String img;
  var classname;
  var subjectname;
  var mcqcount;
  var totalvideos;


  factory K12_c.fromJson(Map<String, dynamic> json) => K12_c(
    id: json["id"],
    courseName: json["course_name"],
    img: json["img"],
    chapter : json["chapter"],
    classname: json["class_name"],
    subjectname: json["subject_name"],
    mcqcount: json["mcq_count"],
    totalvideos: json["total_video"]

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_name": courseName,
    "img": img,
    "chapter": chapter,
    "class_name": classname,
    "subject_name": subjectname,
    "mcq_count": mcqcount,
    "total_video": totalvideos
  };
}
Future<K12Card> createK12card(String id) async {
  final String apiUrl =
      "${BASE}api/getk12";

  final response = await http.post(Uri.parse(apiUrl),
      body: {
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

  final String apiUrl = "${BASE}api/dashboard";
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

  final _firebaseMessaging = FirebaseMessaging.instance.getInitialMessage();
  void getMessage(BuildContext context) {
    print("dkfjkdfjkdfjdfdfd :::::::::::::::::::::::::::");
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      RemoteNotification notification = event.notification!;

      print(":::::::::::::::::::::::::::: $notification");

      // AppleNotification apple = event.notification!.apple!;
      AndroidNotification androidNotification = event.notification!.android!;

      if (notification != null && androidNotification != null) {

        ///Show local notification
        sendNotification(title: notification.title!, body: notification.body);

        ///Show Alert dialog
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(notification.title!),
                content: Text(notification.body!),
              );
            });
      }
    });
  }

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
  final schoolController = TextEditingController();
  final cityController = TextEditingController();



  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }
  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  Future<void> _onItemTapped(int index) async {
    if(index==1 || index==2)
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
    if((index==1 || index==2) && classId!="")
      indexSelect(index);
    else
      indexSelect(index);
  }

  int _counter = 0;

  @override
  void initState()   {
    super.initState();
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        debugPrint(notification.body);
        BuildContext dialogContext;
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body.toString().split("--")[0].toString(),
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: 'images/Learning_Duniya_logo.png',
              ),
            ));
        showDialog(
            context: context,
            builder: (BuildContext context) {

              dialogContext=context;
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  //title: Text('Challenge'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  title: Image.asset(
                    'images/Learning_Duniya_logo.png',
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
                              "${notification.title.toString()}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Candara',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${notification.body.toString().split("--")[0]}",
                              style: TextStyle(
                                fontFamily: 'Candara',
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.deepOrange)),
                            child: Text(
                              'NOT NOW',
                              style: TextStyle(
                                fontFamily: 'Candara',
                              ),
                            ),
                            onPressed: () async {

                              PlayLater _play = await PlayLaterApi(notification.body.toString().split("--")[1]);
                              PlayLater plays;
                              setState(() {
                                plays=_play;
                              });
                              if(play==200){
                                Navigator.pop(context);
                                play==0;
                               }
                            },
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.teal)),
                            child: Text(
                              'PLAY',
                              style: TextStyle(
                                fontFamily: 'Candara',
                              ),
                            ),
                            onPressed: () {
                              var chapd=notification.body.toString().split("--")[1].split("-")[2].toString();
                              var qtd=notification.body.toString().split("--")[1].split("-")[3].toString();
                              var challd=notification.body.toString().split("--")[1];
                              var opponame=notification.body.toString().split("--")[2];
                              var oppoimg=notification.body.toString().split("--")[3];
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  quiz_challenge(chapd,qtd,challd,opponame,"http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/uploads/${oppoimg}")));

                            },
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              );
            });

      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,badge: true,sound: true);
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        BuildContext dialogContext;
        showDialog(
            context: context,
            builder: (BuildContext context) {

              dialogContext=context;
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  //title: Text('Challenge'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  title: Image.asset(
                    'images/Learning_Duniya_logo.png',
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
                              "${notification.title.toString()}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Candara',
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${notification.body.toString().split("--")[0]}",
                              style: TextStyle(
                                fontFamily: 'Candara',
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.deepOrange)),
                            child: Text(
                              'NOT NOW',
                              style: TextStyle(
                                fontFamily: 'Candara',
                              ),
                            ),
                            onPressed: () async {

                                PlayLater _play = await PlayLaterApi(notification.body.toString().split("--")[1]);
                              PlayLater plays;
                              setState(() {
                                plays=_play;
                              });
                              if(play==200){
                              Navigator.pop(context);
                              play==0;

                              }
                            },
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.teal)),
                            child: Text(
                              'PLAY',
                              style: TextStyle(
                                fontFamily: 'Candara',
                              ),
                            ),
                            onPressed: () {
                              var chapd=notification.body.toString().split("--")[1].split("-")[2].toString();
                              var qtd=notification.body.toString().split("--")[1].split("-")[3].toString();
                              var challd=notification.body.toString().split("--")[1];
                              var opponame=notification.body.toString().split("--")[2];
                              var oppoimg=notification.body.toString().split("--")[3];
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                  quiz_challenge(chapd,qtd,challd,opponame,"http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/uploads/${oppoimg}")));

                            },
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              );
            });
      }
    });

  }

  void sendNotification({String? title, String? body}) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    ////Set the settings for various platform
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(
      defaultActionName: 'hello',
    );
    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    ///
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_channel', 'High Importance Notification',
        description: "This channel is for important notification",
        importance: Importance.max);

    flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: channel.description),
      ),
    );
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: 'images/Learning_Duniya_logo.png')));
  }



  @override
  Widget build(BuildContext context) {
    var ass_vis=true;
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
                      Navigator.pushReplacement(
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
                        if(token!="")
                          FutureBuilder(
                            future: getProfileApi(),
                            builder: (context, AsyncSnapshot<Studentdp> snapshot8) {
                              if(snapshot8.hasData){
                              userName=snapshot8.data!.data4.name.toString();
                              userImg=snapshot8.data!.data4.img.toString();
                              schools=snapshot8.data!.data4.school.toString();
                              var im=0;
                              if(snapshot8.data!.data4.img=="http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/uploads/no-image.jpeg")
                                im=0;
                              else
                                im=1;
                              return Container(
                              );}
                              else
                                return Center(child: CircularProgressIndicator());

                            }

                        ),
                        if(snapshot.data!.data.popularCourses.isNotEmpty)
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
                        if(snapshot.data!.data.assessments.isNotEmpty)
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
                                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                                        builder: (context) => k12_det(k12_obj!.data1.k12[i].id.toString(),"")));
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
                                                            //height: 95,
                                                            width: 150,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment
                                                                      .spaceBetween,
                                                                  children: [
                                                                    Flexible(
                                                                      child: Text(" ${k12_obj!.data1.k12[i].courseName}\n",
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
                                                                SizedBox(height: 12),
                                                                Row(
                                                                  children: [
                                                                    Icon(Icons.menu_book,size: 12,color: Colors.grey),
                                                                    Text(" ${k12_obj.data1.k12[i].chapter.toString()} Chapters", style: TextStyle(
                                                                        fontSize: 12,
                                                                        fontFamily: "Candara",
                                                                        color: Colors
                                                                            .grey)),



                                                                  ],
                                                                ),
                                                                SizedBox(height: 4),
                                                                Row(children: <Widget>[
                                                                  Icon(Icons.play_arrow,size: 14,color: Colors.grey),
                                                                  Text(" ${k12_obj.data1.k12[i].totalvideos.toString()} Videos", style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontFamily: "Candara",
                                                                      color: Colors
                                                                          .grey)),
                                                                  SizedBox(width: 4,),
                                                                  Row(children: <Widget>[
                                                                    Icon(Icons.pending_actions,size: 12,color: Colors.grey),
                                                                    Text(" ${k12_obj.data1.k12[i].mcqcount.toString()} MCQ's", style: TextStyle(
                                                                        fontSize: 12,
                                                                        fontFamily: "Candara",
                                                                        color: Colors
                                                                            .grey)),
                                                                  ],),

                                                                ],),

                                                                SizedBox(height: 10),
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
                        if(snapshot.data!.data.competitiveExams.isNotEmpty)
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
                        if(snapshot.data!.data.mentors.isNotEmpty)
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
                              SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                      children: mento
                                  )
                              ),
                              SizedBox(height: 10,),
                              if(token=="")
                                ElevatedButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>mentorProfile()));
                                },
                                  child: Text("Become a mentor"),),
                              SizedBox(height: 15)
                            ],
                          ),
                        )
                      ],
                    )
                ),
              );
            }
            else
              return Center(child: Container(child: CircularProgressIndicator()));
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
                Center(child: Text("Please login to view Dashboard", style: TextStyle(
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
                          Row(
                            children: [
                              SizedBox(width: 25,),
                              CircleAvatar(
                                  backgroundColor: Colors.deepPurple,
                                  radius: 20,
                                  backgroundImage: NetworkImage("${snapshot.data!.data2.user.img.toString()}")
                                /*child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(25),
                                            child: image != null
                                                ? Image.file(image!)
                                                : Image.asset('images/mentorProfile.jpeg'),
                                          ),
                                        ),*/
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Text(
                                      'Hi ${snapshot.data!.data2.user.name.toString().toUpperCase()}',
                                      style: TextStyle(
                                          fontSize: 17.5, color: Colors.black, fontFamily: "Candara"),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10, bottom: 10),
                                    child: Text(
                                      "Choose your courses",
                                      style: TextStyle(
                                          fontFamily: "Candara", fontSize: 12.5, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                                        onTap:() async {
                                          //Navigator.push(context, MaterialPageRoute(builder: (context) => k12Subject1(snapshot.data!.data2.subjects2[i].id.toString(),snapshot.data!.data2.subjects2[i].subjectName.toString())));
                                          Future<SubjectAction?> action =
                                              await _asyncSubjectDialog(
                                              context,
                                              'Mentor Name',
                                                  snapshot.data!.data2.subjects2[i].id.toString(),
                                              'Communication',
                                              [],
                                              'None');
                                          /*Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => k12_det(snapshot.data!.data2.subjects2[i].id.toString(),"images/english.png")));*/

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
                          if(snapshot.data!.data2.assessments1.length>0)
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
                          if(snapshot.data!.data2.results.assessment.total.toString()!="0" || snapshot.data!.data2.results.k12.total.toString()!="0")
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
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => navigationScreenPage()));
                                  },
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
                                  if(snapshot.data!.data2.results.assessment.total.toString()!="0")
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
                                              onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => screen1()));
                                              },
                                              child: Text('Analyze your Performance',
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
                                  if(snapshot.data!.data2.results.k12.total.toString()!="0")
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
                    return Center(child: Container(child: CircularProgressIndicator()));
                }
            );
        },
      ),
      FutureBuilder(
        future: getLanding(),
        builder: (context,AsyncSnapshot<LandingApi> snapshot1) {
          if (token=="")
            return Column(
              children: [
                SizedBox(height: 40),
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("images/challenge.png"),fit: BoxFit.fill),
                  ),
                ),
                SizedBox(height: 20,),
                Center(child: Text("Please login to challenge others", style: TextStyle(
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
            return Scaffold(body: challenge_page(),);
        },
      ),
      FutureBuilder(
        future: getLanding(),
        builder: (context,AsyncSnapshot<LandingApi> snapshot1) {
          if (token=="")
            return Column(
              children: [
                SizedBox(height: 40),
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("images/notificationno.png"),fit: BoxFit.fill),
                  ),
                ),
                SizedBox(height: 20,),
                Center(child: Text("No new notification!!", style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Candara",
                    color: Colors.teal),),),
                SizedBox(height: 15,),
              ],
            );
          else
            return FutureBuilder(
                future: getChalList(),
                builder: (context,AsyncSnapshot<Challengerlist> snapshot3 ){
                  debugPrint(snapshot3.toString());
                  if(snapshot3.hasData)
                    return Scaffold(
                      body: Container(
                        padding: EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              for (var i=0;i<snapshot3.data!.data6.alerts.length;i++)
                                GestureDetector(
                                onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      quiz_challenge(snapshot3.data!.data6.alerts[i].chapterId.toString(),
                                          snapshot3.data!.data6.alerts[i].questionTypeId.toString(),
                                      snapshot3.data!.data6.alerts[i].challengeId.toString(),
                                      snapshot3.data!.data6.alerts[i].name.toString(),
                                      snapshot3.data!.data6.alerts[i].img.toString())));
                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Center(
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage("${snapshot3.data!.data6.alerts[i].img.toString()}"),
                                                radius: 35,
                                              ),
                                            ),
                                            SizedBox(width: 20,),

                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${snapshot3.data!.data6.alerts[i].name.toString()}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Candara',
                                                fontSize: 15,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text("${snapshot3.data!.data6.alerts[i].date}",style: TextStyle(fontFamily: "Candara",fontSize: 11,color: Colors.grey),overflow: TextOverflow.ellipsis,maxLines: 2),
                                                Text("  ${snapshot3.data!.data6.alerts[i].time}",style: TextStyle(fontFamily: "Candara",fontSize: 11,color: Colors.grey),overflow: TextOverflow.ellipsis,maxLines: 2),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text("CHALLENGED YOU FOR A QUIZ",style: TextStyle(fontFamily: "Candara",fontSize: 10,color: Colors.red),overflow: TextOverflow.ellipsis,maxLines: 2),
                                            Text("Subject : ${snapshot3.data!.data6.alerts[i].subjectName}",style: TextStyle(fontFamily: "Candara",fontSize: 11,),overflow: TextOverflow.ellipsis,maxLines: 2),
                                            Text("Chapter : ${snapshot3.data!.data6.alerts[i].chapter}",style: TextStyle(fontFamily: "Candara",fontSize: 11,),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                            Text("Type :  ${snapshot3.data!.data6.alerts[i].questionType}",style: TextStyle(fontFamily: "Candara",fontSize: 11,),overflow: TextOverflow.ellipsis,maxLines: 2,),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ));
                  else
                    return Column(
                      children: [
                        SizedBox(height: 40),
                        Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("images/notificationno.png"),fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(child: Text("No new notification!!", style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Candara",
                            color: Colors.teal),),),
                        SizedBox(height: 15,),
                      ],
                    );
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
                DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(token!="")
                      FutureBuilder(
                        future: getProfileApi(),
                        builder: (context, AsyncSnapshot<Studentdp> snapshot) {
                          userName=snapshot.data!.data4.name.toString();
                          userImg=snapshot.data!.data4.img.toString();
                          schools=snapshot.data!.data4.school.toString();
                          var im=0;
                          if(snapshot.data!.data4.img=="${BASE}uploads/no-image.jpeg")
                            im=0;
                          else
                            im=1;
                          return Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if(im==0)
                                  GestureDetector(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.deepPurple,
                                      radius: 60,
                                      backgroundImage: image!= null
                                          ? FileImage(image!)
                                          : AssetImage('images/mentorProfile.jpeg')
                                      as ImageProvider,
                                      /*child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(25),
                                            child: image != null
                                                ? Image.file(image!)
                                                : Image.asset('images/mentorProfile.jpeg'),
                                          ),
                                        ),*/
                                    ),
                                    onTap: () {
                                      //pickImage();
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Center(
                                                  child: Text('Select Image',
                                                      style:
                                                      TextStyle(fontFamily: 'Candara'))),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: <Widget>[
                                                    ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                            MaterialStateProperty.all<
                                                                Color>(Colors.deepPurple),
                                                            shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        10),
                                                                    side: BorderSide(
                                                                        color: Colors
                                                                            .deepPurple)))),
                                                        onPressed: () {
                                                          pickImage();
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Wrap(
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.image,
                                                              color: Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text('Gallery',
                                                                style: TextStyle(
                                                                    fontFamily: 'Candara',
                                                                    fontSize: 18))
                                                          ],
                                                        )),
                                                    ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                            MaterialStateProperty.all<
                                                                Color>(Colors.deepPurple),
                                                            shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        10),
                                                                    side: BorderSide(
                                                                        color: Colors
                                                                            .deepPurple)))),
                                                        onPressed: () {
                                                          pickImageCamera();
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Wrap(
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.camera,
                                                              color: Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text('Camera',
                                                                style: TextStyle(
                                                                    fontFamily: 'Candara',
                                                                    fontSize: 18))
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                if(im==1)
                                  CircleAvatar(
                                  backgroundColor: Colors.deepPurple,
                                  radius: 50,
                                  backgroundImage: NetworkImage("${snapshot.data!.data4.img.toString()}")
                                  /*child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(25),
                                            child: image != null
                                                ? Image.file(image!)
                                                : Image.asset('images/mentorProfile.jpeg'),
                                          ),
                                        ),*/
                                ),
                                if(im==1)
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text("${snapshot.data!.data4.name} | ${snapshot.data!.data4.school}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.blueGrey),),
                                  )

                              ],
                            ),
                          );

    }

                    ),
                    if(token=="")
                      FutureBuilder(
                          builder: (context, AsyncSnapshot snapshot) {

                            return CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                                radius: 60,
                                backgroundImage: AssetImage('images/mentorProfile.jpeg')

                              /*child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(25),
                                            child: image != null
                                                ? Image.file(image!)
                                                : Image.asset('images/mentorProfile.jpeg'),
                                          ),
                                        ),*/
                            );

                          }

                      ),

                  ],
                ),
              ),
                Visibility(
                  visible: formvis,
                  child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  //height: Wrap(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(image!=null)
                        SizedBox(
                          height: 5,
                        ),
                      if(image!=null)
                        Text(
                          'School Name',
                          style: TextStyle(fontFamily: 'Candara'),
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      if(image!=null)
                        TextFormField(
                          controller: schoolController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'School',
                            hintStyle: TextStyle(fontFamily: 'Candara'),
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      if(image!=null)
                        Text(
                          'City',
                          style: TextStyle(fontFamily: 'Candara'),
                        ),
                      SizedBox(
                        height: 5,
                      ),
                      if(image!=null)
                        TextFormField(
                          controller: cityController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'City',
                            hintStyle: TextStyle(fontFamily: 'Candara'),
                          ),
                        ),
                      if(image!=null)
                        Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.deepPurple),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Colors.deepPurple)))),
                            onPressed: () async {
                              if (cityController.text.isEmpty ||
                                  schoolController.text.isEmpty ) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Error'),
                                        content: Text('Please fill all the fields'),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            child: Text('Ok'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    });
                              } else  {

                                mentorDataMap['img'] = image;
                                mentorDataMap['school'] = schoolController.text;
                                mentorDataMap['city'] = cityController.text;
                                debugPrint(mentorDataMap.toString());

                                if(image!=null){
                                  Studentdp s =await createStuDp(mentorDataMap, image!);
                                  debugPrint(s.toString());
                                  if(Mcode==200)
                                    {
                                      showDialog(
                                        barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Thank you'),
                                              content: Text('Profile Updated Successfully'),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  child: Text('Close'),
                                                  onPressed: () {
                                                    setState(() {
                                                      formvis=false;
                                                    });
                                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>landing()));
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                    }

                                }
                                else
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: Text('Please enter an image'),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              child: Text('Close'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            )
                                          ],
                                        );
                                      });
                              }
                            },
                            child: Text(
                              'UPDATE PROFILE',
                              style: TextStyle(
                                  fontFamily: 'Candara',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )),
                        ),
                    ],
                  ),
              ),
                ),
              if(token!="")
                ListTile(
                title: const Text('Profile'),
                onTap: () async {

                  Navigator.pop(context);
                },
              ),
              if(token!="")
                ListTile(
                title: const Text('Logout'),
                onTap: () async {
                  var x= await getLogout();
                  if (x==200){
                    print("heelo");
                  await _logout();
                  setState(()  {
                    userName = "";
                    userEmail = "";
                    userId = 0;
                    token = "";
                    classId="";
                  });
                  Navigator.pop(context);
                }}
              ),
              if(token=="")
                ListTile(
                  title: const Text('Login'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Login()));
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
                  Icons.book,
                  size: 30,
                ),
                label: 'Challenge',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_active_outlined, size: 30),
                  label: 'Alerts'),
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
String _dropDownValue="";
enum ConfirmAction { Confirm, Cancel }
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
      String _currentSelectedVakue='';


      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
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

                    FormField<String>(
                      builder: (FormFieldState<String> state) {
                        String _currentSelectedValue='';
                        return Container(
                          height: 60,
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              //labelText: 'CLASS',
                                prefixIcon: Icon(Icons.school,color: Colors.teal),
                                labelStyle: TextStyle(fontFamily: "Candara"),
                                errorStyle: TextStyle(fontFamily:"Candara",color: Colors.redAccent, fontSize: 16.0),
                                //hintText: 'Please select expense',
                                enabledBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(5)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.teal,width: 2.0),
                                    borderRadius: BorderRadius.circular(5)
                                )),
                                //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                            isEmpty: _currentSelectedValue == '',
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                menuMaxHeight: 200,
                                hint: _dropDownValue == null
                                    ? Text('Dropdown')
                                    : Text(
                                  _dropDownValue,
                                  style: TextStyle(fontFamily: "Candara",color: Colors.black,fontSize: 16),
                                ),
                                isExpanded: false,
                                iconSize: 30.0,
                                style: TextStyle(color: Colors.black),
                                items: ["LKG","UKG","1", "2","3", "4","5", "6","7", "8","9", "10","11", "12"].map(
                                      (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String? val) {
                                  _dropDownValue = val!;
                                  (context as Element).markNeedsBuild();

                                },
                              )
                            ),
                          ),
                        );
                      },
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
                  SizedBox(width: 10),
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
                      print(_dropDownValue);
                      if(_dropDownValue!="")
                      {
                        classId=_dropDownValue;
                        if(classId!="")
                        {
                          //Navigator.of(context).pop(ConfirmAction.Confirm);
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
        ),
      );
    },
  );
}

enum SubjectAction { Confirm }
Future<Future<SubjectAction?>> _asyncSubjectDialog(
    BuildContext context,
    String userName,
    String SubjectID,
    String modeOfC,
    List<String> selected,
    String comments) async {
  return showDialog<SubjectAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      String _currentSelectedVakue='';


      return AlertDialog(
        //title: Text('Delete This Contact?'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Text("Book List"),
        content: Container(
          width: double.infinity,
          //height: Wrap(),
          child: FutureBuilder(
            future: getMentorApi(classId.toString(), SubjectID),
            builder: (context, AsyncSnapshot<K12Card> snapshot) {
              if(snapshot.hasData){
                if(snapshot.data!.data1.k12.length>0)
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for(var i=0;i<snapshot.data!.data1.k12.length;i++)
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,10,0,0),
                                  child: GestureDetector(
                                    onTap:(){
                                      Navigator.of(context).pop(SubjectAction.Confirm);
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => k12_det(snapshot.data!.data1.k12[i].id.toString(),"images/english.png")));

                                      /*Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) => k12_det(snapshot.data!.data2.subjects2[i].id.toString(),"images/english.png")));*/

                                    },
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                              radius: 45,
                                              backgroundImage:
                                              NetworkImage('${snapshot.data!.data1.k12[i].img.toString()}')),
                                          SizedBox(height: 10),
                                          Text(
                                            "${snapshot.data!.data1.k12[i].courseName}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: "Candara"),
                                          )
                                        ],
                                      ),
                                    ),

                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                  );
                else
                  return Center(child: Container(
                      child: Text("No books for this subject",style: TextStyle(fontFamily: "Candara",fontSize: 20),)),);
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
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
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'Candara',
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(SubjectAction.Confirm);
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

