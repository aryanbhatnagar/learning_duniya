import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:learning_duniya/Dashboard.dart';
import 'package:learning_duniya/SignUp.dart';
import 'package:http/http.dart' as http;
import 'package:learning_duniya/forgot_password.dart';
import 'package:learning_duniya/main.dart';
import 'package:learning_duniya/profile.dart';
import 'globals.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'landing.dart';

late Login1? _log =null;
late Map x;

Login1 login1FromJson(String str) => Login1.fromJson(json.decode(str));
String login1ToJson(Login1 data) => json.encode(data.toJson());
class Login1 {
  Login1({
    required this.token,
    required this.user,
    required this.role,
    required this.status,
  });

  String token;
  User user;
  var role;
  int status;

  factory Login1.fromJson(Map<String, dynamic> json) => Login1(
    token: json["token"],
    user: User.fromJson(json["user"]),
    role: json["role"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user.toJson(),
    "role": role,
    "status": status,

  };
}
class User {
  User({
    required this.id,
    required this.name,
    this.lastName,
    required this.email,
    this.contactNo,
    this.emailVerifiedAt,
    this.preference,
    this.registerFrom,
    this.registerRegion,
    this.registerCity,
    required this.role,
    this.school,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  var id;
  var name;
  dynamic lastName;
  var email;
  dynamic contactNo;
  dynamic emailVerifiedAt;
  dynamic preference;
  dynamic registerFrom;
  dynamic registerRegion;
  dynamic registerCity;
  var role;
  dynamic school;
  var status;
  var createdAt;
  var updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    lastName: json["last_name"],
    email: json["email"],
    contactNo: json["contact_no"],
    emailVerifiedAt: json["email_verified_at"],
    preference: json["preference"],
    registerFrom: json["register_from"],
    registerRegion: json["register_region"],
    registerCity: json["register_city"],
    role: json["role"],
    school: json["school"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "last_name": lastName,
    "email": email,
    "contact_no": contactNo,
    "email_verified_at": emailVerifiedAt,
    "preference": preference,
    "register_from": registerFrom,
    "register_region": registerRegion,
    "register_city": registerCity,
    "role": role,
    "school": school,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

Future<void> _incrementCounter(int role) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  prefs.setString('role', role.toString());
  prefs.setString('token', token);
  prefs.setString('username', userName);

}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}


Future<Login1> createLogin(String email, String password) async{
  final String apiUrl = "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/login";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "email": email,
    "password": password
  });

  if(response.statusCode == 200) {
    loginCode=200;
    x=jsonDecode(response.body);
    token=x["token"];
    if(x["role"]=="2")
      {
        print("2");
        Login1 b=new Login1(
            token: "", user: new User(id: 0, name: "", email: "", role: "", status: "", createdAt: DateTime.now(), updatedAt: DateTime.now()),role: "999", status:0);
        return b;
      }
    else{
      final String responseString = response.body;
      return login1FromJson(responseString);
    }

  }
  if(response.statusCode == 401) {
    loginCode=401;
    Login1 b=new Login1(
        token: "", user: new User(id: 0, name: "", email: "", role: "", status: "", createdAt: DateTime.now(), updatedAt: DateTime.now()),role: "999", status:0);
    return b;
  }
  else{
    throw Exception("failed");
  }
}

class _LoginPageState extends State<Login> {

