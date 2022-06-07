// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, camel_case_types

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_duniya/card_payment.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_duniya/globals.dart';

var mentorDataMap = <String, dynamic>{};
var Mcode=0;


MentorDataResponse mentorDataResponseFromJson(String str) =>
    MentorDataResponse.fromJson(json.decode(str));
String mentorDataResponseToJson(MentorDataResponse data) =>
    json.encode(data.toJson());

class MentorDataResponse {
  MentorDataResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  var message;

  factory MentorDataResponse.fromJson(Map<String, dynamic> json) =>
      MentorDataResponse(
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

  var token;
  var name;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "name": name,
  };
}

class mentorProfile extends StatefulWidget {
  @override
  _mentorProfileState createState() => _mentorProfileState();
}

Future createMentor(Map mentorData, File image) async {
  int responseCode;

  String apiUrl =
      "${BASE}api/mentor/register";
  var uri = Uri.parse(apiUrl);

  var request = http.MultipartRequest("POST", uri);
  request.fields["name"] = mentorData['name'];

  http.MultipartFile multipartFile =
  await http.MultipartFile.fromPath('img', image.path);
  request.files.add(multipartFile);

  request.fields["gender"] = mentorData['gender'];
  request.fields["email"] = mentorData['email'];
  request.fields["school"] = mentorData['school'];
  request.fields["about"] = mentorData['about'];
  request.fields["exp"] = mentorData['exp'];
  request.fields["primary_subject"] = mentorData['primary_subject'];
  request.fields["secondary_subject"] = mentorData['secondary_subject'];
  request.fields["password"] = mentorData['password'];
  request.fields["contact_no"] = mentorData['contact_no'];
  request.fields["state"] = mentorData['state'];
  request.fields["city"] = mentorData['city'];


  // listen for response
  http.Response response = await http.Response.fromStream(await request.send());
  print("Result: ${response.statusCode}");
  //return response.body;

  if (response.statusCode == 200) {
    Mcode=200;
    final String responseString = response.body;
    debugPrint(responseString.toString());
    //debugPrint(response.stream..toString());
    return mentorDataResponseFromJson(responseString);

  }
  if (response.statusCode == 404) {
    Mcode=404;
    MentorDataResponse a = MentorDataResponse(
        success: false,
        data: new Data(token: "", name: ""),
        message: "The email has already been taken.");
    return a;
  }

}

class _mentorProfileState extends State<mentorProfile> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final genderController = TextEditingController();
  final schoolController = TextEditingController();
  final experienceController = TextEditingController();
  final primarySubjectController = TextEditingController();
  final secondarySubjectController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final bioController = TextEditingController();

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }
  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;
      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text('Mentor Profile Page'),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //imageProfile(),
                    GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        radius: 40,
                        backgroundImage: image != null
                            ? FileImage(image!)
                            : AssetImage('images/mentorProfile.jpeg')
                        as ImageProvider,
                        /*child: Container(
                          padding: EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: image != null
                                ? Image.file(image!)
                                : Image.asset('images/mentorProfile.jpeg'),
                          ),
                        ),*/
                      ),
                      onTap: () {
                        //pickImage();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Center(
                                    child: Text('Select Image',
                                        style:
                                        TextStyle(fontFamily: 'Candara'))),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(Colors.deepPurple),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                      side: BorderSide(
                                                          color: Colors
                                                              .deepPurple)))),
                                          onPressed: () {
                                            pickImage();
                                          },
                                          child: Wrap(
                                            children: <Widget>[
                                              Icon(
                                                Icons.image,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('Gallery',
                                                  style: TextStyle(
                                                      fontFamily: 'Candara',
                                                      fontSize: 18))
                                            ],
                                          )),
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(Colors.deepPurple),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                      side: BorderSide(
                                                          color: Colors
                                                              .deepPurple)))),
                                          onPressed: () {
                                            pickImageCamera();
                                          },
                                          child: Wrap(
                                            children: <Widget>[
                                              Icon(
                                                Icons.camera,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('Camera',
                                                  style: TextStyle(
                                                      fontFamily: 'Candara',
                                                      fontSize: 18))
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Change your profile picture',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Candara',
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '* Image size not more than 2 mb',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontFamily: 'Candara',
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Full Name',
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
                    hintText: 'Full Name',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Email Address',
                  style: TextStyle(fontFamily: 'Candara'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'abc@email.com',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Phone Number',
                  style: TextStyle(fontFamily: 'Candara'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: phoneController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '+91 - 12345678790',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Password',
                  style: TextStyle(fontFamily: 'Candara'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Confirm Password',
                  style: TextStyle(fontFamily: 'Candara'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Select Your Gender',
                  style: TextStyle(fontFamily: 'Candara'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: genderController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Gender',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Current School Attending',
                  style: TextStyle(fontFamily: 'Candara'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: schoolController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'XYZ International School',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Experience in Years',
                  style: TextStyle(fontFamily: 'Candara'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: experienceController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'XX',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Primary Subject',
                  style: TextStyle(fontFamily: 'Candara'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: primarySubjectController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Subject Name',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Secondary Subject',
                  style: TextStyle(fontFamily: 'Candara'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: secondarySubjectController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Subject Name',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'City',
                  style: TextStyle(fontFamily: 'Candara'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: cityController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'eg. Delhi, Chennai',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'State',
                  style: TextStyle(fontFamily: 'Candara'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: stateController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'eg. Rajasthan, Uttar Pradesh',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Add your bio',
                  style: TextStyle(fontFamily: 'Candara'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: bioController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Mentor Bio',
                    hintStyle: TextStyle(fontFamily: 'Candara'),
                  ),
                  maxLines: 5,
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.deepPurple)))),
                      onPressed: () async {
                        if (nameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            confirmPasswordController.text.isEmpty ||
                            genderController.text.isEmpty ||
                            schoolController.text.isEmpty ||
                            experienceController.text.isEmpty ||
                            primarySubjectController.text.isEmpty ||
                            secondarySubjectController.text.isEmpty ||
                            cityController.text.isEmpty ||
                            stateController.text.isEmpty ||
                            bioController.text.isEmpty) {
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
                        } else if (passwordController.text ==
                            confirmPasswordController.text) {
                          mentorDataMap['name'] = nameController.text;
                          mentorDataMap['img'] = image;
                          mentorDataMap['gender'] = genderController.text;
                          mentorDataMap['email'] = emailController.text;
                          mentorDataMap['school'] = schoolController.text;
                          mentorDataMap['about'] = bioController.text;
                          mentorDataMap['exp'] = experienceController.text;
                          mentorDataMap['primary_subject'] =
                              primarySubjectController.text;
                          mentorDataMap['secondary_subject'] =
                              secondarySubjectController.text;
                          mentorDataMap['password'] = passwordController.text;
                          mentorDataMap['contact_no'] = phoneController.text;
                          mentorDataMap['state'] = stateController.text;
                          mentorDataMap['city'] = cityController.text;
                          debugPrint(mentorDataMap.toString());

                          if(image!=null){
                            MentorDataResponse s =await createMentor(mentorDataMap, image!);
                            debugPrint(s.data.token.toString());
                            if(Mcode==200)
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => cardPayment((s.data.token.toString()))),
                              );
                            else if(Mcode==404)
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Email already taken'),
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
                          else
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text('Please enter an image'),
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
                        else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Password does not match'),
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
                      },
                      child: Text(
                        'SAVE INFORMATION',
                        style: TextStyle(
                            fontFamily: 'Candara',
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}