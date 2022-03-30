import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:learning_duniya/Dashboard.dart';
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

  var id;
  var eduName;
  var specilization;
  var aboutUs;
  var phone;
  var country;
  var state;
  var city;
  var reviews;
  var likes;
  var img;
  var createdAt;
  var updatedAt;
  var status;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
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
    updatedAt: json["updated_at"],
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
    "updated_at": updatedAt,
    "status": status,
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
      asses.add(GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => quiz(1)));
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
                  child: Image(
                      image: AssetImage("images/hindiass.jpg"),
                      height: 120,
                      width: 150,
                      fit: BoxFit.fitWidth)),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                child: Container(
                  //width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hindi Assessment",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "Candara",
                              color: Colors.black)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("\$1234",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Candara",
                                  color: Colors.red)),
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


    List<Widget> card = <Widget>[];

    if (code == 1) card = pop_c;
    if (code == 2) card = asses;
    if (code == 3) card = comp_e;
    //if (code == 4) card = mento;


      return Scaffold(
        body: FutureBuilder(
          future: getAsses(),
            builder: (context, AsyncSnapshot<Asses> snapshot){
              if(snapshot.hasData){
                if(mento.isEmpty)
                  for (var i = 0; i < snapshot.data!.data.mentors.length; i++)
                    mento.add(GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => mentor(snapshot.data!.data.mentors[i].id)));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: NetworkImage("http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/uploads/${snapshot.data!.data.mentors[i].img.toString()}"),
                            width: 130,
                            height: 140,
                            fit: BoxFit.scaleDown,
                          ),
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
                                      Text(snapshot.data!.data.mentors[i].eduName.toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontFamily: "Candara",
                                              color: Colors.black)),
                                      //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data!.data.mentors[i].specilization.toString(),
                                          style: TextStyle(
                                              fontSize: 14,
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
        ));

  }
}

