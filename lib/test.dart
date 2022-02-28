import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  _testState createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(left: 25,top:10),
            child: Text("Hi Aryan!",
              style: TextStyle(fontSize: 17.5,color: Colors.black,fontFamily: "Candara"),),
          ),
          Container(
            padding: EdgeInsets.only(left:25,bottom: 10),
            child: Text("Choose your courses",
              style: TextStyle(fontFamily: "Candara",fontSize: 12.5,color: Colors.grey),),
          ),
          Container(
            //height: 100,
            padding: EdgeInsets.only(left: 25,right: 25,top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius:30,
                                  backgroundImage: AssetImage('images/maths.png')),
                              SizedBox(height: 5),
                              Text("MATHS",style: TextStyle(color: Colors.black,fontSize: 12.5,fontFamily: "Candara"),)
                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius:30,
                                  backgroundImage: AssetImage('images/chemistry.png')),
                              SizedBox(height: 5),
                              Text("SCIENCE",style: TextStyle(color: Colors.black,fontSize: 12.5,fontFamily: "Candara"),)
                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius:30,
                                  backgroundImage: AssetImage('images/hindi.png')),
                              SizedBox(height: 5),
                              Text("HINDI",style: TextStyle(color: Colors.black,fontSize: 12.5,fontFamily: "Candara"),)
                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                    ],


                  ),
                ),
                SizedBox(height: 7.5),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius:30,
                                  backgroundImage: AssetImage('images/english.png')),
                              SizedBox(height: 5),
                              Text("ENGLISH",style: TextStyle(color: Colors.black,fontSize: 12.5,fontFamily: "Candara"),)
                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius:30,
                                  backgroundImage: AssetImage('images/sst.png')),
                              SizedBox(height: 5),
                              Text("SST",style: TextStyle(color: Colors.black,fontSize: 12.5,fontFamily: "Candara"),)
                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius:30,
                                  backgroundImage: AssetImage('images/computer.png')),
                              SizedBox(height: 5),
                              Text("COMPUTER",style: TextStyle(color: Colors.black,fontSize: 12.5,fontFamily: "Candara"),)
                            ],
                          ),
                        ),
                        onTap: (){},
                      ),
                    ],


                  ),
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}
