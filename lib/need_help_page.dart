import 'package:flutter/material.dart';
import 'package:learning_duniya/CategorySetting.dart';
import 'package:learning_duniya/mentor.dart';

late List<String> moc;

class need_help_page extends StatefulWidget {
  need_help_page(List<String> serviceList);

  @override
  _needHelpPageState createState() => _needHelpPageState(serviceList);
}

class _needHelpPageState extends State<need_help_page> {
  _needHelpPageState(List<String> serviceList);
  var selected = [''];
  String? curValue1, curValue2;

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
                    'userName',
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
                  Row(
                    children: [
                      Text(
                        "Mode Of Communication ",
                        style: TextStyle(
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
                      style: TextStyle(fontSize: 12),
                    ),
                    value: curValue1,
                    items: serviceList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => this.curValue1 = value),
                  ),
                  Row(
                    children: [
                      Text(
                        "Category Of Required Help ",
                        style: TextStyle(
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
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      Icon(Icons.arrow_drop_down,
                          color: Colors.black, size: 30),
                    ],
                  ),
                  TextField(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('Request Help '),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      final Future<ConfirmAction?> action =
                      await _asyncConfirmDialog(
                          context, 'userName', selected);
                      print("Confirm Action $action");
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
          selected.add(catValue.title);
        } else {
          selected.remove(catValue.title);
        }
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