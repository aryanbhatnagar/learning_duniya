import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:learning_duniya/Dashboard.dart';
import 'package:learning_duniya/assessment.dart';
import 'courseDesc.dart';
import 'mentor.dart';
import 'quiz.dart';

Asses assesFromJson(String str) => Asses.fromJson(json.decode(str));
String assesToJson(Asses data) => json.encode(data.toJson());

class Asses {
  Asses({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory Asses.fromJson(Map<String, dynamic> json) => Asses(
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
    required this.mentors,
  });

  List<Mentor> mentors;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mentors: List<Mentor>.from(json["mentors"].map((x) => Mentor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mentors": List<dynamic>.from(mentors.map((x) => x.toJson())),
  };
}
class Mentor {
  Mentor({
    required this.id,
    required this.eduName,
    required this.specilization,
    required this.state,
    required this.city,
    required this.reviews,
    required this.likes,
    required this.img,
    required this.exp

  });

  var id;
  var eduName;
  var specilization;
  //var aboutUs;
  //var phone;
  var exp;
  var state;
  var city;
  var reviews;
  var likes;
  var img;
  //var createdAt;
  //var updatedAt;
  //var status;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
    id: json["id"],
    eduName: json["edu_name"],
    specilization: json["specilization"],
    exp: json["exp"],
    state: json["state"],
    city: json["city"],
    reviews: json["reviews"],
    likes: json["likes"],
    img: json["img"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "edu_name": eduName,
    "specilization": specilization,
    "exp": exp,
    "state": state,
    "city": city,
    "reviews": reviews,
    "likes": likes,
    "img": img,


  };
}
Future<Asses> getAsses() async {

  final String apiUrl = "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/mentors";
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return assesFromJson(responseString);
  }
  else {
    throw Exception('Failed to load album');
  }
}


AllAsses allAssesFromJson(String str) => AllAsses.fromJson(json.decode(str));
String allAssesToJson(AllAsses data) => json.encode(data.toJson());

class AllAsses {
  AllAsses({
    required this.success,
    required this.data1,
    required this.message,
  });

  bool success;
  Data1 data1;
  String message;

  factory AllAsses.fromJson(Map<String, dynamic> json) => AllAsses(
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
    required this.assessments,
  });

  List<Assessment> assessments;

  factory Data1.fromJson(Map<String, dynamic> json) => Data1(
    assessments: List<Assessment>.from(json["assessments"].map((x) => Assessment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "assessments": List<dynamic>.from(assessments.map((x) => x.toJson())),
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
    required this.img,
    required this.price,
    required this.Class,

  });

  var id;
  var assessmentName;
  var subjectId;
  var subject;
  var classId;
  var assessmentClass;
  var bookId;
  var book;
  var Class;
  var price;
  var img;

  factory Assessment.fromJson(Map<String, dynamic> json) => Assessment(
    id: json["id"],
    assessmentName: json["assessment_name"],
    subjectId: json["subject_id"],
    subject: json["subject"],
    classId: json["class_id"],
    assessmentClass: json["class"],
    bookId: json["book_id"],
    book: json["book"],
    img: json["img"],
    price: json["price"],
    Class: json["class"],
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
    "class":Class,
    "img": img,
  "price": price
  };
}

Future<AllAsses> getAllAsses() async {

  final String apiUrl = "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/assessments";
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return allAssesFromJson(responseString);
  }
  else {
    throw Exception('Failed to load album');
  }
}




class seeall extends StatelessWidget {
  const seeall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: seeallpage("EMPTY", 0),
    );
  }
}

class seeallpage extends StatefulWidget {
  String title;
  int code;

  seeallpage(this.title, this.code);

  //const seeallpage({Key? key}) : super(key: key);

  @override
  _seeallpageState createState() => _seeallpageState(title, code);
}

class _seeallpageState extends State<seeallpage> {
  late String title;
  _seeallpageState(this.title, this.code);
  late int code;

