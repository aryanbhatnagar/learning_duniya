import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart';
import 'k12details.dart';

var subId = "2";
var _subname="";

K12BookList k12BookListFromJson(String str) => K12BookList.fromJson(json.decode(str));
String k12BookListToJson(K12BookList data) => json.encode(data.toJson());

class K12BookList {
  K12BookList({
    this.success,
    required this.data,
    this.message,
  });

  var success;
  Data data;
  var message;

  factory K12BookList.fromJson(Map<String, dynamic> json) => K12BookList(
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
  });

  List<K12> k12;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    k12: List<K12>.from(json["k12"].map((x) => K12.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "k12": List<dynamic>.from(k12.map((x) => x.toJson())),
  };
}
class K12 {
  K12({
    this.id,
    this.courseName,
    this.img,
    this.chapter,
  });

  var id;
  var courseName;
  var img;
  var chapter;

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

Future<K12BookList> getMentorApi(String cls, String sub) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/getk12";
  final response = await http.post(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  }, body: {"class_id": cls, "subject_id": sub});

  if (response.statusCode == 200) {
    print(response.statusCode.toString());
    final String responseString = response.body;
    debugPrint(response.body);
    return k12BookListFromJson(responseString);
  } else {
    throw Exception('Failed to load album');
  }
}

class k12Subject1 extends StatelessWidget{
  late String sub;
  late String subname;

  k12Subject1(this.sub,this.subname);

  @override
  Widget build(BuildContext context) {
    subId = sub.toString();
    _subname=subname.toString();
    return MaterialApp(
      home: k12SubjectList(),
    );
  }
}

class k12SubjectList extends StatefulWidget {
  k12SubjectList({Key? key}) : super(key: key);

  @override
  State<k12SubjectList> createState() => _k12SubjectListState();
}

class _k12SubjectListState extends State<k12SubjectList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('${_subname}', style: TextStyle(
          fontFamily: 'Candara',
        ),),
      ),
      body: FutureBuilder(
        future: getMentorApi(classId.toString(), subId),
        builder: (context, AsyncSnapshot<K12BookList> snapshot) {
          if(snapshot.hasData){
            if(snapshot.data!.data.k12.length>0)
              return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        for(var i=0;i<snapshot.data!.data.k12.length;i++)
                          GestureDetector(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => k12_det(snapshot.data!.data.k12[i].id.toString(),"images/english.png")));

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
                                      NetworkImage('${snapshot.data!.data.k12[i].img.toString()}')),
                                  SizedBox(height: 10),
                                  Text(
                                    "${snapshot.data!.data.k12[i].courseName}",
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
                  ),
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
      drawer: Drawer(
        elevation: 5,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}