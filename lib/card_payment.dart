// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:learning_duniya/globals.dart';
import 'package:learning_duniya/landing.dart';
import 'package:learning_duniya/profile.dart';
var Token;
var Acode=0;
MentorAccountDataResponse mentorAccountDataResponseFromJson(String str) =>
    MentorAccountDataResponse.fromJson(json.decode(str));
String mentorAccountDataResponseToJson(MentorAccountDataResponse data) =>
    json.encode(data.toJson());

class MentorAccountDataResponse {
  MentorAccountDataResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  int status;

  factory MentorAccountDataResponse.fromJson(Map<String, dynamic> json) =>
      MentorAccountDataResponse(
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
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  var id;
  var userId;
  var  eduName;
  var specilization;
  var secondarySubject;
  dynamic exp;
  var aboutUs;
  var phone;
  var country;
  var  state;
  var city;
  var nameAsAccount;
  var  accountNo;
  var  ifscCode;
  var branch;
  var reviews;
  var  likes;
  var  img;
  var  createdAt;
  var  updatedAt;
  var status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    createdAt:json["created_at"],
    updatedAt: json["updated_at"],
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
    "created_at": createdAt,
    "updated_at": updatedAt,
    "status": status,
  };
}

Future<MentorAccountDataResponse> addBankDetails(
    String name, String accountNumber, String ifscCode, String branch) async {
  final String apiUrl =
      "${BASE}api/mentor/account_details";

  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String> {
        "Authorization": "Bearer $token",
      },
      body: {
        "name_as_account": name.toString(),
        "account_no": accountNumber.toString(),
        "ifsc_code": ifscCode.toString(),
        "branch": branch.toString()
      });

  if (response.statusCode == 200) {
    Acode=200;
    final String responseString = response.body;
    print(responseString);
    return mentorAccountDataResponseFromJson(responseString);
  } else {
    throw Exception("failed");
  }
}

class cardPayment extends StatefulWidget {

  late String tok;

  cardPayment(this.tok);

  @override
  _cardPayment createState() => _cardPayment(tok);
}

class _cardPayment extends State<cardPayment> {
  late String _tok;

  _cardPayment(this._tok);

  final nameController = TextEditingController();
  final accountContoller = TextEditingController();
  final confirmAccountController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final branchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Token=_tok;
    token=Token;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(
          child: Text('Payment Method'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name as in Account',
                style: TextStyle(fontFamily: 'Candara'),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                  hintStyle: TextStyle(fontFamily: 'Candara'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              /*Text(
                'Bank Name',
                style: TextStyle(fontFamily: 'Candara'),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Bank Name',
                  hintStyle: TextStyle(fontFamily: 'Candara'),
                ),
              ),
              SizedBox(
                height: 20,
              ),*/
              Text(
                'Account Number',
                style: TextStyle(fontFamily: 'Candara'),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: accountContoller,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Bank Account Number',
                  hintStyle: TextStyle(fontFamily: 'Candara'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Confirm Account Number',
                style: TextStyle(fontFamily: 'Candara'),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: confirmAccountController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Bank Account Number',
                  hintStyle: TextStyle(fontFamily: 'Candara'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'IFSC Code',
                style: TextStyle(fontFamily: 'Candara'),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: ifscCodeController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
                ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Bank IFSC Code',
                  hintStyle: TextStyle(fontFamily: 'Candara'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Branch',
                style: TextStyle(fontFamily: 'Candara'),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: branchController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Branch',
                  hintStyle: TextStyle(fontFamily: 'Candara'),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.deepPurple),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side:
                                BorderSide(color: Colors.deepPurple)))),
                    onPressed: () async {
                      if (nameController.text.isEmpty ||
                          accountContoller.text.isEmpty ||
                          confirmAccountController.text.isEmpty ||
                          ifscCodeController.text.isEmpty ||
                          branchController.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Please fill all the fields'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      } else if (accountContoller.text ==
                          confirmAccountController.text) {
                        debugPrint("Name: " + nameController.text);
                        debugPrint("Account Number: " + accountContoller.text);
                        debugPrint("IFSC Code: " + ifscCodeController.text);
                        debugPrint("Branch: " + branchController.text);

                        MentorAccountDataResponse v= await addBankDetails(
                            nameController.text,
                            accountContoller.text,
                            ifscCodeController.text,
                            branchController.text);
                        if (Acode==200)
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Thank you!'),
                                  content: Text('Your request to become a mentor has been sent successfully'),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    landing()));
                                      },
                                    )
                                  ],
                                );
                              });

                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text('Account Number does not match'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: Text('Close'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      }

                      /*
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => cardPayment()),
                        );*/
                    },
                    child: Text(
                      'ADD ACCOUNT',
                      style: TextStyle(
                          fontFamily: 'Candara',
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
