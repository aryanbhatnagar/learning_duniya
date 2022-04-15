import 'package:flutter/material.dart';

class screen5 extends StatefulWidget {
  const screen5({Key? key}) : super(key: key);

  @override
  State<screen5> createState() => _screen5State();
}

class _screen5State extends State<screen5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Quiz Result',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 1,
                    child: Container(
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'See how you scored against your opponent',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    //margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.amber,
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Daniel Sunny',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 42, 56, 134),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'St. Xaviers School',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.teal)),
                                child: Text('View'),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Meagan Funny',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 42, 56, 134),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'St. Loreto School',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.teal)),
                                child: Text('View'),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.amber,
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Daniel Sunny',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 42, 56, 134),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'St. Xaviers School',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.teal)),
                                child: Text('View'),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Meagan Funny',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 42, 56, 134),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'St. Loreto School',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.teal)),
                                child: Text('View'),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.amber,
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Daniel Sunny',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 42, 56, 134),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'St. Xaviers School',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.teal)),
                                child: Text('View'),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                  ),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Meagan Funny',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 42, 56, 134),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'St. Loreto School',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.teal)),
                                child: Text('View'),
                                onPressed: () {},
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
