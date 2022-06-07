import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_duniya/CategorySetting.dart';
import 'package:learning_duniya/globals.dart';
import 'package:learning_duniya/mentor.dart';

late List<String> moc;
int ComCode = 0;
late Comm? _comm = null;
var mentor;
int count = -1;

ConvJson1 convJson1FromJson(String str) => ConvJson1.fromJson(json.decode(str));
String convJson1ToJson(ConvJson1 data) => json.encode(data.toJson());

class ConvJson1 {
  ConvJson1({
    required this.educatorId,
    required this.serviceId,
    required this.category,
    required this.modeCommunication,
    required this.message,
  });

  var educatorId;
  var serviceId;
  List<String> category;
  var modeCommunication;
  var message;

  factory ConvJson1.fromJson(Map<String, dynamic> json) => ConvJson1(
        educatorId: json["educator_id"],
        serviceId: json["service_id"],
        category: List<String>.from(json["category"].map((x) => x)),
        modeCommunication: json["mode_communication"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "educator_id": educatorId,
        "service_id": serviceId,
        "category": List<dynamic>.from(category.map((x) => x)),
        "mode_communication": modeCommunication,
        "message": message,
      };
}

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

Future<Comm> createComm(String edu_id, String serv_id, String commm, String msg,
    List<String> communication) async {
  ConvJson1 convert = new ConvJson1(
      educatorId: edu_id,
      serviceId: serv_id,
      category: communication,
      modeCommunication: commm,
      message: msg);
  final String apiUrl =
      "${BASE}api/add/communication";

  final response = await http.post(Uri.parse(apiUrl),
      headers: <String, String>{
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(convert.toJson()));

  if (response.statusCode == 200) {
    ComCode = 200;
    print(ComCode);
    final String responseString = response.body;
    print(responseString);
    return commFromJson(responseString);
  }
  if (response.statusCode == 500) {
    debugPrint(json.encode(convert.toJson()).toString());
    ComCode = 500;
    print(response.body.toString());
    print(ComCode);
    throw Exception("failed");
  } else {
    debugPrint(json.encode(convert.toJson()).toString());
    print(0);
    throw Exception("failed");
  }
}

FieldData fieldDataFromJson(String str) => FieldData.fromJson(json.decode(str));
String fieldDataToJson(FieldData data) => json.encode(data.toJson());

class FieldData {
  FieldData({
    required this.data2,
    required this.message,
    required this.status,
  });

  Data2 data2;
  var message;
  var status;

  factory FieldData.fromJson(Map<String, dynamic> json) => FieldData(
        data2: Data2.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data2.toJson(),
        "message": message,
        "status": status,
      };
}

class Data2 {
  Data2({
    required this.modeCommunication,
    required this.categories,
  });

  List<String> modeCommunication;
  List<String> categories;

  factory Data2.fromJson(Map<String, dynamic> json) => Data2(
        modeCommunication:
            List<String>.from(json["mode_communication"].map((x) => x)),
        categories: List<String>.from(json["categories"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "mode_communication":
            List<dynamic>.from(modeCommunication.map((x) => x)),
        "categories": List<dynamic>.from(categories.map((x) => x)),
      };
}

Future<FieldData> getFormDetails(String id) async {
  final String apiUrl =
      "${BASE}api/get/service/detail";
  final response = await http.post(Uri.parse(apiUrl), headers: <String, String>{
    "Authorization": "Bearer $token",
  }, body: {
    "id": id
  });

  if (response.statusCode == 200) {
    print(response.statusCode.toString());
    final String responseString = response.body;
    debugPrint(response.body);
    return fieldDataFromJson(responseString);
  } else {
    throw Exception('Failed to load album');
  }
}

class need_help_page extends StatefulWidget {
  need_help_page(
      this.serviceList, this.service_Id, this.educator_Id, this.mentorname);
  List<String> serviceList;
  var educator_Id, service_Id, mentorname;

  @override
  _needHelpPageState createState() =>
      _needHelpPageState(serviceList, service_Id, educator_Id, mentorname);
}

class _needHelpPageState extends State<need_help_page> {
  _needHelpPageState(
      this.serviceList, this.service_Id, this.educator_Id, this.mentor_name);
  List<String> serviceList;
  var educator_Id, service_Id;
  List<String> selected = [];
  String? curValue1, curValue2;
  var mentor_name;
  String comun = "";
  final TextEditingController comment = TextEditingController();

  /*final catNew = [
    CategorySetting(title: 'Study'),
    CategorySetting(title: 'Art & Entertainment'),
    CategorySetting(title: 'Health & Fitness'),
  ];*/


  List<bool?> isSelected = List.generate(50, (index) => false);
  @override
  Widget build(BuildContext context) {
    mentor = mentor_name;
    return FutureBuilder(
        future: getFormDetails(service_Id.toString()),
        builder: (context, AsyncSnapshot<FieldData> snapshot) {
          List<CategorySetting> catNew = [];
          if (snapshot.hasData) {
            if (catNew.length == 0)
              for (var i = 0; i < snapshot.data!.data2.categories.length; i++) {
                catNew.add(CategorySetting(
                    title: '${snapshot.data!.data2.categories[i].toString()}'));
              }
              serviceList=[];
              for(var i=0;i<snapshot.data!.data2.modeCommunication.length;i++)
                serviceList.add(snapshot.data!.data2.modeCommunication[i]);
            count=count+1;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Request Help",
                  style: TextStyle(fontFamily: "Candara"),
                ),
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
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Colors.teal[100],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            mentor,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Candara"),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "Would Like To Know",
                            style:
                                TextStyle(fontSize: 18, fontFamily: "Candara"),
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
                              child: Text(
                                "View Profile",
                                style: TextStyle(fontFamily: "Candara"),
                                textAlign: TextAlign.left,
                              )),
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
                                style: TextStyle(
                                    fontFamily: "Candara",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "*",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                              ),
                            ],
                          ),
                          DropdownButton<String>(
                            hint: Text(
                              "Select Mode",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "Candara"),
                            ),
                            value: curValue1,
                            items: serviceList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(fontFamily: "Candara"),
                                ),
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
                                style: TextStyle(
                                    fontFamily: "Candara",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "*",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                for(var j=0;j< snapshot.data!.data2.categories.length;j++ )
                                  Row(
                                  children: [
                                    new Checkbox(
                                        value : isSelected[j],
                                        activeColor: Colors.teal,
                                        onChanged:(bool? newValue){
                                          setState(() {
                                            isSelected[j]=newValue;
                                          });
                                          if(isSelected[j]!=false)
                                            selected.add(snapshot.data!.data2.categories[j].toString());
                                          else
                                            selected.remove(snapshot.data!.data2.categories[j].toString());

                                        },


                                        ),
                                    Text(snapshot.data!.data2.categories[j].toString(),style: TextStyle(fontSize: 16,fontFamily: "Candara",color: Colors.grey),)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //...catNew.map(buildSingleCheckbox).toList(),
                          Row(
                            children: [
                              Text("Comment",
                                  style: TextStyle(
                                    fontFamily: "Candara",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (input) {
                              if (input!.isEmpty) return 'Enter comment';
                            },
                            decoration: InputDecoration(
                              fillColor: Colors.white,

                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2.0),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.teal, width: 2.0),
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: 'Comment',
                              labelStyle: TextStyle(
                                  fontFamily: "Candara", color: Colors.grey),
                              //fillColor: Colors.grey,
                              focusColor: Colors.teal,
                            ),
                            controller: comment,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    Container(
                        padding: EdgeInsets.all(15),
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  'Request Help ',
                                  style: TextStyle(fontFamily: "Candara"),
                                ),
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
                              if (comment.text.isEmpty)
                                com = await createComm(
                                    educator_Id.toString(),
                                    service_Id.toString(),
                                    curValue1!,
                                    "No message",
                                    selected);
                              else
                                com = await createComm(
                                    educator_Id.toString(),
                                    service_Id.toString(),
                                    curValue1!,
                                    comment.text.toString(),
                                    selected);
                              setState(() {
                                _comm = com;
                              });
                              if (ComCode == 200) {
                                Navigator.pop(context);
                                final Future<ConfirmAction?> action =
                                    await _asyncConfirmDialog(
                                        context, userName, selected);
                                print("Confirm Action $action");
                              }
                              if (ComCode == 500) {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text("Cant send request"),
                                    content: Text("Unauthenticated"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK',
                                              style: TextStyle(
                                                  color: Colors.teal))),
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
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget buildSingleCheckbox(CategorySetting catValue) => buildCheckbox(
        categorySetting: catValue,
        onClicked: () {

            final newValue = !catValue.value;
            catValue.value = newValue;
            if (catValue.value != false) {
              selected.add(catValue.title.toString());
            } else {
              selected.remove(catValue.title.toString());
            }

        },
      );

  Widget buildCheckbox({
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
        content: Text('The request has been sent successfully to ${mentor}' +
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
