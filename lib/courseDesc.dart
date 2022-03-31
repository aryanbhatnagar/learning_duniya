import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:group_button/group_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_duniya/Login2.dart';
import 'package:learning_duniya/videoplayer.dart';
import 'package:video_player/video_player.dart';
import 'package:learning_duniya/quiz.dart';

import 'Login.dart';
import 'globals.dart';

K12Chapter k12ChapterFromJson(String str) => K12Chapter.fromJson(json.decode(str));
String chapid="";
String k12ChapterToJson(K12Chapter data) => json.encode(data.toJson());

class K12Chapter {
  K12Chapter({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory K12Chapter.fromJson(Map<String, dynamic> json) => K12Chapter(
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
    required this.chapterDetails,
    required this.videos,
  });

  ChapterDetails chapterDetails;
  List<Video> videos;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    chapterDetails: ChapterDetails.fromJson(json["chapter_details"]),
    videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chapter_details": chapterDetails.toJson(),
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
  };
}

class ChapterDetails {
  ChapterDetails({
     required this.id,
    required this.bookId,
    required this.chapterName,
    required this.mediaFile,
    required this.fileName,
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
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.pdfFile,
    required this.pdfFileName,
    required this.pdfFile1,
    required this.pdfFileName1,
  });

   var id;
   var bookId;
   var chapterName;
   var mediaFile;
   dynamic fileName;
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
  var createdBy;
  var updatedBy;
  var createdAt;
  var updatedAt;
  dynamic pdfFile;
  dynamic pdfFileName;
  var pdfFile1;
  var pdfFileName1;

  factory ChapterDetails.fromJson(Map<String, dynamic> json) => ChapterDetails(
    id: json["id"],
    bookId: json["book_id"],
    chapterName: json["chapter_name"],
    mediaFile: json["media_file"],
    fileName: json["file_name"],
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
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    pdfFile: json["pdf_file"],
    pdfFileName: json["pdf_file_name"],
    pdfFile1: json["pdf_file1"],
    pdfFileName1: json["pdf_file_name1"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "book_id": bookId,
    "chapter_name": chapterName,
    "media_file": mediaFile,
    "file_name": fileName,
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
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "pdf_file": pdfFile,
    "pdf_file_name": pdfFileName,
    "pdf_file1": pdfFile1,
    "pdf_file_name1": pdfFileName1,
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
  var visitors;
  var likes;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    fileName: json["file_name"],
    visitors: json["visitors"],
    likes: json["likes"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "file_name": fileName,
    "visitors": visitors,
    "likes": likes
  };
}

Future<K12Chapter> createK12(String id) async {
  final String apiUrl =
      "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/chapter/details";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "book_id": id
  }
  );

  if (response.statusCode == 200) {
    final String responseString = response.body;
    return k12ChapterFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

String img2="";

class courseDesc extends StatelessWidget {
  String Chap;
  String Img2;

  courseDesc(this.Chap,this.Img2); //const courseDesc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    img2=Img2;
    chapid=Chap;
    return MaterialApp(
      home: courseDescPage(),
    );
  }
}


class courseDescPage extends StatefulWidget {
  const courseDescPage({Key? key}) : super(key: key);

  @override
  _courseDescPageState createState() => _courseDescPageState();
}

class _courseDescPageState extends State<courseDescPage> {
  bool curr_vis=true,mcq_vis=false;
  List<bool> isSelected = List.generate(2, (index) => false);
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    final controller = GroupButtonController();