  //list for views
  List<Widget> pop_c = <Widget>[];
  List<Widget> asses = <Widget>[];
  List<Widget> k12 = <Widget>[];
  List<Widget> comp_e = <Widget>[];
  List<Widget> mento = <Widget>[];

  @override
  Widget build(BuildContext context) {
    for (var i = 0; i <= 7; i++)
      pop_c.add(GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => courseDesc("1", "")));
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
                    width: 150,
                    fit: BoxFit.scaleDown,
                  ))),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                child: Container(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Course Title",
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
    for (var i = 0; i <= 7; i++)
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Hindi Exam",
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


    List<Widget> card = <Widget>[
      FutureBuilder(
          future: getAllAsses(),
          builder: (context, AsyncSnapshot<AllAsses> snapshot){
            if(snapshot.hasData){
              if(asses.isEmpty)
                for (var i = 0; i <snapshot.data!.data1.assessments.length; i++)
                  asses.add(GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) =>
                          assess(snapshot.data!.data1.assessments[i].id,"images/english.png")));
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
                                image: DecorationImage(image: AssetImage("images/english.png"),fit: BoxFit.fill),
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
                                              "${snapshot.data!.data1.assessments[i]
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
                                            "${snapshot.data!.data1.assessments[i].subject}",
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

              return Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      Text(title,
                          style: TextStyle(
                              fontFamily: "Candara",
                              fontSize: 35,
                              color: Colors.black)),
                      new Expanded(
                        child: GridView.count(
                          childAspectRatio: 0.8,
                          crossAxisCount: 2,
                          children: mento,
                        ),
                      ),
                    ],
                  ));
            }
            else{
              return Container(child: Center(child: CircularProgressIndicator()));
            }
          }
      )
    ];

    if (code == 1) card = pop_c;
    if (code == 2) card = asses;
    if (code == 3) card = comp_e;

    if (code == 4)
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.teal,
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getAsses(),
            builder: (context, AsyncSnapshot<Asses> snapshot){
              if(snapshot.hasData){
                return SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(20),
                      color: Colors.grey[200],
                      child: Column(
                        children: [
                          for(var i=0;i<snapshot.data!.data.mentors.length;i++)
                            GestureDetector(
                              onTap:(){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => mentor(snapshot.data!.data.mentors[i].id)));
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
                                      Center(
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage("${snapshot.data!.data.mentors[i].img}"),
                                          radius: 30,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Card(
                                        elevation: 0,
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${snapshot.data!.data.mentors[i].eduName}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Candara',
                                                fontSize: 18,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                    '${snapshot.data!.data.mentors[i].specilization}  |  ',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Candara',
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 5,
                                                    overflow: TextOverflow.ellipsis),
                                                Text(
                                                    '${snapshot.data!.data.mentors[i].exp} yrs',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Candara',
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                    ),
                                                    maxLines: 5,
                                                    overflow: TextOverflow.ellipsis),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                //getIcon(snapshot.data!.data2.mentees2[i].mode.toString()),
                                                //Text(snapshot.data!.data2.mentees2[i].mode.toString()),
                                                RichText(
                                                  text: TextSpan(
                                                    text: "City: ",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Candara',
                                                      fontSize: 10,
                                                    ),
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text:
                                                          '  ${snapshot.data!.data.mentors[i].city}  ',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                              color: Color.fromARGB(
                                                                  255, 59, 48, 214))),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                            /*Text(
                                             '${snapshot.data!.data2.mentees2[i].datetime.day}/' +
                                                 convMon(snapshot.data!.data2.mentees2[i].datetime.month)+'/' +
                                                 '${snapshot.data!.data2.mentees2[i].datetime.year}  ' +
                                                 '${snapshot.data!.data2.mentees2[i].datetime.hour}:' +
                                                 convMin(snapshot.data!.data2.mentees2[i].datetime.minute),
                                             style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               fontFamily: 'Candara',
                                               fontSize: 11,
                                             ),
                                           ),*/
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          /* new Expanded(
                            child: GridView.count(
                              childAspectRatio: 0.77,
                              crossAxisCount: 2,
                              children: <Widget>[

                              ],
                            ),
                          ),*/
                        ],
                      )),
                );
              }
              else{
                return Container(child: Center(child: CircularProgressIndicator()));
              }
            }
        ));
    else
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text(title),
        ),
        body: FutureBuilder(
            future: getAllAsses(),
            builder: (context, AsyncSnapshot<AllAsses> snapshot){
              if(snapshot.hasData){

                return Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                       for(var i=0;i<snapshot.data!.data1.assessments.length;i++)
                         GestureDetector(
                           onTap:(){
                             Navigator.push(
                                 context, MaterialPageRoute(builder: (context) =>
                                 assess(snapshot.data!.data1.assessments[i].id,snapshot.data!.data1.assessments[i].img)));
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
                                   Center(
                                     child: CircleAvatar(
                                       backgroundImage: NetworkImage("${snapshot.data!.data1.assessments[i].img.toString()}"),
                                       radius: 30,
                                     ),
                                   ),
                                   SizedBox(width: 10,),
                                   Card(
                                     elevation: 0,
                                     color: Colors.transparent,
                                     child: Column(
                                       crossAxisAlignment:
                                       CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           '${snapshot.data!.data1.assessments[i].assessmentName}',
                                           style: TextStyle(
                                             fontWeight: FontWeight.bold,
                                             fontFamily: 'Candara',
                                             fontSize: 18,
                                           ),
                                         ),
                                         Text(
                                             '${snapshot.data!.data1.assessments[i].subject}',
                                             style: TextStyle(
                                               //fontWeight: FontWeight.bold,
                                               fontFamily: 'Candara',
                                               color: Colors.grey,
                                               fontSize: 13 ,
                                             ),
                                             maxLines: 5,
                                             overflow: TextOverflow.ellipsis),
                                         Row(
                                           children: [
                                             //getIcon(snapshot.data!.data2.mentees2[i].mode.toString()),
                                             //Text(snapshot.data!.data2.mentees2[i].mode.toString()),
                                             RichText(
                                               text: TextSpan(
                                                 text: "Class: ",
                                                 style: TextStyle(
                                                   color: Colors.grey,
                                                   fontWeight: FontWeight.bold,
                                                   fontFamily: 'Candara',
                                                   fontSize: 10,
                                                 ),
                                                 children: <TextSpan>[
                                                   TextSpan(
                                                       text:
                                                       '  ${snapshot.data!.data1.assessments[i].Class}  ',
                                                       style: TextStyle(
                                                         fontSize: 10,
                                                           color: Color.fromARGB(
                                                               255, 59, 48, 214))),
                                                 ],
                                               ),
                                             ),

                                           ],
                                         ),
                                         /*Text(
                                           '${snapshot.data!.data2.mentees2[i].datetime.day}/' +
                                               convMon(snapshot.data!.data2.mentees2[i].datetime.month)+'/' +
                                               '${snapshot.data!.data2.mentees2[i].datetime.year}  ' +
                                               '${snapshot.data!.data2.mentees2[i].datetime.hour}:' +
                                               convMin(snapshot.data!.data2.mentees2[i].datetime.minute),
                                           style: TextStyle(
                                             fontWeight: FontWeight.bold,
                                             fontFamily: 'Candara',
                                             fontSize: 11,
                                           ),
                                         ),*/
                                         SizedBox(
                                           height: 10,
                                         ),
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         )
                       /* new Expanded(
                          child: GridView.count(
                            childAspectRatio: 0.77,
                            crossAxisCount: 2,
                            children: <Widget>[

                            ],
                          ),
                        ),*/
                      ],
                    ));
              }
              else{
                return Container(child: Center(child: CircularProgressIndicator()));
              }
            }
        ),
      );

  }
}

