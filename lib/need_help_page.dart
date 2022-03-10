import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_duniya/CategorySetting.dart';
import 'package:learning_duniya/globals.dart';
import 'package:learning_duniya/mentor.dart';

late List<String> moc;
int ComCode=0;
late Comm? _comm =null;

Comm commFromJson(String str) => Comm.fromJson(json.decode(str));
String commToJson(Comm data) => json.encode(data.toJson());

class Comm {
  Comm({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  int status;

  factory Comm.fromJson(Map<String, dynamic> json) => Comm(
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
    required this.educatorId,
    required this.userId,
    required this.category,
    required this.modeCommunication,
    required this.message,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String educatorId;
  int userId;
  var category;
  String modeCommunication;
  String message;
  dynamic updatedAt;
  dynamic createdAt;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    educatorId: json["educator_id"],
    userId: json["user_id"],
    category: json["category"],
    modeCommunication: json["mode_communication"],
    message: json["message"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "educator_id": educatorId,
    "user_id": userId,
    "category": category,
    "mode_communication": modeCommunication,
    "message": message,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}

Future<Comm> createComm(String edu_id, String commm, String msg) async{
  final String apiUrl = "http://ec2-13-234-116-155.ap-south-1.compute.amazonaws.com/api/add/communication";

  final response = await http.post(Uri.parse(apiUrl),
    headers: <String, String> {
      "Authorization": "Bearer $token",
      //'Content-Type': 'application/json; charset=UTF-8',
    },
    body: <String,dynamic>{
      "educator_id":edu_id,
      "category": "",
      "mode_communication":commm,
      "message":msg

    },
  );

  if(response.statusCode == 200) {

    ComCode=200;
    print(ComCode);
    final String responseString = response.body;
    print(responseString);
    return commFromJson(responseString);
  }
  if(response.statusCode == 500) {
    ComCode=500;
    print(ComCode);
    throw Exception("failed");

  }
  else{
    print(0);
    throw Exception("failed");
  }
}


class need_help_page extends StatefulWidget {
  need_help_page(List<String> serviceList);

  @override
  _needHelpPageState createState() => _needHelpPageState(serviceList);
}

class _needHelpPageState extends State<need_help_page> {
  _needHelpPageState(List<String> serviceList);
  List <String> selected = [];
  String? curValue1, curValue2;
  String comun="";
  final TextEditingController comment = TextEditingController();


  final catNew = [
    CategorySetting(title: 'Study'),
    CategorySetting(title: 'Art & Entertainment'),
    CategorySetting(title: 'Health & Fitness'),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text("Request Help",style: TextStyle(fontFamily: "Candara"),),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(20),bottomRight: Radius.circular(20)),
                color: Colors.teal[100],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    userName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: "Candara"),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Would Like To Know",
                    style: TextStyle(fontSize: 18,fontFamily: "Candara"),
                    textAlign: TextAlign.left,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 153, 0, 255))),
                      onPressed: () {},
                      child: Text("View Profile",style: TextStyle(fontFamily: "Candara"),textAlign: TextAlign.left,)),
                ],
              ),
            ),
            Divider(
              color: Color.fromARGB(255, 218, 217, 217),
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Mode Of Communication ",
                        style: TextStyle(fontFamily: "Candara",
                            fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ],
                  ),
                  DropdownButton<String>(
                    hint: Text(
                      "Select Mode",
                      style: TextStyle(fontSize: 15,fontFamily: "Candara"),
                    ),
                    value: curValue1,
                    items: serviceList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(fontFamily: "Candara"),),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => this.curValue1 = value),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Category Of Required Help ",
                        style: TextStyle(fontFamily: "Candara",
                            fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ],
                  ),
                  ...catNew.map(buildSingleCheckbox).toList(),
                  /*DropdownButton<String>(
                    hint: Text(
                      "Comments",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    value: curValue2,
                    items: itm2.map(buildMenuItem2).toList(),
                    onChanged: (value) =>
                        setState(() => this.curValue2 = value),
                  ),*/
                  Row(
                    children: [
                      Text("Comment",
                          style: TextStyle(
                            fontFamily: "Candara",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      //Icon(Icons.arrow_drop_down,color: Colors.black, size: 30),
                    ],
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input!.isEmpty)
                        return 'Enter comment';
                    },
                    controller: comment,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('Request Help ',style: TextStyle(fontFamily: "Candara"),),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                    onPressed: () async {
                      print(selected);
                      print(123);
                      Comm com;
                      if(comment.text.isEmpty)
                        com = await createComm("1",curValue1!,"No message");
                      else
                        com = await createComm("1",curValue1!,comment.text.toString());
                      setState(() {
                        _comm=com;
                      });
                      if(ComCode==200) {
                        Navigator.pop(context);
                        final Future<ConfirmAction?> action =
                        await _asyncConfirmDialog(
                            context, userName, selected);
                        print("Confirm Action $action");
                      }
                      if(ComCode==500)
                        {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Cant send request"),
                              content: Text("Unauthenticated"),
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
                  ),
                )),
            Divider(
              color: Color.fromARGB(255, 218, 217, 217),
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSingleCheckbox(CategorySetting catValue) => buildCheckbox(
    categorySetting: catValue,
    onClicked: () {
      setState(() {
        final newValue = !catValue.value;
        catValue.value = newValue;
        if (catValue.value != false) {
          selected.add(catValue.title.toString());
        } else {
          selected.remove(catValue.title.toString());
        }
      });
    },
  );

  Widget buildCheckbox ({
    required CategorySetting categorySetting,
    required onClicked,
  }) =>
      ListTile(
        onTap: onClicked,
        leading: Checkbox(
          value: categorySetting.value,
          onChanged: (value) => onClicked(),
        ),
        title: Text(categorySetting.title,
            style: TextStyle(
              fontFamily: "Candara",
              fontSize: 15,
              color: Colors.grey,
            )),
      );

  setstate(Null Function() param0) {}
}

enum ConfirmAction { Cancel, Accept }
Future<Future<ConfirmAction?>> _asyncConfirmDialog(
    BuildContext context, String name, List<String> selected) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        //title: Text('Delete This Contact?'),

        title: Image.asset(
          'images/tick.png',
          height: 50,
          width: 50,
        ),
        content: Text('The request has been sent successfully to ${name}' +
            '\n\nHelp requested for: \n' +
            selected.join("\n")),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel Request'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.Cancel);
            },
          ),
          ElevatedButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.Accept);
            },
          )
        ],
      );
    },
  );
}