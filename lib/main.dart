import 'package:flutter/material.dart';

import './widgets/manage_front_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
      theme: ThemeData(
        primaryColor: Colors.pink,
        accentColor: Colors.deepPurple,
        backgroundColor: Colors.amber,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          textTheme: ButtonTextTheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          buttonColor: Colors.pink,
        ),
      ),
      home: ManageFrontPage(),
    );
  }
}
