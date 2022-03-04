import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:group_button/group_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_duniya/quiz.dart';

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

  int id;
  int bookId;
  String chapterName;
  String mediaFile;
  dynamic fileName;
  String about;
  String syllabus;
  String description;
  int lifespan;
  String language;
  int price;
  int salePrice;
  int onSale;
  int featured;
  String status;
  int school;
  int createdBy;
  int updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic pdfFile;
  dynamic pdfFileName;
  String pdfFile1;
  String pdfFileName1;

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
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    required this.url,
    required this.fileName,
  });

  int id;
  String title;
  String url;
  String fileName;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["id"],
    title: json["title"],
    url: json["url"],
    fileName: json["file_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "url": url,
    "file_name": fileName,
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

class courseDesc extends StatelessWidget {
  String Chap;

  courseDesc(this.Chap); //const courseDesc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    final controller = GroupButtonController();
    List<bool> isSelected=[false,false,false];

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
                  height: (size.height)/3,
                  width: (size.width),
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      image: DecorationImage(image: AssetImage("images/hindiass.jpg"),fit: BoxFit.fill)
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                    height: (size.height)-(size.height)/4,
                    width: (size.width),
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(34)),
                    child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(child: Text(k12!.data.chapterDetails.chapterName,style: TextStyle(fontSize: 35,fontFamily: "Candara",color: Colors.black))),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.person,color: Colors.teal,size: 25),
                                Text("Academy",style: TextStyle(fontSize:20,fontFamily: "Candara",color: Colors.teal)),
                                SizedBox(width: 30),
                                Icon(Icons.star,color: Colors.yellow,size: 30),
                                Text("4.8",style: TextStyle(fontSize:20,fontFamily: "Candara",color: Colors.grey))
                           ],
                            ),
                            SizedBox(height: 20),
                            Text("Description",style: TextStyle(fontSize: 22,fontFamily: "Candara",color: Colors.black)),
                            SizedBox(height: 10),
                            Text(k12!.data.chapterDetails.description,style: TextStyle(fontSize:17,fontFamily: "Candara",color: Colors.grey)),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Price",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                    Text("${k12.data.chapterDetails.price}",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey)),
                                    SizedBox(height: 15),
                                    Text("Sale Price",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                    Text("${k12.data.chapterDetails.salePrice}",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey)),
                                  ],
                                ),
                                SizedBox(width: 30),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Language",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                    Text("${k12.data.chapterDetails.language}",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey)),
                                    SizedBox(height: 15),
                                    Text("Status",style: TextStyle(fontSize:20,fontFamily: "Candara",color: Colors.black)),
                                    Text("${k12.data.chapterDetails.status}",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey)),
                                  ],
                                )
                              ],
                            ),

                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: 10,),
                                Text("Curriculum",style: TextStyle(fontSize: 22,fontFamily: "Candara",color: Colors.black)),
                                Center(
                                  child: RaisedButton(
                                    onPressed: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => quiz(1)));
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
                                SizedBox(width: 20,),
                              ],
                            ),
                            SizedBox(height: 10),
                            for(int i=0; i<k12.data.videos.length; i++)
                              GestureDetector(
                                onTap: () {

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
                                                child: Text(k12.data.videos[i].title,
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

