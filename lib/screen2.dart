import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class screen2 extends StatefulWidget {
  const screen2({Key? key}) : super(key: key);

  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  @override
  Widget build(BuildContext context) {
    double columnWidth = MediaQuery.of(context).size.width *0.9;

    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Details', style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  ), Text('Knowing your Weakness', style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  ),Icon(Icons.book, color: Colors.blue,)
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: columnWidth,
                //height: 100,
                margin: EdgeInsets.only(left: 5, right: 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.indigo
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current Suggested Solution', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 10),),
                    SizedBox(
                      height: 10,
                    ),
                    Text('If both the above percentage found. Print here solution for level 1 and level 2 from table analytic_result. \n\nIf only one of the above found, print solution for level 1 if level 1 is found above or print solution for level 2, if level 2 found above', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10),),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subject Details', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 11),),
                    Text('Maths', style: TextStyle(fontWeight: FontWeight.bold),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.blue,size: 20,),
                            CircularProgressIndicator(
                              backgroundColor: Color.fromRGBO(203, 203, 203, 100),
                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                              value: 0.99,
                              strokeWidth: 3,
                            ),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Text('99%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: columnWidth,
                //height: 200,
                margin: EdgeInsets.only(left: 5, right: 5),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.indigo
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Performance By Chapter', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: columnWidth-30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Ques | Correct | Wrong', style: TextStyle(color: Colors.teal, fontSize: 11),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('1. Integers', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),),
                              Text('4 | 3 | 1', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          SizedBox(height: 20,),

                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Fill in the blanks'),
                                    SizedBox(height: 10,),
                                    Text('True or False'),
                                    SizedBox(height: 10,),
                                    Text('Match the following'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Que 4 | Wrong 1'),
                                    SizedBox(height: 10,),
                                    Text('Que 4 | Wrong 1'),
                                    SizedBox(height: 10,),
                                    Text('Que 4 | Wrong 1'),
                                  ],
                                )
                              ],
                            ),
                          ),

                          SizedBox(height: 20,),
                          Text('Answered without readying, very fast', style: TextStyle(color: Colors.teal),),
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),

                    Container(
                      padding: EdgeInsets.all(5),
                      width: columnWidth-30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Ques | Correct | Wrong', style: TextStyle(color: Colors.teal, fontSize: 11),),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('1. Whole Numbers', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),),
                              Text('4 | 3 | 1', style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          SizedBox(height: 20,),

                          Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Fill in the blanks'),
                                    SizedBox(height: 10,),
                                    Text('True or False'),
                                    SizedBox(height: 10,),
                                    Text('Match the following'),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Que 4 | Wrong 1'),
                                    SizedBox(height: 10,),
                                    Text('Que 4 | Wrong 1'),
                                    SizedBox(height: 10,),
                                    Text('Que 4 | Wrong 1'),
                                  ],
                                )
                              ],
                            ),
                          ),

                          SizedBox(height: 20,),
                          Text('Answered without readying, very fast', style: TextStyle(color: Colors.teal),),
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),


                    Text('SUGGESTIONS', textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.teal,
                        fontSize: 11,
                        fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: columnWidth,
                height: 110,
                margin: EdgeInsets.only(left: 5, right: 5),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.indigo
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('4', style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Total Questions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('16', style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Correct', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('12', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.grey),),
                            SizedBox(
                              height: 10,
                            ),
                            Text('4', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text('All Subject assessment overflow', style: TextStyle(color: Colors.teal, fontSize: 11, fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
