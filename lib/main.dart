import 'package:flutter/material.dart';
import 'package:playing_cards/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.blueAccent,
        primaryColor: Colors.blueGrey
      ),
      home: MainScreen(),
    );
  }
}