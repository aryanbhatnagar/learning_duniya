import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:group_button/group_button.dart';


class courseDesc extends StatelessWidget {
  const courseDesc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(25),
            height: (size.height)/3,
            width: (size.width),
            decoration: BoxDecoration(
                color: Colors.teal,
                image: DecorationImage(image: AssetImage("images/hindiass.jpg"),fit: BoxFit.fill)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text("Mentor Name",style: TextStyle(fontSize: 50,fontFamily: "Candara",color: Colors.white)),
                //SizedBox(height: 5),
                //Text("Specialization",style: TextStyle(fontSize: 30,fontFamily: "Candara",color: Colors.greenAccent))
              ],
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
                          Text("Course Name",style: TextStyle(fontSize: 35,fontFamily: "Candara",color: Colors.black)),
                          //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)

                        ],
                      ),
                      //Text("Specialization",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey)),
                      //SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person,color: Colors.teal,size: 25),
                          Text("Academy",style: TextStyle(fontSize:20,fontFamily: "Candara",color: Colors.teal)),
                          SizedBox(width: 30),
                          Icon(Icons.star,color: Colors.yellow,size: 30),
                          Text("4.8",style: TextStyle(fontSize:20,fontFamily: "Candara",color: Colors.grey))
                          //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                        ],
                      ),
                      SizedBox(height: 20),
                      Text("Description",style: TextStyle(fontSize: 22,fontFamily: "Candara",color: Colors.black)),
                      SizedBox(height: 10),
                      Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                          "when an unknown printer took a galley of type and scrambled it ",
                          style: TextStyle(fontSize:17,fontFamily: "Candara",color: Colors.grey)),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Students",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                              Text("12345",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey)),
                              SizedBox(height: 15),
                              Text("Last Update",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                              Text("Feb 2, 2021",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey)),
                            ],
                          ),
                          SizedBox(width: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Language",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                              Text("Hindi",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey)),
                              SizedBox(height: 15),
                              Text("Subtitle",style: TextStyle(fontSize:20,fontFamily: "Candara",color: Colors.black)),
                              Text("English",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey)),
                            ],
                          )
                        ],
                      ),

                      SizedBox(height: 25),
                      /*ToggleButtons(children: <Widget>[
                        Text("science"),
                        Text("hindi"),
                        Text("maths")
                      ],
                          onPressed: (int index){
                            setState(() {
                              for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                                if (buttonIndex == index) {
                                  isSelected[buttonIndex] = true;
                                } else {
                                  isSelected[buttonIndex] = false;
                                }
                              }
                            });
                          },
                          isSelected:isSelected,
                          borderColor: Colors.transparent,
                          borderWidth: 5,
                          fillColor: Colors.teal,
                      selectedColor: Colors.white,
                      splashColor: Colors.teal,
                      selectedBorderColor: Colors.teal,
                      textStyle: TextStyle(
                          fontFamily: "Candara",
                          fontSize: 16)
                      ),*/
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Center(
                              child: GroupButton(
                                  controller: controller,
                                  buttons: ['Curriculum','Pick to study'],
                                  onSelected: (i, selected)
                                  {}

                                  ,
                                  selectedTextStyle: const TextStyle(
                                      fontFamily: "Candara",
                                      fontSize: 20,
                                      color: Colors.white),
                                  unselectedTextStyle: const TextStyle(
                                      fontFamily: "Candara",
                                      fontSize: 20,
                                      color: Colors.black),
                                  unselectedColor: Colors.transparent,
                                  selectedColor: Colors.teal,
                                  selectedShadow: const <BoxShadow>[BoxShadow(color: Colors.transparent)],
                                  unselectedShadow: const <BoxShadow>[BoxShadow(color: Colors.transparent)],
                                  borderRadius: BorderRadius.circular(5.0)
                              ),
                            ),
                          ],
                        ),
                      ),
                     /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Courses by mentor",style: TextStyle(fontFamily: "Candara",fontSize: 25,color: Colors.black)),
                          GestureDetector(child: Text("See all",style: TextStyle(fontSize: 20,color: Colors.blue,fontFamily: "Candara")))
                        ],
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  //Center(child: Image(image: AssetImage("images/sci.jfif"),height: 120,width: 150)),
                                  Container(
                                    decoration:BoxDecoration(
                                        borderRadius:BorderRadius.circular(10),
                                        color: Colors.grey),
                                    width: 175,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Course Title",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                          Text("23 min- 4 parts",style: TextStyle(fontSize: 17, fontFamily: "Candara",color: Colors.white)),
                                          SizedBox(height: 10),
                                          Center(
                                            child: RaisedButton(
                                              padding: EdgeInsets.zero,
                                              onPressed:(){},
                                              color: Colors.teal,
                                              child: (Text("Start",style: TextStyle(fontSize: 15,fontFamily: "Candara",color: Colors.white))),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),

                            ),
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  //Center(child: Image(image: AssetImage("images/sci.jfif"),height: 120,width: 150)),
                                  Container(
                                    decoration:BoxDecoration(
                                        borderRadius:BorderRadius.circular(10),
                                        color: Colors.grey),
                                    width: 175,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Course Title",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                          Text("23 min- 4 parts",style: TextStyle(fontSize: 17, fontFamily: "Candara",color: Colors.white)),
                                          SizedBox(height: 10),
                                          Center(
                                            child: RaisedButton(
                                              padding: EdgeInsets.zero,
                                              onPressed:(){},
                                              color: Colors.teal,
                                              child: (Text("Start",style: TextStyle(fontSize: 15,fontFamily: "Candara",color: Colors.white))),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),

                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  //Center(child: Image(image: AssetImage("images/sci.jfif"),height: 120,width: 150)),
                                  Container(
                                    decoration:BoxDecoration(
                                        borderRadius:BorderRadius.circular(10),
                                        color: Colors.grey),
                                    width: 175,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Course Title",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                          Text("23 min- 4 parts",style: TextStyle(fontSize: 17, fontFamily: "Candara",color: Colors.white)),
                                          SizedBox(height: 10),
                                          Center(
                                            child: RaisedButton(
                                              padding: EdgeInsets.zero,
                                              onPressed:(){},
                                              color: Colors.teal,
                                              child: (Text("Start",style: TextStyle(fontSize: 15,fontFamily: "Candara",color: Colors.white))),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),

                            ),
                            Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                              elevation: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  //Center(child: Image(image: AssetImage("images/sci.jfif"),height: 120,width: 150)),
                                  Container(
                                    decoration:BoxDecoration(
                                        borderRadius:BorderRadius.circular(10),
                                        color: Colors.grey),
                                    width: 175,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Course Title",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                          Text("23 min- 4 parts",style: TextStyle(fontSize: 17, fontFamily: "Candara",color: Colors.white)),
                                          SizedBox(height: 10),
                                          Center(
                                            child: RaisedButton(
                                              padding: EdgeInsets.zero,
                                              onPressed:(){},
                                              color: Colors.teal,
                                              child: (Text("Start",style: TextStyle(fontSize: 15,fontFamily: "Candara",color: Colors.white))),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),

                            )
                          ],
                        ),
                      ),*/

                    ],
                  )
              ),

            ),
          )

        ],
      ),
    );
  }
}
