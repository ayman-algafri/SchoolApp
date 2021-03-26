import 'package:flutter/material.dart';
import 'package:j/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Cairo",
      ),
      home: LoginScreen(),
    );
  }
}