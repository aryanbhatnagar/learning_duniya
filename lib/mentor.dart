import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:http/http.dart' as http;
import 'need_help_page.dart';

Mentor mentorFromJson(String str) => Mentor.fromJson(json.decode(str));

String mentorToJson(Mentor data) => json.encode(data.toJson());
var memId = "3";
List<String> serviceList = <String>[];

Future<Mentor> createMentor(String id) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/mentor";

  final response = await http.post(Uri.parse(apiUrl), body: {"id": id});

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return mentorFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

class Mentor {
  Mentor({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
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
    required this.educator,
    required this.services,
  });

  Educator educator;
  List<Service> services;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        educator: Educator.fromJson(json["educator"]),
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "educator": educator.toJson(),
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Educator {
  Educator({
    required this.id,
    required this.eduName,
    required this.specilization,
    required this.aboutUs,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.reviews,
    required this.likes,
    required this.img,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  int id;
  String eduName;
  String specilization;
  String aboutUs;
  String phone;
  String country;
  String state;
  String city;
  int reviews;
  int likes;
  String img;
  dynamic createdAt;
  DateTime updatedAt;
  String status;

  factory Educator.fromJson(Map<String, dynamic> json) => Educator(
        id: json["id"],
        eduName: json["edu_name"],
        specilization: json["specilization"],
        aboutUs: json["about_us"],
        phone: json["phone"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        reviews: json["reviews"],
        likes: json["likes"],
        img: json["img"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "edu_name": eduName,
        "specilization": specilization,
        "about_us": aboutUs,
        "phone": phone,
        "country": country,
        "state": state,
        "city": city,
        "reviews": reviews,
        "likes": likes,
        "img": img,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
      };
}

class Service {
  Service({
    required this.id,
    required this.services,
    required this.communicationText,
    required this.communicationAudio,
    required this.communicationVideo,
  });

  int id;
  String services;
  String communicationText;
  String communicationAudio;
  String communicationVideo;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        services: json["services"],
        communicationText: json["communication_text"],
        communicationAudio: json["communication_audio"],
        communicationVideo: json["communication_video"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "services": services,
        "communication_text": communicationText,
        "communication_audio": communicationAudio,
        "communication_video": communicationVideo,
      };
}

class mentor extends StatelessWidget {
  late int id;

  mentor(this.id); //mentor({Key? key}) : super(key: key);
  //menId = s;

  @override
  Widget build(BuildContext context) {
    memId = id.toString();
    return MaterialApp(
      home: mentorpage(),
    );
  }
}

class mentorpage extends StatefulWidget {
  const mentorpage({Key? key}) : super(key: key);

  @override
  _mentorpageState createState() => _mentorpageState();
}

class _mentorpageState extends State<mentorpage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: FutureBuilder(
      future: createMentor(memId),
      builder: (context, AsyncSnapshot<Mentor> snapshot) {
        if (snapshot.hasData) {
          Mentor? men1 = snapshot.data;
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
                        image: AssetImage("images/mentor1.PNG"),
                        fit: BoxFit.fill)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
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
                            child: Text(men1!.data.educator.eduName,
                                style: TextStyle(
                                    fontSize: 35,
                                    fontFamily: "Candara",
                                    color: Colors.black)),
                          ),
                          FavoriteButton(
                            iconSize: 50,
                            isFavorite: false,
                            valueChanged: (_isFavorite) {
                              print('Is Favorite : $_isFavorite');
                            },
                          )
                        ],
                      ),
                        Text(men1.data.educator.specilization,
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Candara",
                              color: Colors.teal)),
                        SizedBox(height: 10),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.favorite, color: Colors.red, size: 25),
                          Text(men1.data.educator.likes.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Candara",
                                  color: Colors.grey)),
                          SizedBox(width: 30),
                          Icon(Icons.play_arrow,
                              color: Colors.lightBlueAccent, size: 30),
                          Text(men1.data.educator.reviews.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Candara",
                                  color: Colors.grey))
                        ],
                      ),
                      SizedBox(height: 20),
                      Text("About Mentor",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Candara",
                              color: Colors.black)),
                      SizedBox(height: 10),
                      Text(men1.data.educator.aboutUs,
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "Candara",
                              color: Colors.grey)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Services by mentor",
                              style: TextStyle(
                                  fontFamily: "Candara",
                                  fontSize: 25,
                                  color: Colors.black)),
                        ],
                      ),
                      SizedBox(height: 10),
                      for (int i = 0;
                          i < snapshot.data!.data.services.length;
                          i++)
                        GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    elevation: 5,
                                    child: Column(
                                      //crossAxisAlignment: CrossAxisAlignment.center
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.teal),
                                          width: 175,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                    child: Text(
                                                        snapshot
                                                            .data!
                                                            .data
                                                            .services[i]
                                                            .services,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontFamily:
                                                                "Candara",
                                                            color:
                                                                Colors.black))),
                                                SizedBox(height: 10),
                                                Center(
                                                  child: RaisedButton(
                                                    padding: EdgeInsets.zero,
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            /*for(i=0; i<snapshot.data!.data.services.length; i++) {
                                                              if (snapshot.data!
                                                                  .data
                                                                  .services[i]
                                                                  .communicationAudio !=
                                                                  "")
                                                                serviceList.add(
                                                                    snapshot
                                                                        .data!
                                                                        .data
                                                                        .services[i]
                                                                        .communicationAudio);
                                                              if (snapshot.data!
                                                                  .data
                                                                  .services[i]
                                                                  .communicationText !=
                                                                  "")
                                                                serviceList.add(
                                                                    snapshot
                                                                        .data!
                                                                        .data
                                                                        .services[i]
                                                                        .communicationText);
                                                              if (snapshot.data!
                                                                  .data
                                                                  .services[i]
                                                                  .communicationVideo !=
                                                                  "")
                                                                serviceList.add(
                                                                    snapshot
                                                                        .data!
                                                                        .data
                                                                        .services[i]
                                                                        .communicationVideo);
                                                            }*/
                                                            return need_help_page(
                                                              name:
                                                                  "Profile Name",
                                                              items1: [
                                                                'Item 1',
                                                                'Item 2',
                                                                'Item 3',
                                                                'Item 4'
                                                              ],
                                                              items2: [
                                                                'Item 1',
                                                                'Item 2',
                                                                'Item 3',
                                                              ],
                                                              category: [
                                                                'Cat 1',
                                                                'Cat 2',
                                                                'Cat 3'
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    color: Colors.lightBlue,
                                                    child: (Text("Start",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                "Candara",
                                                            color:
                                                                Colors.white))),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
/*Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              //Center(child: Image(image: AssetImage("images/sci.jfif"),height: 120,width: 150)),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey),
                                width: 175,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Course Title",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Candara",
                                              color: Colors.black)),
                                      Text("23 min- 4 parts",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: "Candara",
                                              color: Colors.white)),
                                      SizedBox(height: 10),
                                      Center(
                                        child: RaisedButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {},
                                          color: Colors.teal,
                                          child: (Text("Start",
                                              style: TextStyle(
                                                  fontSize: 15,
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
                        ),*/
                                ],
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 10),
                      /*SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              //Center(child: Image(image: AssetImage("images/sci.jfif"),height: 120,width: 150)),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey),
                                width: 175,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Course Title",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Candara",
                                              color: Colors.black)),
                                      Text("23 min- 4 parts",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: "Candara",
                                              color: Colors.white)),
                                      SizedBox(height: 10),
                                      Center(
                                        child: RaisedButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {},
                                          color: Colors.teal,
                                          child: (Text("Start",
                                              style: TextStyle(
                                                  fontSize: 15,
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
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              //Center(child: Image(image: AssetImage("images/sci.jfif"),height: 120,width: 150)),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey),
                                width: 175,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Course Title",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Candara",
                                              color: Colors.black)),
                                      Text("23 min- 4 parts",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: "Candara",
                                              color: Colors.white)),
                                      SizedBox(height: 10),
                                      Center(
                                        child: RaisedButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {},
                                          color: Colors.teal,
                                          child: (Text("Start",
                                              style: TextStyle(
                                                  fontSize: 15,
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
                        )
                      ],
                    ),
                  ),*/
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

/**/
