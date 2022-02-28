import 'package:flutter/material.dart';
import 'need_help_page.dart';

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Initial Screen'),
          centerTitle: true,
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Click Me'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return need_help_page(
                      name: 'Profile Name',
                      items1: ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                      items2: [
                        'Item 1',
                        'Item 2',
                        'Item 3',
                      ],
                      category: ['Cat 1', 'Cat 2', 'Cat 3'],
                    );
                  },
                ),
              );
            },
          ),
        ));
  }
}