    return Scaffold(
      body: FutureBuilder(
        future: createK12(chapid),
        builder: (context, AsyncSnapshot<K12Chapter> snapshot1) {
          if (snapshot1.hasData) {
            K12Chapter? k12 = snapshot1.data;
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(25),
                  height: (size.height)/2.70,
                  width: (size.width),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      image: DecorationImage(image: NetworkImage(img2),fit: BoxFit.fill)
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                    height: (size.height)-(size.height)/3,
                    width: (size.width),
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(34)),
                    child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child: Text(k12!.data.chapterDetails.chapterName,style: TextStyle(fontSize: 22,fontFamily: "Candara",color: Colors.black))),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.person,color: Colors.teal,size: 22),
                                Text("Academy",style: TextStyle(fontSize:15,fontFamily: "Candara",color: Colors.teal)),
                                SizedBox(width: 30),
                                Icon(Icons.star,color: Colors.yellow,size: 25),
                                Text("4.8",style: TextStyle(fontSize:15,fontFamily: "Candara",color: Colors.grey))
                           ],
                            ),
                            SizedBox(height: 20),
                            Text("Description",style: TextStyle(fontSize: 18,fontFamily: "Candara",color: Colors.black)),
                            SizedBox(height: 10),
                            Text(k12!.data.chapterDetails.description.toString(),style: TextStyle(fontSize:15,fontFamily: "Candara",color: Colors.grey)),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Icon(Icons.monetization_on,color: Colors.orange,size: 20),
                                        Text(" Price",style: TextStyle(fontSize: 16,fontFamily: "Candara",color: Colors.black)),
                                      ],
                                    ),
                                    Text("     ${k12.data.chapterDetails.price.toString()}",style: TextStyle(fontSize: 16,fontFamily: "Candara",color: Colors.grey)),
                                    SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Icon(Icons.money_off_csred_rounded,color: Colors.green,size: 20),
                                        Text(" Sale Price",style: TextStyle(fontSize: 16,fontFamily: "Candara",color: Colors.black)),
                                      ],
                                    ),
                                    Text("     ${k12.data.chapterDetails.salePrice.toString()}",style: TextStyle(fontSize: 16,fontFamily: "Candara",color: Colors.grey)),
                                  ],
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Icon(Icons.language,color: Colors.teal,size: 20),
                                        Text("  Language",style: TextStyle(fontSize: 16,fontFamily: "Candara",color: Colors.black)),
                                      ],
                                    ),
                                    Text("      ${k12.data.chapterDetails.language.toString()}",style: TextStyle(fontSize: 16,fontFamily: "Candara",color: Colors.grey)),
                                    SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Icon(Icons.network_check,color: Colors.teal,size: 20),
                                        Text(" Status",style: TextStyle(fontSize:16,fontFamily: "Candara",color: Colors.black)),
                                      ],
                                    ),
                                    Text("      ${k12.data.chapterDetails.status.toString()}",style: TextStyle(fontSize: 16,fontFamily: "Candara",color: Colors.grey)),
                                  ],
                                )
                              ],
                            ),

                            SizedBox(height: 25),
                            Center(
                              child: ToggleButtons(

                                children: <Widget>[
                                  Text(" Curriculum ",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                  Text("      MCQ      ",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                ],
                                selectedBorderColor: Colors.teal,
                                selectedColor: Colors.white,
                                borderColor: Colors.grey,
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
                                      if(index==0)
                                        {
                                          curr_vis=true;
                                          mcq_vis=false;
                                        }
                                      if(index==1)
                                      {
                                        curr_vis=false;
                                        mcq_vis=true;
                                      }
                                    }
                                  });
                                },
                                isSelected: isSelected,
                              ),
                            ),

                            SizedBox(height: 10),
                            Visibility(
                              visible: curr_vis,
                              child: Column(
                                children: [
                                  for(int i=0; i<k12.data.videos.length; i++)
                                    GestureDetector(
                                      onTap: () {
                                        if(token!="")
                                          {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                video(k12.data.videos[i].fileName,
                                                    k12.data.videos[i].title,
                                                    k12.data.videos[i].description,
                                                    k12.data.videos[i].id.toString(),
                                                  k12.data.videos[i].likes.toString(),
                                                  k12.data.videos[i].visitors.toString()
                                                )));}
                                        else
                                          Navigator.push(
                                              context, MaterialPageRoute(builder: (context) => Login2()));
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
                                                      child: Text(k12.data.videos[i].title.toString(),
                                                        style: TextStyle(fontFamily: "Candara",
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text("Video",
                                                        style: TextStyle(fontFamily: "Candara",color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Icon(Icons.play_arrow_rounded, color: Colors.green, size: 30)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: mcq_vis,
                              child: Center(
                                child: RaisedButton(
                                  onPressed: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => quiz(snapshot1.data!.data.chapterDetails.id)));
                                  },
                                  child: Text('MCQ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30.0,
                                          fontFamily: "Candara")),
                                  color: Colors.deepOrange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),




                          ],
                        )
                    ),

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

