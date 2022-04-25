import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_duniya/Login2.dart';
import 'package:learning_duniya/quiz_ass.dart';
import 'package:learning_duniya/quiz_assessment.dart';
//import 'package:learning_duniya/screen1%20(2).dart';

import 'globals.dart';

AssesChap assesChapFromJson(String str) => AssesChap.fromJson(json.decode(str));
String assesChapToJson(AssesChap data) => json.encode(data.toJson());

class AssesChap {
  AssesChap({
    required  this.success,
    required  this.data,
    required  this.message,
  });

  bool success;
  Data data;
  String message;

  factory AssesChap.fromJson(Map<String, dynamic> json) => AssesChap(
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
    required  this.assessment,
    required  this.chapter,
    required  this.questionTypes,
  });

  Assessment assessment;
  Chapter chapter;
  List<QuestionType> questionTypes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    assessment: Assessment.fromJson(json["assessment"]),
    chapter: Chapter.fromJson(json["chapter"]),
    questionTypes: List<QuestionType>.from(json["question_types"].map((x) => QuestionType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "assessment": assessment.toJson(),
    "chapter": chapter.toJson(),
    "question_types": List<dynamic>.from(questionTypes.map((x) => x.toJson())),
  };
}
class Assessment {
  Assessment({
    required  this.id,
    required  this.assessmentName,
    required  this.subjectId,
    required  this.subject,
    required  this.classId,
    required  this.assessmentClass,
    required  this.bookId,
    required  this.likes,
    required  this.visitors,
  });

  var id;
  var assessmentName;
  var subjectId;
  var subject;
  var classId;
  var assessmentClass;
  var bookId;
  var likes;
  var visitors;

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
    id: json["id"],
    assessmentName: json["assessment_name"],
    subjectId: json["subject_id"],
    subject: json["subject"],
    classId: json["class_id"],
    assessmentClass: json["class"],
    bookId: json["book_id"],
    likes: json["likes"],
    visitors: json["visitors"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "assessment_name": assessmentName,
    "subject_id": subjectId,
    "subject": subject,
    "class_id": classId,
    "class": assessmentClass,
    "book_id": bookId,
    "likes": likes,
    "visitors": visitors,
  };
}
class Chapter {
  Chapter({
    required this.id,
    required this.bookId,
    required this.chapterName,
    required this.quizTime,
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
    required this.school,
    required this.fileName,
    required this.pdfFileName,
    required this.pdfFileName1,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
  });

  var id;
  var bookId;
  var chapterName;
  var quizTime;
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
  var school;
  var fileName;
  var  pdfFileName;
  var pdfFileName1;
  var createdBy;
  var createdAt;
  var updatedBy;
  var updatedAt;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
    id: json["id"],
    bookId: json["book_id"],
    chapterName: json["chapter_name"],
    quizTime: json["quiz_time"],
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
    school: json["school"],
    fileName: json["file_name"],
    pdfFileName: json["pdf_file_name"],
    pdfFileName1: json["pdf_file_name1"],
    createdBy: json["created_by"],
    createdAt: json["created_at"],
    updatedBy: json["updated_by"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "book_id": bookId,
    "chapter_name": chapterName,
    "quiz_time": quizTime,
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
    "school": school,
    "file_name": fileName,
    "pdf_file_name": pdfFileName,
    "pdf_file_name1": pdfFileName1,
    "created_by": createdBy,
    "created_at": createdAt,
    "updated_by": updatedBy,
    "updated_at": updatedAt,
  };
}
class QuestionType {
  QuestionType({
    required this.id,
    required this.catName,
    required this.questionCount,
  });

  var  id;
  var  catName;
  var  questionCount;

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

Future<AssesChap> createAssessChap(String assid,String chapid ) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/assessment/chapter/details";
  final response = await http.post(Uri.parse(apiUrl),headers: <String, String> {
    "Authorization": "Bearer $token",
  },
      body: {
    "assessment_id":assid,
    "chapter_id":chapid
  }
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return assesChapFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}


class ass_chap extends StatefulWidget {
  //const ass_chap({Key? key}) : super(key: key);
  ass_chap(this.chapid,this.Assid,this.assImg,this.desc);
  var Assid;
  var chapid;
  var assImg;
  var desc;
  @override
  _ass_chapState createState() => _ass_chapState(Assid,chapid,assImg,desc);
}

class _ass_chapState extends State<ass_chap> {
  _ass_chapState(this._Assid,this._chapid,this._assImg,this._desc);
  var _Assid;
  var _chapid;
  var _assImg;
  var _desc;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: FutureBuilder(
          future: createAssessChap(_Assid.toString(),_chapid.toString()),
          builder: (context, AsyncSnapshot<AssesChap> snapshot) {
            if (snapshot.hasData) {
              AssesChap? ass = snapshot.data;

              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(25),
                    height: (size.height) / 2.5,
                    width: (size.width),
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        image: DecorationImage(
                            image: NetworkImage("${_assImg}"),
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
                                  Text("book to be asked",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Candara",
                                          color: Colors.teal)),
                                  SizedBox(width: 30),
                                  Icon(Icons.school, color: Colors.deepOrange, size: 25),
                                  Text(" ${ass.data.assessment.assessmentClass.toString()}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Candara",
                                          color: Colors.grey))
                                  //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                ],
                              ),
                              SizedBox(height: 20),

                              //SizedBox(height: 10),
                              Text(_desc.toString(),
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
                                      Text("      ${ass.data.assessment.subject.toString()}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: "Candara",
                                              color: Colors.grey)),
                                      SizedBox(height: 15),
                                      Row(
                                        children: [

                                          Icon(Icons.content_paste,color: Colors.teal,size: 20),
                                          Text(" Question type",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: "Candara",
                                                  color: Colors.black)),
                                        ],
                                      ),
                                      Text("      ${ass.data.questionTypes.length.toString()}",
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
                                      Text("      ${ass.data.assessment.assessmentClass.toString()}",
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
                                      Text("      ${_desc.toString()}",
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
                              i < snapshot.data!.data.questionTypes.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    if(token!=""){
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => screen12(snapshot.data!.data.chapter.id,snapshot.data!.data.assessment.id,snapshot.data!.data.questionTypes[i].id)));}
                                    else{
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => Login2()));
                                    }
                                  },
                                  child: Card(
                                    elevation: 2,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                snapshot.data!.data.questionTypes[i].catName,
                                                style: TextStyle(
                                                    fontFamily: "Candara",
                                                    fontSize: 15),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Questions:",
                                                    style: TextStyle(
                                                        fontFamily: "Candara",
                                                        fontSize: 13,
                                                      color: Colors.grey
                                                    ),
                                                  ),
                                                  Text(
                                                    snapshot.data!.data.questionTypes[i].questionCount.toString(),
                                                    style: TextStyle(
                                                        fontFamily: "Candara",
                                                        fontSize: 13,
                                                    color: Colors.grey
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
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
