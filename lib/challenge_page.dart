import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_duniya/globals.dart';
import 'package:learning_duniya/quiz_chall.dart';

SendInvite sendInviteFromJson(String str) =>
    SendInvite.fromJson(json.decode(str));


String sendInviteToJson(SendInvite data) => json.encode(data.toJson());
late SendInvite? _inv =null;
int invitecode=0;
class SendInvite {
  SendInvite({
    required this.data6,
    required this.message,
    required this.status,
  });

  Data6 data6;
  String message;
  int status;

  factory SendInvite.fromJson(Map<String, dynamic> json) => SendInvite(
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
    this.requests,
  });

  dynamic requests;

  factory Data6.fromJson(Map<String, dynamic> json) => Data6(
        requests: json["requests"],
      );

  Map<String, dynamic> toJson() => {
        "requests": requests,
      };
}

Future<SendInvite> createInvite(String stu_id,String sub_id,String book_id,String chap_id,String qt_id) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/student/challenge/invite";

  final response = await http.post(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  }, body: {
    "student_id": stu_id,
    "subject_id": sub_id,
    "book_id": book_id,
    "chapter_id": chap_id,
    "question_type_id": qt_id
  });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    invitecode=200;
    debugPrint(responseString);
    return sendInviteFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

Livestudents livestudentsFromJson(String str) =>
    Livestudents.fromJson(json.decode(str));
String livestudentsToJson(Livestudents data) => json.encode(data.toJson());

class Livestudents {
  Livestudents({
    required this.data1,
    required this.message,
    required this.status,
  });

  Data1 data1;
  String message;
  var status;

  factory Livestudents.fromJson(Map<String, dynamic> json) => Livestudents(
        data1: Data1.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data1.toJson(),
        "message": message,
        "status": status,
      };
}

class Data1 {
  Data1({
    required this.student,
    required this.subjects,
  });

  List<Student> student;
  List<Subject> subjects;

