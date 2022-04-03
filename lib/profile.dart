import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learning_duniya/landing.dart';
import 'globals.dart';
//import 'helprequest.dart';
import 'dart:convert';

MentorApi mentorApiFromJson(String str) => MentorApi.fromJson(json.decode(str));
String mentorApiToJson(MentorApi data) => json.encode(data.toJson());

class MentorApi {
  MentorApi({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  var status;

  factory MentorApi.fromJson(Map<String, dynamic> json) => MentorApi(
    data: Data.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "status": status,
  };
}
class Data {
  Data({
    required this.profile,
    required this.mentees,
  });

  Profile profile;
  List<dynamic> mentees;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    profile: Profile.fromJson(json["profile"]),
    mentees: List<dynamic>.from(json["mentees"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile.toJson(),
    "mentees": List<dynamic>.from(mentees.map((x) => x)),
  };
}
class Profile {
  Profile({
    required this.id,
    required this.userId,
    required this.eduName,
    required this.specilization,
    required this.secondarySubject,
    required this.exp,
    required this.aboutUs,
    required this.phone,
    required this.country,
    required this.state,
    required this.city,
    required this.nameAsAccount,
    required this.accountNo,
    required this.ifscCode,
    required this.branch,
    required this.reviews,
    required this.likes,
    required this.img,
    required this.status,
  });

  var id;
  var  userId;
  var  eduName;
  var  specilization;
  var  secondarySubject;
  var  exp;
  var  aboutUs;
  var  phone;
  var country;
  var  state;
  var  city;
  dynamic nameAsAccount;
  dynamic accountNo;
  dynamic ifscCode;
  dynamic branch;
  var  reviews;
  var  likes;
  var  img;
  var  status;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    userId: json["user_id"],
    eduName: json["edu_name"],
    specilization: json["specilization"],
    secondarySubject: json["secondary_subject"],
    exp: json["exp"],
    aboutUs: json["about_us"],
    phone: json["phone"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    nameAsAccount: json["name_as_account"],
    accountNo: json["account_no"],
    ifscCode: json["ifsc_code"],
    branch: json["branch"],
    reviews: json["reviews"],
    likes: json["likes"],
    img: json["img"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "edu_name": eduName,
    "specilization": specilization,
    "secondary_subject": secondarySubject,
    "exp": exp,
    "about_us": aboutUs,
    "phone": phone,
    "country": country,
    "state": state,
    "city": city,
    "name_as_account": nameAsAccount,
    "account_no": accountNo,
    "ifsc_code": ifscCode,
    "branch": branch,
    "reviews": reviews,
    "likes": likes,
    "img": img,
    "status": status,
  };
}

Future<MentorApi> getMentorApi() async {

  final String apiUrl = "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/mentor/profile";
  final response = await http.get(Uri.parse(apiUrl),
      headers: <String, String> {
        "Authorization": "Bearer $token",
      });

  if (response.statusCode == 200) {
    print(response.statusCode.toString());
    final String responseString = response.body;
    return mentorApiFromJson(responseString);
  }
  else {
    throw Exception('Failed to load album');
  }
}

int i = 0;
var req = 5;
var x = ['a', 'b'];

String title = 'Mentor Profile';
String name = 'John Spencer';
String bio1 = 'Study | Art & Entertainment | Health & Wellness';
String bio2 = 'Major- Human Factors/ Ergonomics';

var stu_name = ['Hannah Murphy', 'Jacky Adams', 'Jeniffer Williamson'];
String req_body = 'Study | Art & Entertainment';
var mode = ['Chat Message', 'Audio Call', 'Video Call'];

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  int _selectedIndex = 1;
  int _selectedIndexMenteePage = 0;
  //late final AnimationController _controller;
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    List<Widget> newStudents = <Widget>[];
    newStudents.add(GestureDetector(
      /*onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    mentor(landApi!.data.mentors[i].id)));
      },*/
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage('images/mentor2.PNG'),
                height: 150,
                width: 110),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
              child: Container(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Student Name",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Candara",
                                color: Colors.grey))
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
    newStudents.add(GestureDetector(
      /*onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    mentor(landApi!.data.mentors[i].id)));
      },*/
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage('images/mentor1.PNG'),
                height: 150,
                width: 110),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
              child: Container(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Student Name",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Candara",
                                color: Colors.grey))
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
    newStudents.add(GestureDetector(
      /*onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    mentor(landApi!.data.mentors[i].id)));
      },*/
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage('images/mentor2.PNG'),
                height: 150,
                width: 110),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
              child: Container(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Student Name",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Candara",
                                color: Colors.grey))
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));

    List<Widget> upComingEvents = <Widget>[];
    upComingEvents.add(Row(
      children: [
        Expanded(
          flex: 13,
          child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  "Date TIME",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: "Candara", color: Colors.grey),
                ),
              )),
        ),
        Expanded(
          flex: 50,
          child: Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5, left: 2),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Audio Call With X',
                  style: TextStyle(fontFamily: "Candara", color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      fontFamily: "Candara",
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 13,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: Icon(
                Icons.phone,
                color: Colors.grey,
              )),
            ),
          ),
        ),
      ],
    ));
    upComingEvents.add(Row(
      children: [
        Expanded(
          flex: 13,
          child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  "Date TIME",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: "Candara", color: Colors.grey),
                ),
              )),
        ),
        Expanded(
          flex: 50,
          child: Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5, left: 2),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Video Call With X',
                  style: TextStyle(fontFamily: "Candara", color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      fontFamily: "Candara",
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 13,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: Icon(
                Icons.videocam,
                color: Colors.grey,
              )),
            ),
          ),
        ),
      ],
    ));
    upComingEvents.add(Row(
      children: [
        Expanded(
          flex: 13,
          child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  "Date TIME",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: "Candara", color: Colors.grey),
                ),
              )),
        ),
        Expanded(
          flex: 50,
          child: Container(
            margin: const EdgeInsets.only(top: 5, bottom: 5, left: 2),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Chat With X',
                  style: TextStyle(fontFamily: "Candara", color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View Details',
                    style: TextStyle(
                      fontFamily: "Candara",
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 13,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                  child: Icon(
                Icons.message_outlined,
                color: Colors.grey,
              )),
            ),
          ),
        ),
      ],
    ));

    var pageData;
    List<Widget> menteePage = <Widget>[];
    var menteeData;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;

        if (index == 0)
          title = 'Help Request';
        else if (index == 1)
          title = 'Mentor Profile';
        else if (index == 2) title = 'Mentees';
      });
    }

    List<Widget> homePage = <Widget>[
      DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.white,
              //shadowColor: Colors.black,
              flexibleSpace: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  new TabBar(
                    indicator: BoxDecoration(color: Color.fromARGB(255, 59, 48, 214)),
                    unselectedLabelColor: Colors.grey,

                    labelStyle: TextStyle(
                      fontFamily: 'Candara',),
                    tabs: [
                      new Tab(
                        text:  "New Request",
                      ),
                      new Tab(
                        text: "Previous Request",)
                    ],
                  ),
                ],
              ),
            ),
            body: menteeData,
          ),
        ),
      ),
      FutureBuilder(
        future: getMentorApi(),
          builder: (context,AsyncSnapshot<MentorApi> snapshot){
          if (snapshot.hasData){
            menteePage.add(SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/mentor2.PNG'),
                          radius: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stu_name[0],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Candara',
                                fontSize: 18,
                              ),
                            ),
                            Text('Requesting help in ' + req_body,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Candara',
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis),
                            RichText(
                              text: TextSpan(
                                text: "Through ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Candara',
                                  fontSize: 11,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: mode[0],
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 59, 48, 214))),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                OutlinedButton(
                                  child: const Text(
                                    'Review',
                                    style: TextStyle(
                                      fontFamily: 'Candara',
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onPressed: () async {
                                    final Future<ConfirmAction?> action =
                                    await _asyncConfirmDialog(
                                        context,
                                        'Mentor Name',
                                        'Mentor Bio',
                                        'Communication',
                                        x,
                                        'None');
                                    //Navigator.of(context).pop(ConfirmAction.Reject);
                                  },
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 59, 48, 214))),
                                  child: Text(
                                    'Invite',
                                    style: TextStyle(
                                      fontFamily: 'Candara',
                                    ),
                                  ),
                                  onPressed: () {
                                    //Navigator.of(context).pop(ConfirmAction.Invite);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/mentor1.PNG'),
                          radius: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stu_name[1],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Candara',
                                fontSize: 18,
                              ),
                            ),
                            Text('Requesting help in ' + req_body,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Candara',
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis),
                            RichText(
                              text: TextSpan(
                                text: "Through ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Candara',
                                  fontSize: 11,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: mode[1],
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 59, 48, 214))),
                                ],
                              ),
                            ),
                            /*Text('Through ' + mode[1], style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Candara',
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis
                        ),*/
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                OutlinedButton(
                                  child: const Text(
                                    'Review',
                                    style: TextStyle(
                                      fontFamily: 'Candara',
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onPressed: () async {
                                    final Future<ConfirmAction?> action =
                                    await _asyncConfirmDialog(
                                        context,
                                        'Mentor Name',
                                        'Mentor Bio',
                                        'Communication',
                                        x,
                                        'None');
                                    //Navigator.of(context).pop(ConfirmAction.Reject);
                                  },
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 59, 48, 214))),
                                  child: Text(
                                    'Invite',
                                    style: TextStyle(
                                      fontFamily: 'Candara',
                                    ),
                                  ),
                                  onPressed: () {
                                    //Navigator.of(context).pop(ConfirmAction.Invite);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/mentor2.PNG'),
                          radius: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stu_name[2],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Candara',
                                fontSize: 18,
                              ),
                            ),
                            Text('Requesting help in ' + req_body,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Candara',
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis),
                            RichText(
                              text: TextSpan(
                                text: "Through ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Candara',
                                  fontSize: 11,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: mode[2],
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 59, 48, 214))),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                OutlinedButton(
                                  child: const Text(
                                    'Review',
                                    style: TextStyle(
                                      fontFamily: 'Candara',
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onPressed: () async {
                                    final Future<ConfirmAction?> action =
                                    await _asyncConfirmDialog(
                                        context,
                                        'Mentor Name',
                                        'Mentor Bio',
                                        'Communication',
                                        x,
                                        'None');
                                    //Navigator.of(context).pop(ConfirmAction.Reject);
                                  },
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 59, 48, 214))),
                                  child: Text(
                                    'Invite',
                                    style: TextStyle(
                                      fontFamily: 'Candara',
                                    ),
                                  ),
                                  onPressed: () {
                                    //Navigator.of(context).pop(ConfirmAction.Invite);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/mentor2.PNG'),
                          radius: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stu_name[0],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Candara',
                                fontSize: 18,
                              ),
                            ),
                            Text('Requesting help in ' + req_body,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Candara',
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis),
                            RichText(
                              text: TextSpan(
                                text: "Through ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Candara',
                                  fontSize: 11,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: mode[0],
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 59, 48, 214))),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                OutlinedButton(
                                  child: const Text(
                                    'Review',
                                    style: TextStyle(
                                      fontFamily: 'Candara',
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onPressed: () async {
                                    final Future<ConfirmAction?> action =
                                    await _asyncConfirmDialog(
                                        context,
                                        'Mentor Name',
                                        'Mentor Bio',
                                        'Communication',
                                        x,
                                        'None');
                                    //Navigator.of(context).pop(ConfirmAction.Reject);
                                  },
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 59, 48, 214))),
                                  child: Text(
                                    'Invite',
                                    style: TextStyle(
                                      fontFamily: 'Candara',
                                    ),
                                  ),
                                  onPressed: () {
                                    //Navigator.of(context).pop(ConfirmAction.Invite);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/mentor1.PNG'),
                          radius: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stu_name[1],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Candara',
                                fontSize: 18,
                              ),
                            ),
                            Text('Requesting help in ' + req_body,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Candara',
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis),
                            RichText(
                              text: TextSpan(
                                text: "Through ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Candara',
                                  fontSize: 11,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: mode[1],
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 59, 48, 214))),
                                ],
                              ),
                            ),
                            /*Text('Through ' + mode[1], style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Candara',
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis
                        ),*/
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                OutlinedButton(
                                  child: const Text(
                                    'Review',
                                    style: TextStyle(
                                      fontFamily: 'Candara',
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onPressed: () async {
                                    final Future<ConfirmAction?> action =
                                    await _asyncConfirmDialog(
                                        context,
                                        'Mentor Name',
                                        'Mentor Bio',
                                        'Communication',
                                        x,
                                        'None');
                                    //Navigator.of(context).pop(ConfirmAction.Reject);
                                  },
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 59, 48, 214))),
                                  child: Text(
                                    'Invite',
                                    style: TextStyle(
                                      fontFamily: 'Candara',
                                    ),
                                  ),
                                  onPressed: () {
                                    //Navigator.of(context).pop(ConfirmAction.Invite);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/mentor2.PNG'),
                          radius: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stu_name[2],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Candara',
                                fontSize: 18,
                              ),
                            ),
                            Text('Requesting help in ' + req_body,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Candara',
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis),
                            RichText(
                              text: TextSpan(
                                text: "Through ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Candara',
                                  fontSize: 11,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: mode[2],
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 59, 48, 214))),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                OutlinedButton(
                                  child: const Text(
                                    'Review',
                                    style: TextStyle(
                                      fontFamily: 'Candara',
                                      color: Colors.grey,
                                    ),
                                  ),
                                  onPressed: () async {
                                    final Future<ConfirmAction?> action =
                                    await _asyncConfirmDialog(
                                        context,
                                        'Mentor Name',
                                        'Mentor Bio',
                                        'Communication',
                                        x,
                                        'None');
                                    //Navigator.of(context).pop(ConfirmAction.Reject);
                                  },
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 59, 48, 214))),
                                  child: Text(
                                    'Invite',
                                    style: TextStyle(
                                      fontFamily: 'Candara',
                                    ),
                                  ),
                                  onPressed: () {
                                    //Navigator.of(context).pop(ConfirmAction.Invite);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
            menteeData = menteePage[0];
            return Container(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("${snapshot.data!.data.profile.img.toString()}"),
                        radius: 50,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "${snapshot.data!.data.profile.eduName}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Candara',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "${snapshot.data!.data.profile.aboutUs}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Candara', fontSize: 14, color: Colors.grey),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      bio2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Candara', fontSize: 14, color: Colors.grey),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 11,
                          child: OutlinedButton(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'About Me',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Candara',
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 20,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Color.fromARGB(255, 59, 48, 214))),
                              child: Container(
                                  padding: EdgeInsets.all(15),
                                  child: Text(
                                    'Availability',
                                    style: TextStyle(
                                        fontFamily: 'Candara',
                                        fontWeight: FontWeight.w900),
                                  )),
                              onPressed: () {},
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(153, 255, 216, 159),
                        ),
                        padding: EdgeInsets.all(1),
                        //margin: EdgeInsets.only(left: 10, right: 10),
                        child: TextButton(
                            onPressed: () {
                              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => help()));
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => help()));
                              _onItemTapped(0);
                            },
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.notifications,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    req.toString() + " Pending Help Request",
                                    style: TextStyle(
                                        fontFamily: 'Candara',
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Upcoming Events",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Candara",
                                fontSize: 22,
                                color: Colors.black)),
                        GestureDetector(
                          child: Text("See All",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 59, 48, 214),
                                  fontFamily: "Candara")),
                          onTap: () {
                            /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                seeallpage("Popular Courses", 1)));*/
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: upComingEvents,
                        )),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("New Students",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: "Candara",
                                fontSize: 22,
                                color: Colors.black)),
                        GestureDetector(
                          child: Text("See All",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 59, 48, 214),
                                  fontFamily: "Candara")),
                          onTap: () {
                            /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                seeallpage("Popular Courses", 1)));*/
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: newStudents,
                        )),
                  ],
                ),
              ),
            );
          }
          else
            return Container();
      }),
      Container(
          padding: EdgeInsets.all(15),
          child: menteeData
      )
    ];




    void _onItemTappedRequestPage(int index) {
      setState(() {
        _selectedIndexMenteePage = index;
        menteeData = menteePage[index];
      });
    }



    //Notification Page
    /*homePage.add(
      DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: new Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.white,
              //shadowColor: Colors.black,
              flexibleSpace: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  new TabBar(
                    indicator: BoxDecoration(color: Color.fromARGB(255, 59, 48, 214)),
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontFamily: 'Candara',),
                    tabs: [
                      new Tab(
                          text:  "New Request",
                      ),
                      new Tab(
                          text: "Previous Request",)
                    ],
                  ),
                ],
              ),
            ),
            body: menteeData,
          ),
        ),
      ),
    );
    //Home Page
    homePage.add(
      Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/mentor1.PNG'),
                  radius: 50,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Candara',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                bio1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Candara', fontSize: 14, color: Colors.grey),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                bio2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Candara', fontSize: 14, color: Colors.grey),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 11,
                    child: OutlinedButton(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'About Me',
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Candara',
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 20,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 59, 48, 214))),
                        child: Container(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Availability',
                              style: TextStyle(
                                  fontFamily: 'Candara',
                                  fontWeight: FontWeight.w900),
                            )),
                        onPressed: () {},
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(153, 255, 216, 159),
                  ),
                  padding: EdgeInsets.all(1),
                  //margin: EdgeInsets.only(left: 10, right: 10),
                  child: TextButton(
                      onPressed: () {
                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => help()));
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => help()));
                        _onItemTapped(0);
                      },
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.notifications,
                              color: Colors.orange,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              req.toString() + " Pending Help Request",
                              style: TextStyle(
                                  fontFamily: 'Candara',
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Upcoming Events",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "Candara",
                          fontSize: 22,
                          color: Colors.black)),
                  GestureDetector(
                    child: Text("See All",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color.fromARGB(255, 59, 48, 214),
                            fontFamily: "Candara")),
                    onTap: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                seeallpage("Popular Courses", 1)));*/
                    },
                  )
                ],
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: upComingEvents,
                  )),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("New Students",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: "Candara",
                          fontSize: 22,
                          color: Colors.black)),
                  GestureDetector(
                    child: Text("See All",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color.fromARGB(255, 59, 48, 214),
                            fontFamily: "Candara")),
                    onTap: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                seeallpage("Popular Courses", 1)));*/
                    },
                  )
                ],
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: newStudents,
                  )),
            ],
          ),
        ),
      ),
    );
    //Mentees Page
    homePage.add(
      Container(
          padding: EdgeInsets.all(15),
          child: menteeData
      ),
    );*/

    //pageData = homePage[1];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 194, 193, 193),
        title: Center(
          child: Text(
            title,
            style: TextStyle(fontFamily: "Candara"),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed:(){ Scaffold.of(context).openDrawer();},
              icon: Icon(Icons.menu,color: Colors.white,),
            );
          },
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: 26.0,
                ),
              )),

        ],
      ),
      drawer: Drawer(
        elevation: 5,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 59, 48, 214),
              ),
              child: Text('MENU'),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {

                Navigator.pop(context);

              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                setState(()  {
                  userName = "";
                  userEmail = "";
                  userId = 0;
                  token = "";
                  classId="";
                });
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => landing()));
              },
            ),
          ],
        ),
      ),
      body: homePage.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notification'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Mentees')
        ],
        currentIndex: _selectedIndex, //_selectedIndex,
        selectedItemColor: Color.fromARGB(255, 59, 48, 214),
        selectedFontSize: 12,
        onTap: _onItemTapped,
      ),
    );
  }
}