  @override
  void initState() {
    super.initState();
    if(token!=""){
      print(userName);
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(classId)));
      //Navigator.push(context,MaterialPageRoute(builder: (context)=>Dashboard()));
    }
    //lse
      //build(context);
  }



  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late String _email,_password;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: Container(
              height: size.height,
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("images/bg.png"),
                    fit: BoxFit.cover,
                  )
              ),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:<Widget> [
                      SizedBox(height: 65),
                      Container(
//height: 150,
                        child: Image(
                          image: AssetImage("images/login_top.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        child: Form(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 40,right: 40),
                                  child: TextFormField(
                                    controller: emailController,
                                    validator: (input) {
                                      if (input!.isEmpty) return 'Enter Email';
                                    },
                                    decoration: InputDecoration(
//fillColor: Colors.white,

                                      enabledBorder:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                          borderRadius: BorderRadius.circular(5)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.teal,width: 2.0),
                                          borderRadius: BorderRadius.circular(5)
                                      ),
                                      labelText: 'E-MAIL',
                                      labelStyle: TextStyle(fontFamily: "Candara"),
                                      prefixIcon: Icon(Icons.email,color: Colors.teal),
                                      fillColor: Colors.grey,
                                      focusColor: Colors.grey,
                                    ),
// onSaved: (input) => _email = input!
                                  ),
                                ),
                                SizedBox(height: 15),
                                Container(
                                  padding: EdgeInsets.only(left: 40,right: 40),

                                  child: TextFormField(
                                    controller: passwordController,
                                    validator: (input) {
                                      if (input!.length < 6)
                                        return 'Provide Minimum 6 Character';
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder:OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                          borderRadius: BorderRadius.circular(5)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(color: Colors.teal,width: 2.0),
                                          borderRadius: BorderRadius.circular(5)),
                                      labelText: 'PASSWORD',
                                      labelStyle: TextStyle(fontFamily: "Candara"),
                                      prefixIcon: Icon(Icons.lock,color: Colors.teal),
                                      fillColor: Colors.grey,
                                      focusColor: Colors.teal,
                                    ),
                                    obscureText: true,
//padding: EdgeInsets.fromLTRB(20,20,20,20),
//onSaved: (input) => _password = input!
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 40,right: 40,top:5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap:(){Navigator.push(context,MaterialPageRoute(builder: (context)=>forgot()));},
                                        child: Text("FORGOT PASSWORD",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.grey)),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(left: 40,right: 40),
                                  child: RaisedButton(
                                    onPressed: () async {
                                      _email=emailController.text;
                                      _password=passwordController.text;
                                      Login1 log = await createLogin(_email, _password);

                                      setState(() {
                                        _log=log;
                                      });

                                      if(loginCode==200) {
                                        setState(() {
                                          token = _log!.token;
                                          userId = _log!.user.id;
                                          userName = _log!.user.name;
                                          userEmail = _log!.user.email;
                                        });
                                        if (_log!.role == "1") {
                                          if (classId != "") {
                                            await _incrementCounter(1);
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Dashboard(classId)));
                                          }
                                          else {
                                            final Future<
                                                ConfirmAction?> action =
                                            await _asyncConfirmDialog(
                                                context,
                                                'Mentor Name',
                                                'Mentor Bio',
                                                'Communication',
                                                [],
                                                'None');
                                          }

                                        }
                                        else if(x["role"]=="2"){
                                          setState(() {
                                            token=x["token"];
                                          });
                                          await _incrementCounter(2);
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      profile()));}
                                      }

                                      if(loginCode==401){
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) => AlertDialog(
                                            title: const Text("Unauthorized Login"),
                                            content: const Text('Invalid Login Credentials'),
                                            actions: <Widget>[
                                              TextButton(
                                                  onPressed: () => Navigator.pop(context, 'OK'),
                                                  child: const Text('OK',style: TextStyle(color: Colors.teal))
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                    child: Text('SIGN IN',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0,
                                            fontFamily: "Candara")),
                                    color: Colors.teal,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40),
                                Container(
                                  padding: EdgeInsets.only(left: 40,right: 40),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Center(child: Text("New Customer? Sign Up here",style: TextStyle(fontFamily: "Candara",fontSize: 15,color: Colors.grey))),
                                      RaisedButton(
                                        onPressed: (){
                                          Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUp()));
                                        },
                                        child: Text('SIGN UP',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                                fontFamily: "Candara")),
                                        color: Colors.deepOrange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 150)
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ),
          ),
        )
    );
  }
}

final TextEditingController classController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String _dropDownValue="";
enum ConfirmAction { Confirm }
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
      String _currentSelectedVakue='';


      return AlertDialog(
        //title: Text('Delete This Contact?'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        title: Image.asset(
          'images/english.png',
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
                    "Please Enter your Class",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Candara',
                    ),
                  ),
                  SizedBox(height: 20),
                  /*Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(

                        controller: classController,
                        validator: (input) {
                          if (input!.isEmpty) return 'Enter Class';
                        },
                        decoration: InputDecoration(
//fillColor: Colors.white,

                          enabledBorder:OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.teal,width: 2.0),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          labelText: 'CLASS',
                          labelStyle: TextStyle(fontFamily: "Candara"),
                          prefixIcon: Icon(Icons.school,color: Colors.teal),
                          fillColor: Colors.grey,
                          focusColor: Colors.grey,
                        ),
// onSaved: (input) => _email = input!
                      ),
                    ),
                  ),*/
                  FormField<String>(
                    builder: (FormFieldState<String> state) {
                      String _currentSelectedValue='';
                      return Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            //labelText: 'CLASS',
                              prefixIcon: Icon(Icons.school,color: Colors.teal),
                              labelStyle: TextStyle(fontFamily: "Candara"),
                              errorStyle: TextStyle(fontFamily:"Candara",color: Colors.redAccent, fontSize: 16.0),
                              //hintText: 'Please select expense',
                              enabledBorder:OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(5)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.teal,width: 2.0),
                                  borderRadius: BorderRadius.circular(5)
                              )),
                          //border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                          isEmpty: _currentSelectedValue == '',
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                menuMaxHeight: 200,
                                hint: _dropDownValue == null
                                    ? Text('Dropdown')
                                    : Text(
                                  _dropDownValue,
                                  style: TextStyle(fontFamily: "Candara",color: Colors.black,fontSize: 16),
                                ),
                                isExpanded: false,
                                iconSize: 30.0,
                                style: TextStyle(color: Colors.black),
                                items: ["LKG","UKG","1", "2","3", "4","5", "6","7", "8","9", "10","11", "12"].map(
                                      (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String? val) {
                                  _dropDownValue = val!;
                                  (context as Element).markNeedsBuild();

                                },
                              )
                          ),
                        ),
                      );
                    },
                  ),

                ],
              ),
              /*Divider(
                color: Colors.grey,
              ),
              SizedBox(height: 10),*/

            ],
          ),
        ),
        actions: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.teal)),
                  child: Text(
                    'CONFIRM',
                    style: TextStyle(
                      fontFamily: 'Candara',
                    ),
                  ),
                  onPressed: () {
                    print(_dropDownValue);
                    if(_dropDownValue!="")
                    {
                      classId=_dropDownValue;
                      if(classId!="")
                      {
                        Navigator.of(context).pop(ConfirmAction.Confirm);
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => landing()));
                      }


                    }
                    //Navigator.of(context).pop(ConfirmAction.Confirm);
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
