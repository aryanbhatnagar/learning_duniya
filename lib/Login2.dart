import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:learning_duniya/Dashboard.dart';
import 'package:learning_duniya/SignUp.dart';
import 'package:http/http.dart' as http;
import 'package:learning_duniya/forgot_password.dart';
import 'package:learning_duniya/main.dart';
import 'globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

late Login1? _log =null;
Login1 login1FromJson(String str) => Login1.fromJson(json.decode(str));
String login1ToJson(Login1 data) => json.encode(data.toJson());

class Login1 {
  Login1({
    required this.token,
    required this.user,
    required this.status,
  });

  String token;
  User user;
  int status;

  factory Login1.fromJson(Map<String, dynamic> json) => Login1(
    token: json["token"],
    user: User.fromJson(json["user"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user.toJson(),
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

  int id;
  String name;
  dynamic lastName;
  String email;
  dynamic contactNo;
  dynamic emailVerifiedAt;
  dynamic preference;
  dynamic registerFrom;
  dynamic registerRegion;
  dynamic registerCity;
  String role;
  dynamic school;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

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
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}



class Login2 extends StatefulWidget {
  const Login2({Key? key}) : super(key: key);

  @override
  _Login2PageState createState() => _Login2PageState();
}


Future<Login1> createLogin(String email, String password) async{
  final String apiUrl = "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/login";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "email": email,
    "password": password
  });

  if(response.statusCode == 200) {
    loginCode=200;
    final String responseString = response.body;
    return login1FromJson(responseString);
  }
  if(response.statusCode == 401) {
    loginCode=401;
    Login1 b=new Login1(
        token: "", user: new User(id: 0, name: "", email: "", role: "", status: "", createdAt: DateTime.now(), updatedAt: DateTime.now()), status:0);
    return b;
  }
  else{
    throw Exception("failed");
  }
}

class _Login2PageState extends State<Login2> {

  @override
  void initState() {
    super.initState();
    if(token!=""){
      print(userName);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
      //Navigator.push(context,MaterialPageRoute(builder: (context)=>Dashboard()));
    }
    else
      build(context);
  }



  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late String _email,_password;

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: SafeArea(
            child: Container(
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

                                      if(loginCode==200){

                                        token=log!.token;
                                        userId=log!.user.id;
                                        userName=log!.user.name;
                                        userEmail=log!.user.email;
                                        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                        sharedPreferences.setString('token', _log!.token);
                                        sharedPreferences.setString('name', _log!.user.name);
                                        Navigator.pop(context);
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
