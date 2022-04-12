import 'package:flutter/material.dart';

class screen3 extends StatefulWidget {
  const screen3({Key? key}) : super(key: key);

  @override
  State<screen3> createState() => _screen3State();
}

class _screen3State extends State<screen3> {
  @override
  Widget build(BuildContext context) {
    double columnWidth = MediaQuery.of(context).size.width *0.8;

    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 3'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: columnWidth,
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.indigo
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.blue,size: 20,),
                          CircularProgressIndicator(
                            backgroundColor: Color.fromRGBO(203, 203, 203, 100),
                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                            value: 0.68,
                            strokeWidth: 3,
                          ),
                        ],
                      )
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 3,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('68%', style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),),
                        Text(
                          'Answered without readying, very fast',
                          style: TextStyle(
                              fontSize: 12
                          ),
                        ),
                      ],
                    ),),
                  SizedBox(width: 10,),
                  Expanded(
                      flex: 1,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.greenAccent,size: 20,),
                          CircularProgressIndicator(
                            backgroundColor: Color.fromRGBO(203, 203, 203, 100),
                            valueColor: new AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                            value: 0.32,
                            strokeWidth: 3,
                          ),
                        ],
                      )
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 3,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('32%', style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),),
                        Text(
                          'Answered very quick, did not think',
                          style: TextStyle(
                              fontSize: 12
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: columnWidth,
              margin: EdgeInsets.only(left: 10, right: 10, top: 5),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.indigo
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: columnWidth-20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chapter: Integer', style: TextStyle(
                            color: Colors.teal, fontSize: 10
                        ),),
                        Text('Type: Fill in the blanks', style: TextStyle(
                            color: Colors.teal, fontSize: 10
                        ),),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Ques: Ram is the brother of Shyam.', style: TextStyle(
                      color: Colors.teal, fontSize: 10
                  ),),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.indigo
                        ),
                        color: Color.fromRGBO(182, 182, 182, 100),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Center(child: Text('OK', style: TextStyle(
                        color: Colors.white
                    ),)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
