import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class courses extends StatelessWidget {
  const courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: coursepage(),
          ),
        )
    );
  }
}


class coursepage extends StatefulWidget {
  const coursepage({Key? key}) : super(key: key);

  @override
  _coursepageState createState() => _coursepageState();
}

class _coursepageState extends State<coursepage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 25),
                decoration: new BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("START LEARNING",style: TextStyle(fontSize: 25,fontFamily: "Candara",color: Colors.white)),
                      Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart),iconSize:30,color:Colors.white,visualDensity: VisualDensity.standard),
                          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_active),color:Colors.white,iconSize:30,visualDensity: VisualDensity.standard)
                        ],
                      ),
                      ],
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,

                        enabledBorder:OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white,width: 2.0),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        labelText: 'Search',
                        labelStyle: TextStyle(fontFamily: "Candara",color: Colors.white),
                        prefixIcon: Icon(Icons.search,color: Colors.white),
                        //fillColor: Colors.grey,
                        focusColor: Colors.white,
                      ),
                      )
                ],
              ),
            ),
            SizedBox(height: 15),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Popular Courses",style: TextStyle(fontFamily: "Candara",fontSize: 20,color: Colors.black)),
                GestureDetector(child: Text("See all",style: TextStyle(fontSize: 20,color: Colors.blue,fontFamily: "Candara")))
              ],
            ),
            SizedBox(height: 15),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: <Widget>[
                      Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image(image: AssetImage("images/hindi.png"),height: 120,width: 150),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,5,8,5),
                              child: Container(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Course Title",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        IconButton(onPressed:(){}, icon:Icon(Icons.person,size: 20,color: Colors.grey)),
                                        Text("Name",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey))
                                      ],

                                    ),
                                    Text("Price",style: TextStyle(fontSize: 20, fontFamily: "Candara",color: Colors.red))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                      Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image(image: AssetImage("images/computer.png"),height: 120,width: 150),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,5,8,5),
                              child: Container(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Course Title",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        IconButton(onPressed:(){}, icon:Icon(Icons.person,size: 20,color: Colors.grey)),
                                        Text("Name",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey))
                                      ],

                                    ),
                                    Text("Price",style: TextStyle(fontSize: 20, fontFamily: "Candara",color: Colors.red))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                      Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image(image: AssetImage("images/sst.png"),height: 120,width: 150),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,5,8,5),
                              child: Container(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Course Title",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        IconButton(onPressed:(){}, icon:Icon(Icons.person,size: 20,color: Colors.grey)),
                                        Text("Name",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey))
                                      ],

                                    ),
                                    Text("Price",style: TextStyle(fontSize: 20, fontFamily: "Candara",color: Colors.red))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                      Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Image(image: AssetImage("images/chemistry.png"),height: 120,width: 150),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,5,8,5),
                              child: Container(
                                width: 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Course Title",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        IconButton(onPressed:(){}, icon:Icon(Icons.person,size: 20,color: Colors.grey)),
                                        Text("Name",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.grey))
                                      ],

                                    ),
                                    Text("Price",style: TextStyle(fontSize: 20, fontFamily: "Candara",color: Colors.red))
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                    ]
                )
            ),
            SizedBox(height: 50),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Categories",style: TextStyle(fontFamily: "Candara",fontSize: 20,color: Colors.black)),
                GestureDetector(child: Text("See all",style: TextStyle(fontSize: 20,color: Colors.blue,fontFamily: "Candara")))
              ],
            ),
            SizedBox(height: 15),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: <Widget>[
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/maths.png")),
                              SizedBox(width: 5),
                              Text("TEXT",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/maths.png")),
                              SizedBox(width: 5),
                              Text("ART",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/maths.png")),
                              SizedBox(width: 5),
                              Text("MUSIC",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/maths.png")),
                              SizedBox(width: 5),
                              Text("DANCE",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/maths.png")),
                              SizedBox(width: 5),
                              Text("TENNIS",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/english.png")),
                              SizedBox(width: 5),
                              Text("DANCE",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                    ]
                )
            ),
            SizedBox(height: 5),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: <Widget>[
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/english.png")),
                              SizedBox(width: 5),
                              Text("TEXT",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/english.png")),
                              SizedBox(width: 5),
                              Text("ART",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/english.png")),
                              SizedBox(width: 5),
                              Text("MUSIC",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/english.png")),
                              SizedBox(width: 5),
                              Text("DANCE",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/english.png")),
                              SizedBox(width: 5),
                              Text("TENNIS",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/english.png")),
                              SizedBox(width: 5),
                              Text("DANCE",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                    ]
                )
            ),

            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Your Topics",style: TextStyle(fontFamily: "Candara",fontSize: 20,color: Colors.black)),
                GestureDetector(child: Text("See all",style: TextStyle(fontSize: 20,color: Colors.blue,fontFamily: "Candara")))
              ],
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.all(3),
              color: Colors.teal,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(image: AssetImage("images/sst.png")),
                                SizedBox(width: 5),
                                Text("TEXT",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(image: AssetImage("images/sst.png")),
                                SizedBox(width: 5),
                                Text("ART",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(image: AssetImage("images/sst.png")),
                                SizedBox(width: 5),
                                Text("MUSIC",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(image: AssetImage("images/sst.png")),
                                SizedBox(width: 5),
                                Text("DANCE",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(image: AssetImage("images/sst.png")),
                                SizedBox(width: 5),
                                Text("TENNIS",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(image: AssetImage("images/sst.png")),
                                SizedBox(width: 5),
                                Text("DANCE",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                              ],
                            ),
                          ),
                        ),
                      ]
                  )
              ),
            ),
            SizedBox(height: 5),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: <Widget>[
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/chemistry.png")),
                              SizedBox(width: 5),
                              Text("TEXT",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/chemistry.png")),
                              SizedBox(width: 5),
                              Text("ART",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/chemistry.png")),
                              SizedBox(width: 5),
                              Text("MUSIC",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/chemistry.png")),
                              SizedBox(width: 5),
                              Text("DANCE",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/chemistry.png")),
                              SizedBox(width: 5),
                              Text("TENNIS",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image(image: AssetImage("images/chemistry.png")),
                              SizedBox(width: 5),
                              Text("DANCE",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.black))
                            ],
                          ),
                        ),
                      ),
                    ]
                )
            )



          ],
        ),
      ),
    );
  }
}

