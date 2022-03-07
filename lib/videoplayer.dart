import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';


class video extends StatefulWidget {
  late String  url;
  late String name;

  video(this.url,this.name); //const video({Key? key}) : super(key: key);

  @override
  _videoState createState() => _videoState(url,name);
}

class _videoState extends State<video> {
  late String _url;
  late String _name;
  _videoState(this._url,this._name);


  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://www.videolinks.com/pub/media/videolinks/video/hero10.mp4');
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        appBar: AppBar(
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
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(_name,style: TextStyle(fontFamily: "Candara",fontSize: 25),maxLines: 2,overflow: TextOverflow.ellipsis),
              )
            ],
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
          alignment: Alignment.topLeft,
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