  factory Data1.fromJson(Map<String, dynamic> json) => Data1(
        student:
            List<Student>.from(json["student"].map((x) => Student.fromJson(x))),
        subjects: List<Subject>.from(
            json["subjects"].map((x) => Subject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "student": List<dynamic>.from(student.map((x) => x.toJson())),
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
      };
}

class Student {
  Student({
    this.id,
    this.name,
    this.email,
    this.contactNo,
    this.emailVerifiedAt,
    this.img,
    this.preference,
    this.registerFrom,
    this.registerRegion,
    this.registerCity,
    this.role,
    this.school,
    this.isOnline,
    this.classId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  var name;
  var email;
  var contactNo;
  dynamic emailVerifiedAt;
  var img;
  dynamic preference;
  dynamic registerFrom;
  dynamic registerRegion;
  var registerCity;
  var role;
  var school;
  var isOnline;
  var classId;
  var status;
  var createdAt;
  var updatedAt;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        contactNo: json["contact_no"],
        emailVerifiedAt: json["email_verified_at"],
        img: json["img"],
        preference: json["preference"],
        registerFrom: json["register_from"],
        registerRegion: json["register_region"],
        registerCity: json["register_city"],
        role: json["role"],
        school: json["school"],
        isOnline: json["is_online"],
        classId: json["class_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "contact_no": contactNo == null ? null : contactNo,
        "email_verified_at": emailVerifiedAt,
        "img": img,
        "preference": preference,
        "register_from": registerFrom,
        "register_region": registerRegion,
        "register_city": registerCity,
        "role": role,
        "school": school,
        "is_online": isOnline,
        "class_id": classId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Subject {
  Subject({
    this.id,
    this.subjectName,
    this.icon,
  });

  var id;
  var subjectName;
  var icon;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        subjectName: json["subject_name"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject_name": subjectName,
        "icon": icon,
      };
}

Future<Livestudents> createLiveStudents(String id) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/student/live";

  final response = await http.post(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  }, body: {
    "class_id": id
  });

  if (response.statusCode == 200) {
    final String responseString = response.body;
    debugPrint(responseString);
    return livestudentsFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

Future<K12Card> getLiveSubjects(String cls, String sub) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/getk12";
  final response = await http.post(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  }, body: {
    "class_id": cls,
    "subject_id": sub
  });

  if (response.statusCode == 200) {
    print(response.statusCode.toString());
    final String responseString = response.body;
    debugPrint(response.body);
    return k12CardFromJson(responseString);
  } else {
    throw Exception('Failed to load album');
  }
}

K12Card k12CardFromJson(String str) => K12Card.fromJson(json.decode(str));
String k12CardToJson(K12Card data) => json.encode(data.toJson());

class K12Card {
  K12Card({
    required this.success,
    required this.data2,
    required this.message,
  });

  bool success;
  Data2 data2;
  String message;

  factory K12Card.fromJson(Map<String, dynamic> json) => K12Card(
        success: json["success"],
        data2: Data2.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data2.toJson(),
        "message": message,
      };
}

class Data2 {
  Data2({
    required this.k12,
  });

  List<K12_c> k12;

  factory Data2.fromJson(Map<String, dynamic> json) => Data2(
        k12: List<K12_c>.from(json["k12"].map((x) => K12_c.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "k12": List<dynamic>.from(k12.map((x) => x.toJson())),
      };
}

class K12_c {
  K12_c(
      {required this.id,
      required this.courseName,
      required this.img,
      required this.chapter,
      required this.classname,
      required this.subjectname,
      required this.mcqcount,
      required this.totalvideos});

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
      chapter: json["chapter"],
      classname: json["class_name"],
      subjectname: json["subject_name"],
      mcqcount: json["mcq_count"],
      totalvideos: json["total_video"]);

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

K12Api k12ApiFromJson(String str) => K12Api.fromJson(json.decode(str));
String k12ApiToJson(K12Api data) => json.encode(data.toJson());

class K12Api {
  K12Api({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  var message;

  factory K12Api.fromJson(Map<String, dynamic> json) => K12Api(
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
    required this.k12,
    required this.k12Details,
  });

  K12 k12;
  List<K12Detail> k12Details;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        k12: K12.fromJson(json["k12"]),
        k12Details: List<K12Detail>.from(
            json["k12_details"].map((x) => K12Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "k12": k12.toJson(),
        "k12_details": List<dynamic>.from(k12Details.map((x) => x.toJson())),
      };
}

class K12 {
  K12({
    required this.img,
    required this.courseName,
    required this.formalName,
    required this.syllabus,
    required this.description,
    required this.lifespan,
    required this.language,
    required this.price,
    required this.salePrice,
    required this.classname,
    required this.subjectname,
    required this.mcqcount,
    required this.totalvideos,
    required this.visitor,
    required this.likes,
  });

  var img;
  var courseName;
  var formalName;
  var syllabus;
  var description;
  var lifespan;
  var language;
  var price;
  var salePrice;
  var classname;
  var subjectname;
  var mcqcount;
  var totalvideos;
  var visitor;
  var likes;

  factory K12.fromJson(Map<String, dynamic> json) => K12(
      courseName: json["course_name"],
      formalName: json["formal_name"],
      syllabus: json["syllabus"],
      description: json["description"],
      lifespan: json["lifespan"],
      language: json["language"],
      price: json["price"],
      salePrice: json["sale_price"],
      img: json["img"],
      classname: json["class_name"],
      subjectname: json["subject_name"],
      mcqcount: json["mcq_count"],
      totalvideos: json["total_video"],
      likes: json["likes"],
      visitor: json["visitor"]);

  Map<String, dynamic> toJson() => {
        "course_name": courseName,
        "formal_name": formalName,
        "syllabus": syllabus,
        "description": description,
        "lifespan": lifespan,
        "language": language,
        "price": price,
        "sale_price": salePrice,
        "img": img,
        "class_name": classname,
        "subject_name": subjectname,
        "mcq_count": mcqcount,
        "total_video": totalvideos,
        "visitor": visitor,
        "likes": likes
      };
}

class K12Detail {
  K12Detail({
    required this.id,
    required this.chapterName,
    required this.about,
    required this.quiztime,
    required this.video_count,
  });

  var id;
  var chapterName;
  var about;
  var quiztime;
  var video_count;

  factory K12Detail.fromJson(Map<String, dynamic> json) => K12Detail(
        id: json["id"],
        chapterName: json["chapter_name"],
        about: json["about"],
        quiztime: json["quiz_time"],
        video_count: json["video_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "chapter_name": chapterName,
        "about": about,
        "quiz_time": quiztime,
        "video_count": video_count,
      };
}

Future<K12Api> createK12(String id) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/getk12/details";

  final response = await http.post(Uri.parse(apiUrl), body: {"book_id": id});

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return k12ApiFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

K12Chapter k12ChapterFromJson(String str) =>
    K12Chapter.fromJson(json.decode(str));
String k12ChapterToJson(K12Chapter data) => json.encode(data.toJson());

class K12Chapter {
  K12Chapter({
    required this.success,
    required this.data3,
    required this.message,
  });

  bool success;
  Data3 data3;
  String message;

  factory K12Chapter.fromJson(Map<String, dynamic> json) => K12Chapter(
        success: json["success"],
        data3: Data3.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data3.toJson(),
        "message": message,
      };
}

class Data3 {
  Data3({
    required this.chapterDetails,
    required this.videos,
    required this.questionTypes,
  });

  ChapterDetails chapterDetails;
  List<Video> videos;
  List<QuestionType> questionTypes;

  factory Data3.fromJson(Map<String, dynamic> json) => Data3(
        chapterDetails: ChapterDetails.fromJson(json["chapter_details"]),
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        questionTypes: List<QuestionType>.from(
            json["question_types"].map((x) => QuestionType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chapter_details": chapterDetails.toJson(),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "question_types":
            List<dynamic>.from(questionTypes.map((x) => x.toJson())),
      };
}

class ChapterDetails {
  ChapterDetails({
    required this.id,
    required this.bookId,
    required this.chapterName,
    required this.mediaFile,
    required this.fileName,
    required this.quizTime,
    required this.img,
    required this.likes,
    required this.visitors,
    required this.about,
    required this.syllabus,
    required this.description,
    required this.lifespan,
    required this.language,
    required this.price,
    required this.salePrice,
    required this.onSale,
    required this.featured,
    required this.status,
    required this.pdfFile,
    required this.pdfFileName,
    required this.pdfFile1,
    required this.pdfFileName1,
    required this.school,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  var id;
  var bookId;
  var chapterName;
  var mediaFile;
  var fileName;
  var quizTime;
  dynamic img;
  var likes;
  var visitors;
  var about;
  var syllabus;
  var description;
  var lifespan;
  var language;
  var price;
  var salePrice;
  var onSale;
  var featured;
  var status;
  dynamic pdfFile;
  dynamic pdfFileName;
  var pdfFile1;
  var pdfFileName1;
  var school;
  var createdBy;
  var updatedBy;
  dynamic createdAt;
  dynamic updatedAt;

  factory ChapterDetails.fromJson(Map<String, dynamic> json) => ChapterDetails(
        id: json["id"],
        bookId: json["book_id"],
        chapterName: json["chapter_name"],
        mediaFile: json["media_file"],
        fileName: json["file_name"],
        quizTime: json["quiz_time"],
        img: json["img"],
        likes: json["likes"],
        visitors: json["visitors"],
        about: json["about"],
        syllabus: json["syllabus"],
        description: json["description"],
        lifespan: json["lifespan"],
        language: json["language"],
        price: json["price"],
        salePrice: json["sale_price"],
        onSale: json["on_sale"],
        featured: json["featured"],
        status: json["status"],
        pdfFile: json["pdf_file"],
        pdfFileName: json["pdf_file_name"],
        pdfFile1: json["pdf_file1"],
        pdfFileName1: json["pdf_file_name1"],
        school: json["school"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_id": bookId,
        "chapter_name": chapterName,
        "media_file": mediaFile,
        "file_name": fileName,
        "quiz_time": quizTime,
        "img": img,
        "likes": likes,
        "visitors": visitors,
        "about": about,
        "syllabus": syllabus,
        "description": description,
        "lifespan": lifespan,
        "language": language,
        "price": price,
        "sale_price": salePrice,
        "on_sale": onSale,
        "featured": featured,
        "status": status,
        "pdf_file": pdfFile,
        "pdf_file_name": pdfFileName,
        "pdf_file1": pdfFile1,
        "pdf_file_name1": pdfFileName1,
        "school": school,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class QuestionType {
  QuestionType({
    required this.id,
    required this.catName,
    required this.questionCount,
  });

  int id;
  String catName;
  int questionCount;

  factory QuestionType.fromJson(Map<String, dynamic> json) => QuestionType(
        id: json["id"],
        catName: json["cat_name"],
        questionCount: json["question_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_name": catName,
        "question_count": questionCount,
      };
}

class Video {
  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.fileName,
    required this.visitors,
    required this.likes,
  });

  int id;
  String title;
  String description;
  String fileName;
  int visitors;
  int likes;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        fileName: json["file_name"],
        visitors: json["visitors"],
        likes: json["likes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "file_name": fileName,
        "visitors": visitors,
        "likes": likes,
      };
}

Future<K12Chapter> createqt(String id) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/chapter/details";

  final response = await http.post(Uri.parse(apiUrl), body: {"book_id": id});

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return k12ChapterFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

class challenge_page extends StatefulWidget {
  const challenge_page({Key? key}) : super(key: key);

  @override
  State<challenge_page> createState() => _challenge_pageState();
}

class _challenge_pageState extends State<challenge_page> {
  var idclass = "";
  var idSub = "";
  var idbook = "";
  var idchap = "";
  var idqt = "";
  late String _dropDownValue = "";
  late String _dropDownValue1 = "";
  late String _dropDownValue2 = "";
  late String _dropDownValue3 = "";
  String dropdownValueSubject = 'Subject';
  String dropdownValueChapter = 'Chapter';
  String dropdownValueQType = 'Type';
  List<String> SubjectList = [];

  @override
  Widget build(BuildContext context) {
    if (classId == "LKG")
      idclass = "1";
    else if (classId == "UKG")
      idclass = "2";
    else {
      idclass = (2 + int.parse(classId)).toString();
    }
    return FutureBuilder(
        future: createLiveStudents(idclass),
        builder: (context, AsyncSnapshot<Livestudents> snapshot) {
          if (snapshot.hasData) {
            if (SubjectList.isEmpty)
              for (var j = 0; j < snapshot.data!.data1.subjects.length; j++)
                SubjectList.add(
                    snapshot.data!.data1.subjects[j].subjectName.toString());
            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Quiz Challenge',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            FormField<String>(
                              builder: (FormFieldState<String> state) {
                                String _currentSelectedValue = '';
                                return Container(
                                  height: 55,
                                  //padding: EdgeInsets.only(left: 10,right: 10),
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                        //labelText: 'Subject',
                                        prefixIcon: Icon(Icons.subject,
                                            color: Colors.teal),
                                        labelStyle:
                                            TextStyle(fontFamily: "Candara"),
                                        errorStyle: TextStyle(
                                            fontFamily: "Candara",
                                            color: Colors.redAccent,
                                            fontSize: 16.0),
                                        //hintText: 'Please select expense',
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.teal, width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5))),
                                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                    isEmpty: _currentSelectedValue == '',
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                      menuMaxHeight: 200,
                                      hint: _dropDownValue == ""
                                          ? Text("Subject")
                                          : Text(
                                              _dropDownValue,
                                              style: TextStyle(
                                                  fontFamily: "Candara",
                                                  color: Colors.black,
                                                  fontSize: 14),
                                            ),
                                      isExpanded: false,
                                      iconSize: 30.0,
                                      style: TextStyle(color: Colors.black),
                                      items: SubjectList.map(
                                        (val) {
                                          return DropdownMenuItem<String>(
                                            value: val,
                                            child: Text(val),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (String? val) {
                                        for (var k = 0;
                                            k <
                                                snapshot.data!.data1.subjects
                                                    .length;
                                            k++)
                                          if (snapshot.data!.data1.subjects[k]
                                                  .subjectName ==
                                              val)
                                            idSub = snapshot
                                                .data!.data1.subjects[k].id
                                                .toString();

                                        setState(() {
                                          _dropDownValue = val!;
                                          _dropDownValue1 = "";
                                          _dropDownValue2 = "";
                                          _dropDownValue3 = "";
                                        });
                                      },
                                    )),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 8,
                              child: Container(),
                            ),
                            if (_dropDownValue != "")
                              FutureBuilder(
                                  future: getLiveSubjects(classId, idSub),
                                  builder: (context,
                                      AsyncSnapshot<K12Card> snapshot1) {
                                    if (snapshot1.hasData) {
                                      List<String> Booklist = [];
                                      for (var k = 0;
                                          k < snapshot1.data!.data2.k12.length;
                                          k++)
                                        Booklist.add(snapshot1
                                            .data!.data2.k12[k].courseName
                                            .toString());
                                      return FormField<String>(
                                        builder:
                                            (FormFieldState<String> state) {
                                          String _currentSelectedValue = '';
                                          return Container(
                                            height: 55,
                                            //padding: EdgeInsets.only(left: 10,right: 10),
                                            child: InputDecorator(
                                              decoration: InputDecoration(
                                                  //labelText: 'CLASS',
                                                  prefixIcon: Icon(
                                                      Icons.menu_book_sharp,
                                                      color: Colors.teal),
                                                  labelStyle: TextStyle(
                                                      fontFamily: "Candara",
                                                      fontSize: 16),
                                                  errorStyle: TextStyle(
                                                      fontFamily: "Candara",
                                                      color: Colors.redAccent,
                                                      fontSize: 16.0),
                                                  //hintText: 'Please select expense',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 2.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .teal,
                                                                  width: 2.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5))),
                                              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                              isEmpty:
                                                  _currentSelectedValue == '',
                                              child:
                                                  DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                menuMaxHeight: 200,
                                                hint: _dropDownValue1 == ""
                                                    ? Text("Book")
                                                    : Text(
                                                        _dropDownValue1,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Candara",
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                isExpanded: false,
                                                iconSize: 30,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                items: Booklist.map(
                                                  (val) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: val,
                                                      child: Text(val),
                                                    );
                                                  },
                                                ).toList(),
                                                onChanged: (String? val) {
                                                  for (var k = 0;
                                                      k <
                                                          snapshot1.data!.data2
                                                              .k12.length;
                                                      k++)
                                                    if (snapshot1
                                                            .data!
                                                            .data2
                                                            .k12[k]
                                                            .courseName ==
                                                        val)
                                                      idbook = snapshot1
                                                          .data!.data2.k12[k].id
                                                          .toString();
                                                  debugPrint(idbook);
                                                  setState(() {
                                                    _dropDownValue1 = val!;
                                                    _dropDownValue2 = "";
                                                    _dropDownValue3 = "";
                                                  });
                                                },
                                              )),
                                            ),
                                          );
                                        },
                                      );
                                    } else
                                      return Text("no");
                                  }),
                            SizedBox(
                              height: 8,
                              child: Container(),
                            ),
                            if (_dropDownValue1 != "")
                              FutureBuilder(
                                  future: createK12(idbook),
                                  builder: (context,
                                      AsyncSnapshot<K12Api> snapshot2) {
                                    if (snapshot2.hasData) {
                                      List<String> ChapList = [];
                                      for (var k = 0;
                                          k <
                                              snapshot2
                                                  .data!.data.k12Details.length;
                                          k++)
                                        ChapList.add(snapshot2.data!.data
                                            .k12Details[k].chapterName
                                            .toString());
                                      return FormField<String>(
                                        builder:
                                            (FormFieldState<String> state) {
                                          String _currentSelectedValue = '';
                                          return Container(
                                            height: 55,
                                            //padding: EdgeInsets.only(left: 10),
                                            child: InputDecorator(
                                              decoration: InputDecoration(
                                                  //labelText: 'CLASS',
                                                  prefixIcon: Icon(
                                                    Icons.book_rounded,
                                                    color: Colors.teal,
                                                    size: 20,
                                                  ),
                                                  labelStyle: TextStyle(
                                                      fontFamily: "Candara"),
                                                  errorStyle: TextStyle(
                                                      fontFamily: "Candara",
                                                      color: Colors.redAccent,
                                                      fontSize: 16.0),
                                                  //hintText: 'Please select expense',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 2.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .teal,
                                                                  width: 2.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5))),
                                              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                              isEmpty:
                                                  _currentSelectedValue == '',
                                              child:
                                                  DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                menuMaxHeight: 200,
                                                hint: _dropDownValue2 == ""
                                                    ? Text("Chapter")
                                                    : Text(
                                                        _dropDownValue2,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Candara",
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                isExpanded: true,
                                                iconSize: 30.0,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                items: ChapList.map(
                                                  (val) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: val,
                                                      child: Text(val),
                                                    );
                                                  },
                                                ).toList(),
                                                onChanged: (String? val) {
                                                  for (var k = 0;
                                                      k <
                                                          snapshot2
                                                              .data!
                                                              .data
                                                              .k12Details
                                                              .length;
                                                      k++)
                                                    if (snapshot2
                                                            .data!
                                                            .data
                                                            .k12Details[k]
                                                            .chapterName ==
                                                        val)
                                                      idchap = snapshot2.data!
                                                          .data.k12Details[k].id
                                                          .toString();
                                                  setState(() {
                                                    _dropDownValue2 = val!;
                                                    _dropDownValue3 = "";
                                                  });
                                                },
                                              )),
                                            ),
                                          );
                                        },
                                      );
                                    } else
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                  }),
                            SizedBox(
                              height: 8,
                              child: Container(),
                            ),
                            if (_dropDownValue2 != "")
                              FutureBuilder(
                                  future: createqt(idchap),
                                  builder: (context,
                                      AsyncSnapshot<K12Chapter> snapshot3) {
                                    if (snapshot3.hasData) {
                                      List<String> qtList = [];
                                      for (var k = 0;
                                          k <
                                              snapshot3.data!.data3
                                                  .questionTypes.length;
                                          k++)
                                        qtList.add(snapshot3.data!.data3
                                            .questionTypes[k].catName
                                            .toString());
                                      return FormField<String>(
                                        builder:
                                            (FormFieldState<String> state) {
                                          String _currentSelectedValue = '';
                                          return Container(
                                            height: 55,
                                            //padding: EdgeInsets.only(left: 10),
                                            child: InputDecorator(
                                              decoration: InputDecoration(
                                                  //labelText: 'CLASS',
                                                  prefixIcon: Icon(
                                                    Icons.list_alt,
                                                    color: Colors.teal,
                                                    size: 20,
                                                  ),
                                                  labelStyle: TextStyle(
                                                      fontFamily: "Candara"),
                                                  errorStyle: TextStyle(
                                                      fontFamily: "Candara",
                                                      color: Colors.redAccent,
                                                      fontSize: 16.0),
                                                  //hintText: 'Please select expense',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 2.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .teal,
                                                                  width: 2.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5))),
                                              //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                              isEmpty:
                                                  _currentSelectedValue == '',
                                              child:
                                                  DropdownButtonHideUnderline(
                                                      child: DropdownButton(
                                                menuMaxHeight: 200,
                                                hint: _dropDownValue3 == ""
                                                    ? Text("QuestionType")
                                                    : Text(
                                                        _dropDownValue3,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Candara",
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                isExpanded: true,
                                                iconSize: 30.0,
                                                style: TextStyle(
                                                    color: Colors.black),
                                                items: qtList.map(
                                                  (val) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: val,
                                                      child: Text(val),
                                                    );
                                                  },
                                                ).toList(),
                                                onChanged: (String? val) {
                                                  for (var k = 0;
                                                      k <
                                                          snapshot3
                                                              .data!
                                                              .data3
                                                              .questionTypes
                                                              .length;
                                                      k++)
                                                    if (snapshot3
                                                            .data!
                                                            .data3
                                                            .questionTypes[k]
                                                            .catName
                                                            .toString() ==
                                                        val)
                                                      idqt = snapshot3
                                                          .data!
                                                          .data3
                                                          .questionTypes[k]
                                                          .id
                                                          .toString();
                                                  setState(() {
                                                    _dropDownValue3 = val!;
                                                  });
                                                },
                                              )),
                                            ),
                                          );
                                        },
                                      );
                                    } else
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                  }),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 20,
                              child: Text(
                                'Random students of your grade',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            for (var i = 0;
                                i < snapshot.data!.data1.student.length;
                                i++)
                              Container(
                                //margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.amber,
                                                    backgroundImage: NetworkImage(
                                                        "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/uploads/${snapshot.data!.data1.student[i].img.toString()}")),
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${snapshot.data!.data1.student[i].name.toString()}",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 42, 56, 134),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${snapshot.data!.data1.student[i].school.toString()}",
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                          if (_dropDownValue != "" &&
                                              _dropDownValue1 != "" &&
                                              _dropDownValue2 != "" &&
                                              _dropDownValue3 != "")
                                            Expanded(
                                              flex: 3,
                                              child: SizedBox(
                                                height: 30,
                                                width: 40,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.teal)),
                                                  child: Text('Play',
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                  onPressed: () async {
                                                    SendInvite inv =
                                                        await createInvite(snapshot.data!.data1.student[i].id.toString(),idSub.toString(),idbook.toString(),idchap.toString(),idqt.toString());

                                                    setState(() {
                                                      _inv = inv;
                                                    });

                                                    if (invitecode == 200) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  quiz_challenge(idchap, idqt,
                                                                      snapshot.data!.data1.student[i]
                                                                          .name
                                                                          .toString(),
                                                                      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/uploads/${snapshot.data!.data1.student[i].img.toString()}")));
                                                    }

                                                  },
                                                ),
                                              ),
                                            )
                                          else
                                            Expanded(
                                              flex: 3,
                                              child: SizedBox(
                                                height: 30,
                                                width: 40,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(
                                                                  Colors.grey)),
                                                  child: Text('Play',
                                                      style: TextStyle(
                                                          fontSize: 12)),
                                                  onPressed: () {},
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }
}
