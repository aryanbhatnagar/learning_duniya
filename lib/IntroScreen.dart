import 'package:flutter/cupertino.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}
class _IntroScreenState extends State<IntroScreen>
{
  List <Slide> slides = [];

  @override
  void initState() {
    super.initState();

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

  void onDonePress() {
    // Do what you want
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


