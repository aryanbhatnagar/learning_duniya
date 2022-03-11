import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_duniya/courseDesc.dart';

K12Api k12ApiFromJson(String str) => K12Api.fromJson(json.decode(str));
String courseID="1";
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
    k12Details: List<K12Detail>.from(json["k12_details"].map((x) => K12Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "k12": k12.toJson(),
    "k12_details": List<dynamic>.from(k12Details.map((x) => x.toJson())),
  };
}

class K12 {
  K12({

    required this.courseName,
    required this.formalName,
    required this.syllabus,
    required this.description,
    required this.lifespan,
    required this.language,
    required this.price,
    required this.salePrice,

  });


   var courseName;
   var formalName;
   var syllabus;
   var description;
   var lifespan;
   var language;
   var price;
   var salePrice;


  factory K12.fromJson(Map<String, dynamic> json) => K12(

    courseName: json["course_name"],
    formalName: json["formal_name"],
    syllabus: json["syllabus"],
    description: json["description"],
    lifespan: json["lifespan"],
    language: json["language"],
    price: json["price"],
    salePrice: json["sale_price"],

  );

  Map<String, dynamic> toJson() => {

    "course_name": courseName,
    "formal_name": formalName,
    "syllabus": syllabus,
    "description": description,
    "lifespan": lifespan,
    "language": language,
    "price": price,
    "sale_price": salePrice,
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
    "about": about ,
    "quiz_time": quiztime,
    "video_count":video_count,
  };
}

Future<K12Api> createK12(String id) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/getk12/details";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "book_id": id
  }
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return k12ApiFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

class k12_det extends StatelessWidget {

  String courseId;

  k12_det(this.courseId); //const k12_det({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    courseID=courseId;
    return MaterialApp(
      home:k12detail()
    );
  }
}

class k12detail extends StatefulWidget {
  const k12detail({Key? key}) : super(key: key);

  @override
  _k12detailState createState() => _k12detailState();
}

class _k12detailState extends State<k12detail> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: createK12(courseID),
        builder: (context, AsyncSnapshot<K12Api> snapshot) {
          if (snapshot.hasData) {
            K12Api? k12 = snapshot.data;
            print(snapshot.data);
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(25),
                  height: (size.height) / 3,
                  width: (size.width),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      image: DecorationImage(
                          image: AssetImage("images/hindiass.jpg"),
                          fit: BoxFit.fill)),

                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    height: (size.height) - (size.height) / 4,
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
                                  child: Text(k12!.data.k12.courseName.toString(),
                                      style: TextStyle(
                                          fontSize: 35,
                                          fontFamily: "Candara",
                                          color: Colors.black)),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.book, color: Colors.teal, size: 25),
                                Text("test",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Candara",
                                        color: Colors.teal)),
                                SizedBox(width: 30),
                                Icon(Icons.people, color: Colors.yellow, size: 30),
                                Text("test",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Candara",
                                        color: Colors.grey))
//IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                              ],
                            ),
                            SizedBox(height: 20),
                            Text("Description",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "Candara",
                                    color: Colors.black)),
                            SizedBox(height: 10),
                            Text(k12.data.k12.description.toString(),
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: "Candara",
                                    color: Colors.grey)),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Subject",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Candara",
                                            color: Colors.black)),
                                    Text(k12.data.k12.lifespan.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Candara",
                                            color: Colors.grey)),
                                    SizedBox(height: 15),
                                    Text("Subject ID",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Candara",
                                            color: Colors.black)),
                                    Text(k12.data.k12.language.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Candara",
                                            color: Colors.grey)),
                                  ],
                                ),
                                SizedBox(width: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Class ID",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Candara",
                                            color: Colors.black)),
                                    Text(k12.data.k12.price.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Candara",
                                            color: Colors.grey)),
                                    SizedBox(height: 15),
                                    Text("Board ID",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Candara",
                                            color: Colors.black)),
                                    Text(k12.data.k12.salePrice.toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Candara",
                                            color: Colors.grey)),
                                  ],
                                )
                              ],
                            ),

                            SizedBox(height: 25),
                            for(int i=0; i<k12.data.k12Details.length; i++)

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          courseDesc(k12.data.k12Details[i].id.toString())));
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(k12.data.k12Details[i].chapterName.toString(),
                                                  style: TextStyle(fontFamily: "Candara",
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("Videos : ${k12.data.k12Details[i].video_count.toString()}",
                                                  style: TextStyle(fontFamily: "Candara",color: Colors.grey,
                                                      fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward_ios, color: Colors.black, size: 30)
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
      ),
    );
  }
}

