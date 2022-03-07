import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'main.dart';
import 'courses.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

late String name="";
class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  List<Widget> add = [];

  static List<Widget> _widgetOptions = <Widget>[
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(left: 25, top: 10),
            child: Text(
              'Hi $name',
              style: TextStyle(
                  fontSize: 17.5, color: Colors.black, fontFamily: "Candara"),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25, bottom: 10),
            child: Text(
              "Choose your courses",
              style: TextStyle(
                  fontFamily: "Candara", fontSize: 12.5, color: Colors.grey),
            ),
          ),
          Container(
            //height: 100,
            padding: EdgeInsets.only(left: 1, right: 1, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    //padding: EdgeInsets.all(5),
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage('images/maths.png')),
                            SizedBox(height: 10),
                            Text(
                              "MATHS",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: "Candara"),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage('images/chemistry.png')),
                            SizedBox(height: 10),
                            Text(
                              "SCIENCE",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: "Candara"),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                    GestureDetector(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage('images/hindi.png')),
                            SizedBox(height: 10),
                            Text(
                              "HINDI",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: "Candara"),
                            )
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                )),
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
                                  radius: 35,
                                  backgroundImage:
                                      AssetImage('images/english.png')),
                              SizedBox(height: 10),
                              Text(
                                "ENGLISH",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: "Candara"),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      AssetImage('images/sst.png')),
                              SizedBox(height: 10),
                              Text(
                                "SST",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: "Candara"),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      AssetImage('images/computer.png')),
                              SizedBox(height: 10),
                              Text(
                                "COMPUTER",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: "Candara"),
                              )
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: <Widget>[
                  TextButton(
                      onPressed: () {},
                      child: Image.asset("images/ad.png",
                          height: 100, width: 200)),
                  TextButton(
                      onPressed: () {},
                      child: Image.asset("images/ad.png",
                          height: 100, width: 200)),
                  TextButton(
                      onPressed: () {},
                      child: Image.asset("images/ad.png",
                          height: 100, width: 200)),
                  TextButton(
                      onPressed: () {},
                      child:
                          Image.asset("images/ad.png", height: 100, width: 200))
                ])),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 20, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("ScoreCard",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontFamily: "Candara")),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Browse all mock tests',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontFamily: "Candara")),
                  color: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                )
              ],
            ),
          ),
          Container(
            //height: 100,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Card(
              color: Colors.white,
              shadowColor: Colors.grey,
              borderOnForeground: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "PRACTICE TESTS",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Candara"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, bottom: 5),
                    child: Text(
                      "Drive your competency",
                      style: TextStyle(
                          fontFamily: "Candara",
                          fontSize: 17.5,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total Tests",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: "Candara")),
                        Text("Pass In",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: "Candara")),
                        Text("Re-Test",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: "Candara"))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("  5",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                                fontFamily: "Candara")),
                        Text(" 4",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black,
                                fontFamily: "Candara")),
                        Text("1",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.red,
                                fontFamily: "Candara"))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('PRACTICE AGAIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontFamily: "Candara")),
                      color: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: <Widget>[
                  TextButton(
                      onPressed: () {},
                      child: Image.asset("images/ad.png",
                          height: 100, width: 200)),
                  TextButton(
                      onPressed: () {},
                      child: Image.asset("images/ad.png",
                          height: 100, width: 200)),
                  TextButton(
                      onPressed: () {},
                      child: Image.asset("images/ad.png",
                          height: 100, width: 200)),
                  TextButton(
                      onPressed: () {},
                      child:
                          Image.asset("images/ad.png", height: 100, width: 200))
                ])),
          ),
        ],
      ),
    ),
    MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: coursepage(),
      ),
    )),
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            height: 100,
            padding: EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Card(
              color: Colors.blue,
              shadowColor: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            height: 100,
            padding: EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Card(
              color: Colors.blue,
              shadowColor: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            height: 100,
            padding: EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Card(
              color: Colors.blue,
              shadowColor: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    ),
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            height: 100,
            padding: EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Card(
              color: Colors.orange,
              shadowColor: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            height: 100,
            padding: EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Card(
              color: Colors.orange,
              shadowColor: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: Colors.white,
            height: 100,
            padding: EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Card(
              color: Colors.orange,
              shadowColor: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void _initState() async {
    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
    sharedPreferences.getString('token');
    name=sharedPreferences.getString('name')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: true,
        actions: <Icon>[
          Icon(Icons.notifications, color: Colors.teal, size: 30)
        ],
        title: Text("DASHBOARD",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontFamily: "Candara",
                fontSize: 25)),
      ),
      drawer: Drawer(
          elevation: 5,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Text('MENU'),
              ),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  setState(() async {
                    userName = "";
                    userEmail = "";
                    userId = 0;
                    token = "";
                    SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
                    sharedPreferences.remove('token');
                    sharedPreferences.remove('name');
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined, size: 30),
                label: 'Dashboard',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined, size: 30),
              label: 'Courses',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.school_outlined,
                size: 30,
              ),
              label: 'Scholarship',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active_outlined, size: 30),
                label: 'Exam Alert'),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          elevation: 5),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
