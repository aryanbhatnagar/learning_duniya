import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';

import 'need_help_page.dart';

class mentor extends StatelessWidget {
  const mentor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: mentorpage(),
    );
  }
}

class mentorpage extends StatefulWidget {
  const mentorpage({Key? key}) : super(key: key);

  @override
  _mentorpageState createState() => _mentorpageState();
}

class _mentorpageState extends State<mentorpage> {

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(25),
            height: (size.height)/3,
            width: (size.width),
            decoration: BoxDecoration(
              color: Colors.teal,
             image: DecorationImage(image: AssetImage("images/mentor1.PNG"),fit: BoxFit.fill)
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
                        Text("Mentor Name",style: TextStyle(fontSize: 35,fontFamily: "Candara",color: Colors.black)),
                        //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                        FavoriteButton(
                          iconSize: 50,

                          isFavorite: false,
                          // iconDisabledColor: Colors.white,
                          valueChanged: (_isFavorite) {
                            print('Is Favorite : $_isFavorite');
                          },
                        )
                      ],
                    ),
                    Text("Specialization",style: TextStyle(fontSize: 25,fontFamily: "Candara",color: Colors.teal)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.favorite,color: Colors.red,size: 25),
                        Text("1234 likes",style: TextStyle(fontSize:20,fontFamily: "Candara",color: Colors.grey)),
                        SizedBox(width: 30),
                        Icon(Icons.play_arrow,color: Colors.lightBlueAccent,size: 30),
                        Text("10 courses",style: TextStyle(fontSize:20,fontFamily: "Candara",color: Colors.grey))
                        //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                      ],
                    ),
                    SizedBox(height: 20),
                    Text("About Mentor",style: TextStyle(fontSize: 25,fontFamily: "Candara",color: Colors.black)),
                    SizedBox(height: 10),
                    Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                        "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                        "when an unknown printer took a galley of type and scrambled it ",
                        style: TextStyle(fontSize:17,fontFamily: "Candara",color: Colors.grey)),
                    SizedBox(height: 10),


                    Row(
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
                                        Center(child: Text("Ask any Question",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black))),
                                        //Text("23 min- 4 parts",style: TextStyle(fontSize: 17, fontFamily: "Candara",color: Colors.white)),
                                        SizedBox(height: 10),
                                        Center(
                                          child: RaisedButton(
                                            padding: EdgeInsets.zero,
                                            onPressed:() {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return need_help_page(
                                                      name: 'Profile Name',
                                                      items1: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                                                      items2: ['Item 1',
                                                        'Item 2',
                                                        'Item 3',
                                                      ],
                                                      category: ['Cat 1', 'Cat 2', 'Cat 3'],
                                                    );
                                                  },
                                                ),
                                              );
                                            },
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
                    ),

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

