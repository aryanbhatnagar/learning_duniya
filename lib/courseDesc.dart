
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:group_button/group_button.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_duniya/Login2.dart';
import 'package:learning_duniya/videoplayer.dart';
import 'package:video_player/video_player.dart';
import 'package:learning_duniya/quiz.dart';
import 'package:wakelock/wakelock.dart';

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
    required this.questionTypes,
  });

  ChapterDetails chapterDetails;
  List<Video> videos;
  List<QuestionType> questionTypes;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    chapterDetails: ChapterDetails.fromJson(json["chapter_details"]),
    videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
    questionTypes: List<QuestionType>.from(json["question_types"].map((x) => QuestionType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chapter_details": chapterDetails.toJson(),
    "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    "question_types": List<dynamic>.from(questionTypes.map((x) => x.toJson())),
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
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap:() async {
                                        Future action = await _showMyDialog(context,k12!.data.chapterDetails.fileName);
                                      },
                                      child: Card(elevation: 2,child: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Icon(Icons.mic,color: Colors.red, size: 22),
                                      )),
                                    ),

                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.favorite,color: Colors.red,size: 22),
                                Text(" ${k12.data.chapterDetails.likes}",style: TextStyle(fontSize:15,fontFamily: "Candara",color: Colors.teal)),
                                SizedBox(width: 20),
                                Icon(Icons.people,color: Colors.yellow,size: 25),
                                Text(" ${k12.data.chapterDetails.visitors}",style: TextStyle(fontSize:15,fontFamily: "Candara",color: Colors.grey)),
                                SizedBox(width: 20,),
                                GestureDetector(
                                    child:Card(elevation: 2,child: Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: Icon(Icons.download_rounded,color: Colors.blue, size: 22),
                                    ))),
                                Text(" Book",style: TextStyle(fontSize:15,fontFamily: "Candara",color: Colors.grey)),
                                SizedBox(width: 20,),
                                GestureDetector(child: Card(elevation: 2,child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Icon(Icons.download_rounded,color: Colors.green, size: 22),
                                ))),
                                Text(" Soln.",style: TextStyle(fontSize:15,fontFamily: "Candara",color: Colors.grey)),

                              ],
                            ),
                            SizedBox(height: 20),
                            if(k12!.data.chapterDetails.description.toString()!="null")
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
                                  Text(" Curriculum ",style: TextStyle(fontSize: 20,fontFamily: "Candara",)),
                                  Text("      MCQ      ",style: TextStyle(fontSize: 20,fontFamily: "Candara",)),
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
                                            Wakelock.enable();
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>
                                                video(k12.data.videos[i].fileName,
                                                    k12.data.videos[i].title,
                                                    k12.data.videos[i].description,
                                                    k12.data.videos[i].id.toString(),
                                                  k12.data.videos[i].likes,
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
                              child: Column(
                                children: [
                                  for(int i=0; i<k12.data.questionTypes.length; i++)
                                    GestureDetector(
                                      onTap: () {
                                        if(token!="")
                                        {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => quiz(snapshot1.data!.data.chapterDetails.id,snapshot1.data!.data.questionTypes[i].id)));
                                        }
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
                                                      child: Text(k12.data.questionTypes[i].catName.toString(),
                                                        style: TextStyle(fontFamily: "Candara",
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text("Questions",
                                                        style: TextStyle(fontFamily: "Candara",color: Colors.grey,
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Icon(Icons.hourglass_bottom, color: Colors.deepOrange, size: 30)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
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

Future _showMyDialog(BuildContext context, String URL) async {

  Duration _duration = Duration();
  Duration _position = Duration();
  AudioPlayer audioPlayer = AudioPlayer();
  bool playing=false;

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return Dialog(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(

                  child: Text("Some Audio",style: TextStyle(fontFamily: "Candara"),)
                ),
                Slider.adaptive(
                  onChanged: (double value) {
                    setState(() {
                      audioPlayer.seek(Duration(seconds: value.toInt()));
                    });
                  },
                  min: 0.0,
                  max: _duration.inSeconds.toDouble(),
                  value: _position.inSeconds.toDouble(),
                ),
                InkWell(
                  onTap: () async {
                    var url =
                        "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/uploads/${URL}";

                    if (playing) {
                      var res = await audioPlayer.pause();
                      if (res == 1) {
                        setState(() {
                          playing = false;
                        });
                      }
                    } else {
                      var res = await audioPlayer.play(url, isLocal: true);
                      if (res == 1) {
                        setState(() {
                          playing = true;
                        });
                      }
                    }
                    audioPlayer.onDurationChanged.listen((Duration duration) {
                      setState(() {
                        _duration = duration;
                      });
                    });

                    audioPlayer.onAudioPositionChanged
                        .listen((Duration duration) {
                      setState(() {
                        _position = duration;
                      });
                    });
                  },
                  child:
                  Icon(playing == false ? Icons.play_arrow : Icons.pause),
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        );
      });
    },
  );
}

/*Future<String> downloadFile(String url, String fileName, String dir) async {
  HttpClient httpClient = new HttpClient();
  File file;
  String filePath = '';
  String myUrl = '';

  try {
    myUrl = url+'/'+fileName;
    var request = await httpClient.getUrl(Uri.parse(myUrl));
    var response = await request.close();
    if(response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      filePath = '$dir/$fileName';
      file = File(filePath);
      await file.writeAsBytes(bytes);
    }
    else
      filePath = 'Error code: '+response.statusCode.toString();
  }
  catch(ex){
    filePath = 'Can not fetch url';
  }

  return filePath;
}*/