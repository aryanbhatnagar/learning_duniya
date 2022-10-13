import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart';
import 'landing.dart';

Winner winnerFromJson(String str) => Winner.fromJson(json.decode(str));
String winnerToJson(Winner data) => json.encode(data.toJson());

class Winner {
  Winner({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  int status;

  factory Winner.fromJson(Map<String, dynamic> json) => Winner(
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
    required this.student1,
    required this.student2,
  });

  Student student1;
  Student student2;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    student1: Student.fromJson(json["student1"]),
    student2: Student.fromJson(json["student2"]),
  );

  Map<String, dynamic> toJson() => {
    "student1": student1.toJson(),
    "student2": student2.toJson(),
  };
}
class Student {
  Student({
    this.name,
    this.img,
    this.result,
  });

  var name;
  var img;
  var result;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    name: json["name"],
    img: json["img"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "img": img,
    "result": result,
  };
}

Future<Winner> getWinner(String chal_id) async {
  final String apiUrl =
      "${BASE}api/challenge/winner";
  final response = await http.post(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  }, body: {"challenge_id": chal_id});

  if (response.statusCode == 200) {
    print(response.statusCode.toString());
    final String responseString = response.body;
    debugPrint(response.body);
    return winnerFromJson(responseString);
  } else {
    throw Exception('Failed to load album');
  }
}

class winnerClass extends StatefulWidget {
  //const winnerClass({Key? key}) : super(key: key);

  var chal_id;

  winnerClass(this.chal_id);

  @override
  State<winnerClass> createState() => _winnerClassState(chal_id);
}

var s1=70,s2=60;
var sf1=20,sf2=15;
String result_text="";

class _winnerClassState extends State<winnerClass> {

  var chal_id;

  _winnerClassState(this.chal_id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getWinner(chal_id.toString()),
        builder: (context,AsyncSnapshot<Winner> snapshot1) {
          if (snapshot1.hasData)
            {debugPrint("hula");
            if(snapshot1.data!.data.student1.result==snapshot1.data!.data.student2.result)
              {
                result_text="It's a TIE !!";
                s1=s2;
                sf1=sf2;
              }
            else if(snapshot1.data!.data.student1.result>snapshot1.data!.data.student2.result)
            {
              result_text="${snapshot1.data!.data.student1.name} WON !!";
              s1=70;
              s2=60;
              sf1=20;
              sf2=15;
            }
            else if(snapshot1.data!.data.student1.result<snapshot1.data!.data.student2.result)
            {
              result_text="${snapshot1.data!.data.student2.name} WON !!";
              s1=60;
              s2=70;
              sf1=15;
              sf2=20;
            }
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.teal,
                child: SingleChildScrollView(
                    child:Column(
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          'RESULTS',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        Text(
                          result_text,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 25,),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "${snapshot1.data!.data.student1.name}",
                                    style: TextStyle(
                                        fontSize: sf1.toDouble(),
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Stack(
                                    children: [

                                      CircleAvatar(backgroundColor: Colors.white24, radius: s1.toDouble()),
                                      CircleAvatar(backgroundColor: Colors.white38, radius: s1-5),
                                      CircleAvatar(backgroundColor: Colors.white60, radius: s1-10),
                                      CircleAvatar(
                                          backgroundColor:
                                          Colors.amber,
                                          backgroundImage: NetworkImage("${snapshot1.data!.data.student1.img}"),
                                        radius: s1-15,

                                      ),
                                    ],
                                  )

                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${snapshot1.data!.data.student2.name}",
                                    style: TextStyle(fontSize: sf2.toDouble(), color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Stack(
                                    children: [

                                      CircleAvatar(backgroundColor: Colors.white38, radius: s2.toDouble()),
                                      CircleAvatar(backgroundColor: Colors.white60, radius: s2-5),
                                      CircleAvatar(backgroundColor: Colors.white60, radius: s2-10),
                                      CircleAvatar(
                                        backgroundColor:
                                        Colors.amber,
                                        backgroundImage: NetworkImage("${snapshot1.data!.data.student2.img}"),
                                        radius: s2-15,

                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 100,
                              width: MediaQuery.of(context).size.width - 50,
                              child: Center(
                                child: Text(
                                  "${snapshot1.data!.data.student1.result.toString()} : ${snapshot1.data!.data.student2.result.toString()}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 197, 177),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 90,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white)),
                            onPressed: () {
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => landing()),);
                            },
                            child: Text(
                              'Continue',
                              style: TextStyle(
//fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            );}
          else
            return Container(child: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

