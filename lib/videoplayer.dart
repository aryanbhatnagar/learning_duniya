import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:learning_duniya/Dashboard.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'globals.dart';
import 'package:wakelock/wakelock.dart';
import 'package:chewie/chewie.dart';

Videolike videolikeFromJson(String str) => Videolike.fromJson(json.decode(str));
String videolikeToJson(Videolike data) => json.encode(data.toJson());
var dispLike=0;
var like=0;
var video_id="";
var count =0;
class Videolike {
  Videolike({
    required this.message,
    required this.status,
  });

  String message;
  int status;

  factory Videolike.fromJson(Map<String, dynamic> json) => Videolike(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
Future<Videolike> createVideovisit(String id) async {
  final String apiUrl =
      "${BASE}api/book_video/like";

  final response = await http.post(Uri.parse(apiUrl),headers: <String, String> {
    "Authorization": "Bearer $token",
  },
      body: {"id":id});

  if (response.statusCode == 200) {
    like=1;
    final String responseString = response.body;
    return videolikeFromJson(responseString);
  } else {
    print(id.toString());
    print(response.statusCode.toString());
    throw Exception("failed");
  }
}
Future<Videolike> createVideolike(String id) async {
  final String apiUrl =
      "${BASE}api/book_video/visitor";

  final response = await http.post(Uri.parse(apiUrl),headers: <String, String> {
    "Authorization": "Bearer $token",
  },
      body: {"id":id});

  if (response.statusCode == 200) {
    like=1;
    final String responseString = response.body;
    return videolikeFromJson(responseString);
  } else {
    print(id.toString());
    print(response.statusCode.toString());
    throw Exception("failed");
  }
}

class video extends StatefulWidget {
  late String  url;
  late String name;
  late String vid;
  late String description;
  late int like;
  late String visit;
  video(this.url,this.name,this.description,this.vid,this.like,this.visit); //const video({Key? key}) : super(key: key);

  @override
  _videoState createState() => _videoState(url,name,description,vid,like,visit);
}

class _videoState extends State<video> {
  late String _url;
  late String _name;
  late String _vid;
  late String _description;
  late int _like;
  late String _visit;
  _videoState(this._url,this._name,this._description,this._vid,this._like,this._visit);


  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  double _aspectRatio = 16 / 9;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(_url);
        _controller.addListener(() {
     setState(() {
     });
    });
    _controller.setLooping(true);
    _controller.setVolume(1);
    _controller.initialize().then((_) => setState(() {}));
   _controller.play();

  }

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    dispLike=_like;
    video_id=_vid;
    if (count==0) {
      createVideolike(video_id);
      count++;

    }
    Future.delayed(Duration(seconds: 10));
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
       /* appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.pop(context); },),
            title: Text(_name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Candara",
                    fontSize: 15),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,)
        )*/
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: 7/5,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[

                              VideoPlayer(_controller),
                              _ControlsOverlay(controller: _controller),
                              VideoProgressIndicator(_controller, allowScrubbing: true),
                            ],
                          )
                  )
                      :Container(
                    child: Center(child: CircularProgressIndicator(color: Colors.teal,),),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text(_name,style: TextStyle(fontFamily: "Candara",fontSize: 20),maxLines: 2,overflow: TextOverflow.ellipsis)),
                      FavoriteButton(
                        iconSize: 40,
                        isFavorite: false,
                        valueChanged: (_isFavorite) async {
                          if(_isFavorite==true){
                            Videolike Abc=await createVideovisit(video_id);
                            if(like==1)
                              print("video like successfull");
                            setState(() {
                              dispLike++;
                            });
                          }
                          else
                            setState(() {
                              dispLike--;
                            });

                          print('Is Favorite : $_isFavorite');
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.favorite,color: Colors.red,size: 22),
                      Text(dispLike.toString(),style: TextStyle(fontSize:15,fontFamily: "Candara",color: Colors.teal)),
                      SizedBox(width: 30),
                      Icon(Icons.play_arrow_rounded,color: Colors.blue,size: 27),
                      Text(_visit.toString(),style: TextStyle(fontSize:15,fontFamily: "Candara",color: Colors.grey))
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(10,10,10,0),
                child: Text(_description,style: TextStyle(fontFamily: "Candara",fontSize: 16,color: Colors.grey)),),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),

      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration(milliseconds: 0),
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
            color: Colors.black26,
            child: const Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
                semanticLabel: 'Play',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              padding:EdgeInsets.all(5) ,
              child: Text(
                  "${controller.value.position.inMinutes}:${(controller.value.position.inSeconds)%60}/"
                      "${controller.value.duration.inMinutes}:${(controller.value.duration.inSeconds)%60}"),
            ),
          ),
        ),
        /*Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),*/
        Align(
          alignment: Alignment.bottomRight,
          child: PopupMenuButton<double>(
            color: Colors.white,
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x',style: TextStyle(fontSize: 15,fontFamily: "Candara"),),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 10,
                horizontal: 10,
              ),
              child: Container(
                  decoration:BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  padding:EdgeInsets.all(5),
                  child: Text('${controller.value.playbackSpeed}x')),
            ),
          ),
        ),
      ],
    );
  }
}
