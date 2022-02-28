// ignore_for_file: prefer_const_constructors, must_be_immutable, camel_case_types, prefer_const_literals_to_create_immutables, unnecessary_this, non_constant_identifier_names, use_key_in_widget_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learning_duniya/CategorySetting.dart';

class need_help_page extends StatefulWidget {
  String name;
  List items1, items2, category;

  need_help_page(
      {Key? key,
      required this.name,
      required this.items1,
      required this.items2,
      required this.category})
      : super(key: key);

  @override
  _needHelpPageState createState() =>
      _needHelpPageState(name, items1, items2, category);
}

class _needHelpPageState extends State<need_help_page> {
  String name;
  List items1, items2, category;
  var itm1 = ['Cat 1', 'Cat 2', 'Cat 3', 'Cat 4', 'Cat 5'];
  var itm2 = ['Opt 1', 'Opt 2', 'Opt 3', 'Opt 4', 'Opt 5'];
  var cat = ['Cat 1', 'Cat 2', 'Cat 3'];

  String userName = "User Name";
  var selected = [''];

  final catNew = [
    CategorySetting(title: 'Cat 1'),
    CategorySetting(title: 'Cat 2'),
    CategorySetting(title: 'Cat 3'),
  ];

  String? curValue1, curValue2;

  _needHelpPageState(this.name, this.items1, this.items2, this.category);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Help"),
        centerTitle: true,
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
                borderRadius: BorderRadius.circular(5.0),
                color: Color.fromARGB(255, 196, 214, 252),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "Would Like To Know",
                    style: TextStyle(fontSize: 18),
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
                      child: Text("View Profile")),
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
                  Text(
                    "Mode Of Communication *",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  DropdownButton<String>(
                    hint: Text(
                      "Select Mode",
                      style: TextStyle(fontSize: 12),
                    ),
                    value: curValue1,
                    items: itm1.map(buildMenuItem1).toList(),
                    onChanged: (value) =>
                        setState(() => this.curValue1 = value),
                  ),
                  Text(
                    "Category Of Required Help *",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  ...catNew.map(buildSingleCheckbox).toList(),
                  DropdownButton<String>(
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
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Request Help '),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  final Future<ConfirmAction?> action =
                      await _asyncConfirmDialog(context, userName, selected);
                  print("Confirm Action $action");
                },
              ),
            ),
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
          });
        },
      );

  Widget buildCheckbox({
    required CategorySetting categorySetting,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        onTap: onClicked,
        leading: Checkbox(
          value: categorySetting.value,
          onChanged: (value) => onClicked(),
        ),
        title: Text(categorySetting.title,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            )),
      );

  DropdownMenuItem<String> buildMenuItem1(String item) => DropdownMenuItem(
        value: item.toString(),
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      );

  DropdownMenuItem<String> buildMenuItem2(String item) => DropdownMenuItem(
        value: item.toString(),
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
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
          'assets/images/tick.png',
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