enum ConfirmAction { Reject, Invite }
Future<Future<ConfirmAction?>> _asyncConfirmDialog(
    BuildContext context,
    String userName,
    String userBio,
    String modeOfC,
    List<String> selected,
    String comments) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        //title: Text('Delete This Contact?'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Image.asset(
          'images/tick.png',
          height: 50,
          width: 50,
        ),
        content: Container(
          width: double.infinity,
          //height: Wrap(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Candara',
                    ),
                  ),
                  Text(
                    userBio,
                    style: TextStyle(
                        fontFamily: 'Candara',
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 15),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Color.fromARGB(255, 236, 255, 238)),
                    child: Text(
                      'New Student',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontFamily: 'Candara',
                      ),
                    ),
                  ),
                  //OutlinedButton(onPressed: () {}, child: Text('New Student')),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'VIEW PROFILE',
                        style: TextStyle(
                          fontFamily: 'Candara',
                          color: Color.fromARGB(255, 59, 48, 214),
                          decoration: TextDecoration.underline,
                        ),
                      )),
                ],
              ),
              /*Divider(
                color: Colors.grey,
              ),
              SizedBox(height: 10),*/
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.grey,
                    thickness: 2,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mode Of Communication',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Candara',
                    ),
                  ),
                  Text(
                    modeOfC,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontFamily: 'Candara',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Requesting Help For',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Candara',
                    ),
                  ),
                  for (var index = 0; index < selected.length; index++)
                    Text(
                      index.toString() + '. ' + selected[index].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontFamily: 'Candara',
                      ),
                    ),
                  SizedBox(height: 20),
                  Text(
                    'Comments',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Candara',
                    ),
                  ),
                  Text(
                    comments,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontFamily: 'Candara',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  child: const Text(
                    'Reject',
                    style: TextStyle(
                      fontFamily: 'Candara',
                      color: Colors.grey,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(ConfirmAction.Reject);
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 59, 48, 214))),
                  child: Text(
                    'Invite',
                    style: TextStyle(
                      fontFamily: 'Candara',
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(ConfirmAction.Invite);
                  },
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
