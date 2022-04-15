import 'package:flutter/material.dart';

class screen32 extends StatefulWidget {
  const screen32({Key? key}) : super(key: key);

  @override
  State<screen32> createState() => _screen32State();
}

class _screen32State extends State<screen32> {
  String dropdownValueSubject = 'Subject';
  String dropdownValueChapter = 'Chapter';
  String dropdownValueQType = 'Type';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                        'Quiz Challenge',
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
                    Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(2)),
                      width: MediaQuery.of(context).size.width - 20,
                      child: Row(
                        children: [
                          DropdownButton<String>(
                            value: dropdownValueSubject,
                            //icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            //style: const TextStyle(color: Colors.deepPurple),
                            /*underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),*/
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValueSubject = newValue!;
                              });
                            },
                            items: <String>['Subject', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          //Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(2)),
                      width: MediaQuery.of(context).size.width - 20,
                      child: Row(
                        children: [
                          DropdownButton<String>(
                            value: dropdownValueChapter,
                            //icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            //style: const TextStyle(color: Colors.deepPurple),
                            /*underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),*/
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValueChapter = newValue!;
                              });
                            },
                            items: <String>['Chapter', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          //Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(2)),
                      width: MediaQuery.of(context).size.width - 20,
                      child: Row(
                        children: [
                          DropdownButton<String>(
                            value: dropdownValueQType,
                            //icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            //style: const TextStyle(color: Colors.deepPurple),
                            /*underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),*/
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValueQType = newValue!;
                              });
                            },
                            items: <String>['Type', 'Two', 'Free', 'Four']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          //Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      child: Text(
                        'Random students of your grade',
                        style: TextStyle(color: Colors.grey),
                      ),
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
                                          color:
                                              Color.fromARGB(255, 42, 56, 134),
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
                                  child: Text('PLAY'),
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
                                          color:
                                              Color.fromARGB(255, 42, 56, 134),
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
                                  child: Text('PLAY'),
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
                                          color:
                                              Color.fromARGB(255, 42, 56, 134),
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
                                  child: Text('PLAY'),
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
                                          color:
                                              Color.fromARGB(255, 42, 56, 134),
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
                                  child: Text('PLAY'),
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
                                          color:
                                              Color.fromARGB(255, 42, 56, 134),
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
                                  child: Text('PLAY'),
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
                                          color:
                                              Color.fromARGB(255, 42, 56, 134),
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
                                  child: Text('PLAY'),
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
      ),
    );
  }
}
