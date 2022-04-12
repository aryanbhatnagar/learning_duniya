import 'package:flutter/cupertino.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:flutter/material.dart';
import 'package:learning_duniya/SignUp.dart';
import 'package:learning_duniya/globals.dart';
import 'package:learning_duniya/landing.dart';
import 'package:shared_preferences/shared_preferences.dart';
class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}
class _IntroScreenState extends State<IntroScreen>
{
  List <Slide> slides = [];

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token')!;
      userName=prefs.getString('username')!;
      ROLE=prefs.getString('role')!;
    });

  }

  @override
  void initState() {
    super.initState();
    _incrementCounter();
    slides.add(
      new Slide(
        //title: "ERASER",
        description: "\n\n\n\n1. Ye indulgence unreserved connection alteration appearance. this is sample text.",
        styleDescription:
        TextStyle(color: Colors.black, fontSize: 25.0, fontFamily: 'Candara'),
        backgroundImage: "images/slider.png",
        backgroundOpacity: 0,

      ),
    );
    slides.add(
      new Slide(
        //title: "PENCIL",
        description: "\n\n\n\n2. Ye indulgence unreserved connection alteration appearance. this is sample text.",
        styleDescription:
        TextStyle(color: Colors.black, fontSize: 25.0, fontFamily: 'Candara'),
        backgroundImage: "images/slider.png",
        backgroundOpacity: 0,
          //backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        //title: "RULER",
        description:
        "\n\n\n\n3. Ye indulgence unreserved connection alteration appearance. this is sample text.",
        styleDescription:
        TextStyle(color: Colors.black, fontSize: 25.0, fontFamily: 'Candara'),
        backgroundImage: "images/slider.png",
        backgroundOpacity: 0,
        //backgroundColor: Color(0xff9932CC),
      ),
    );

  }

  void onDonePress() async {
    debugPrint(token);
    debugPrint(ROLE);
    if(token!="")
      Navigator.push(context,MaterialPageRoute(builder: (context)=>landing()));
    // Do what you want
    else
    Navigator.pushReplacementNamed(context, "Landing");
    print("End of slides");
  }

  @override
  Widget build(BuildContext context) {


    return new IntroSlider(
      slides: this.slides,
      colorDot: Colors.teal,
      nextButtonStyle: ButtonStyle(

          backgroundColor: MaterialStateProperty.all<Color>(Colors.teal)
      ),
      colorActiveDot: Colors.teal[900],
      doneButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.teal)
      ) ,
      skipButtonStyle: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.teal)
      ),
      onDonePress: this.onDonePress,
    );
  }
}


