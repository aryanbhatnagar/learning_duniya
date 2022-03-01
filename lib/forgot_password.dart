import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


Fpass fpassFromJson(String str) => Fpass.fromJson(json.decode(str));
String fpassToJson(Fpass data) => json.encode(data.toJson());
late Fpass? _fp =null;
int fcode=0;

class Fpass {
  Fpass({
    required this.msg,
  });

  String msg;

  factory Fpass.fromJson(Map<String, dynamic> json) => Fpass(
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
  };
}

Future<Fpass> createfpass(String email) async{
  final String apiUrl = "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/password/email";

  final response = await http.post(Uri.parse(apiUrl), body: {
    "email": email
  });

  if(response.statusCode == 200) {
    fcode=200;
    final String responseString = response.body;
    return fpassFromJson(responseString);
  }

  else{
    throw Exception("failed");
  }
}

class forgot extends StatefulWidget {
  const forgot({Key? key}) : super(key: key);


  @override
  _forgotState createState() => _forgotState();
}



class _forgotState extends State<forgot> {

  late String _email;
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(25),
            color: Colors.white,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text("Forgot Password?",style: TextStyle(fontSize: 25,fontFamily: "Candara",color: Colors.teal),),
                  SizedBox(height: 30),
                  Text("Enter your registered E-mail to reset Passwrod",style: TextStyle(fontSize: 15,fontFamily: "Candara",color: Colors.black),),
                  SizedBox(height: 10),
                  TextFormField(
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
                  RaisedButton(
                    onPressed: () async {
                      _email=emailController.text;
                      Fpass fp = await createfpass(_email);

                      setState(() {
                        _fp=fp;
                      });
                      if(fcode==200){
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Reset Password"),
                            content: const Text('Reset password request generated.\nGo to your registered email address to reset password'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK',style: TextStyle(color: Colors.teal))
                              ),
                            ],
                          ),
                        );
                        fcode=0;
                      }
                    },
                    child: Text('SUBMIT',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontFamily: "Candara")),
                    color: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  )

                ],
              ),
            ),

          ),
        ),
      ),
    );
  }
}
