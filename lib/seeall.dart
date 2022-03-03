import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'courseDesc.dart';
import 'mentor.dart';
import 'quiz.dart';

class seeall extends StatelessWidget {
  const seeall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: seeallpage("EMPTY",0),
    );
  }
}

class seeallpage extends StatefulWidget {

  String title;
  int code;

  seeallpage(this.title, this.code);

  //const seeallpage({Key? key}) : super(key: key);

  @override
  _seeallpageState createState() => _seeallpageState(title,code);
}

class _seeallpageState extends State<seeallpage> {

  late String title;
  _seeallpageState(this.title, this.code);
  late int code;

  //list for views
  List <Widget> pop_c= <Widget>[];
  List <Widget> asses= <Widget>[];
  List <Widget> k12= <Widget>[];
  List <Widget> comp_e= <Widget>[];
  List <Widget> mento= <Widget>[];

  @override
  Widget build(BuildContext context) {

    for(var i=0;i<=7;i++)
      pop_c.add(GestureDetector(
        onTap:(){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>courseDesc()));
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(borderRadius: BorderRadius.circular(10),
                  child: Center(
                      child: Image(image: AssetImage("images/sci.jfif"),height: 120,width: 150,fit: BoxFit.scaleDown,))),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,5,8,5),
                child: Container(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Course Title",style: TextStyle(fontSize: 17,fontFamily: "Candara",color: Colors.black)),
                          //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                          FavoriteButton(
                            iconSize: 30,
                            isFavorite: false,
                            // iconDisabledColor: Colors.white,
                            valueChanged: (_isFavorite) {
                              print('Is Favorite : $_isFavorite');
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(padding:EdgeInsets.zero,onPressed:(){}, icon:Icon(Icons.person,size: 20,color: Colors.grey)),
                          Text("Name",style: TextStyle(fontSize: 17,fontFamily: "Candara",color: Colors.grey))
                        ],

                      ),
                      Text("\$1234",style: TextStyle(fontSize: 20, fontFamily: "Candara",color: Colors.red))
                    ],
                  ),
                ),
              )
            ],
          ),

        ),
      ));
    for(var i=0;i<=7;i++)
      asses.add(GestureDetector(
        onTap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>quiz()));},
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(borderRadius: BorderRadius.circular(10),
                  child: Image(image: AssetImage("images/hindiass.jpg"),height: 120,width: 150,fit: BoxFit.fitWidth)),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,5,8,5),
                child: Container(
                  //width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hindi Assessment",style: TextStyle(fontSize: 17,fontFamily: "Candara",color: Colors.black)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text("\$1234",style: TextStyle(fontSize: 20, fontFamily: "Candara",color: Colors.red)),
                          //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                          SizedBox(width: 5),
                          FavoriteButton(
                            iconSize: 30,
                            isFavorite: false,
                            // iconDisabledColor: Colors.white,
                            valueChanged: (_isFavorite) {
                              print('Is Favorite : $_isFavorite');
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              )
            ],
          ),

        ),
      ));
    for(var i=0;i<=7;i++)
      comp_e.add(GestureDetector(
        onTap:(){},
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(image: AssetImage("images/hindiass.jpg"),height: 120,width: 150))),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,5,8,5),
                child: Container(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Hindi Exam",style: TextStyle(fontSize: 17,fontFamily: "Candara",color: Colors.black)),
                          //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                          FavoriteButton(
                            iconSize: 30,
                            isFavorite: false,
                            // iconDisabledColor: Colors.white,
                            valueChanged: (_isFavorite) {
                              print('Is Favorite : $_isFavorite');
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(padding:EdgeInsets.zero,onPressed:(){}, icon:Icon(Icons.person,size: 20,color: Colors.grey)),
                          Text("Name",style: TextStyle(fontSize: 17,fontFamily: "Candara",color: Colors.grey))
                        ],

                      ),
                      Text("\$1234",style: TextStyle(fontSize: 20, fontFamily: "Candara",color: Colors.red))
                    ],
                  ),
                ),
              )
            ],
          ),

        ),
      ));
    for(var i=0;i<=3;i++)
      mento.add(GestureDetector(
        onTap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>mentor(1)));},
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("images/mentor1.PNG"),width: 120,height: 140,fit: BoxFit.scaleDown,),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,5,8,5),
                child: Container(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Mentor Name",style: TextStyle(fontSize: 20,fontFamily: "Candara",color: Colors.black)),
                          //IconButton(onPressed: (){  }, icon: Icon(Icons.favorite_outline,size: 25),color: Colors.grey,)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Specialisation",style: TextStyle(fontSize: 15,fontFamily: "Candara",color: Colors.grey))
                        ],

                      ),],
                  ),
                ),
              )
            ],
          ),

        ),
      ));

    List <Widget> card= <Widget>[];

    if(code==1)card=pop_c;
    if(code==2)card=asses;
    if(code==3)card=comp_e;
    if(code==4)card=mento;

    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.grey[200],
      child: Column(
        children: [
          Text(title,style: TextStyle(fontFamily: "Candara",fontSize: 35,color: Colors.black)),
          new Expanded(
            child: GridView.count(
              childAspectRatio: 0.7,

                crossAxisCount: 2,
              children: card,
            ),
          ),
        ],
      )
    );
  }
}

