import 'package:flutter/material.dart';
import 'package:flutter_application_2/screen/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Fluttrt Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:Homescreen()
    );
  }
}
