import 'package:flutter/material.dart';

class screen4 extends StatefulWidget {
  const screen4({Key? key}) : super(key: key);

  @override
  State<screen4> createState() => _screen4State();
}

class _screen4State extends State<screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.teal,
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'RESULTS',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            Text(
              'YOU WON',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        'Daniel S.',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [

                          CircleAvatar(backgroundColor: Colors.white24, radius: 110),
                          CircleAvatar(backgroundColor: Colors.white38, radius: 100),
                          CircleAvatar(backgroundColor: Colors.white60, radius: 90),
                          CircleAvatar(backgroundColor: Colors.yellow, radius: 80),
                        ],
                      )

                    ],
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Meagan F.',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [

                          CircleAvatar(backgroundColor: Colors.white38, radius: 80),
                          CircleAvatar(backgroundColor: Colors.white60, radius: 70),
                          CircleAvatar(backgroundColor: Colors.green, radius: 60),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width - 50,
                  child: Center(
                    child: Text(
                      '4 : 3',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 197, 177),
                      borderRadius: BorderRadius.circular(15)),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: () {},
                child: Text(
                  'PLAY AGAIN!',
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
