import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:learning_duniya/Login.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'globals.dart';



User1 user1FromJson(String str) => User1.fromJson(json.decode(str));
String user1ToJson(User1 data) => json.encode(data.toJson());

class User1 {
  User1({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory User1.fromJson(Map<String, dynamic> json) => User1(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    required this.token,
    required this.name,
  });

  String token;
  String name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "name": name,
  };
}



class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);



  @override
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
              child: SignUpPage(),

            ),
          ),
        )
    );
  }
}


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}



Future<User1> createUser(String name, String phone, String email, String password) async{
  final String apiUrl = "${BASE}api/register";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "name": name,
    "contact_no": phone,
    "email": email,
    "password": password
  });

  if(response.statusCode == 200) {
    code=200;
    final String responseString = response.body;
    return user1FromJson(responseString);
  }
  if(response.statusCode==404){
    code=404;
    User1 a=new User1(success: false, data:new Data(token: "", name:""), message: "Email id already taken");
    return a;
  }
  else
    {
      throw Exception('failed');
    }

}



class _SignUpPageState extends State<SignUpPage> {

  late User1? _user=null;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late String _email, _password, _name, _phone;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Container(
              //height: 150,
              child: Image(
                image: AssetImage("images/SignUp_top.png"),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          validator: (input) {
                            if (input!.isEmpty) return 'Enter Name';
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            //fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(5.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.teal, width: 2.0),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            labelText: 'NAME',
                            labelStyle: TextStyle(fontFamily: "Candara"),
                            prefixIcon: Icon(Icons.person, color: Colors.teal),
                            fillColor: Colors.grey,
                            focusColor: Colors.grey,
                          ),
                          // onSaved: (input) => _name = input!
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          validator: (input) {
                            if (input!.length < 10)
                              return 'Provide Minimum 10 Digits';
                          },
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.teal, width: 2.0),
                                borderRadius: BorderRadius.circular(5)),
                            labelText: 'PHONE NUMBER',
                            labelStyle: TextStyle(fontFamily: "Candara"),
                            prefixIcon: Icon(Icons.phone, color: Colors.teal),
                            fillColor: Colors.grey,
                            focusColor: Colors.teal,
                          ),
                          //padding: EdgeInsets.fromLTRB(20,20,20,20),
                          // onSaved: (input) => _phone = input!
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: TextFormField(
                          controller: emailController,
                          validator: (input) {
                            if (input!.isEmpty) return 'Enter Email';
                          },
                          decoration: InputDecoration(
                            //fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.teal, width: 2.0),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            labelText: 'E-MAIL',
                            labelStyle: TextStyle(fontFamily: "Candara"),
                            prefixIcon: Icon(Icons.email, color: Colors.teal),
                            fillColor: Colors.grey,
                            focusColor: Colors.grey,
                          ),
                          //onSaved: (input) => _email = input!
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40),

                        child: TextFormField(

                          validator: (input) {
                            if (input!.length < 6)
                              return 'Provide Minimum 6 Characters';
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(5)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.teal, width: 2.0),
                                borderRadius: BorderRadius.circular(5)),
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(fontFamily: "Candara"),
                            prefixIcon: Icon(Icons.lock, color: Colors.teal),
                            fillColor: Colors.grey,
                            focusColor: Colors.teal,
                          ),
                          obscureText: true,
                          //padding: EdgeInsets.fromLTRB(20,20,20,20),
                          //onSaved:  (input) => _password = input!
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: RaisedButton(
                          onPressed: () async {
                            if(_formKey.currentState!.validate()) {
                              _name = nameController.text;
                              _phone = phoneController.text;
                              _email = emailController.text;
                              _password = passwordController.text;

                              User1 user = await createUser(
                                  _name, _phone, _email, _password);
                              setState(()  {
                                _user = user;
                              });
                            }
                            if(code==200)
                              {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Login()));
                              }
                            if(code==404)
                              {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text("Registration Unsuccessful!"),
                                    content: const Text('Email already registered'),
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
                          child: Text('REGISTER',
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
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Center(child: Text(
                                "Already Registered? Sign in here",
                                style: TextStyle(fontFamily: "Candara",
                                    fontSize: 15,
                                    color: Colors.grey))),
                            RaisedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Login()));
                              },
                              child: Text('SIGN IN',
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
                      SizedBox(height: 40),

                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}


