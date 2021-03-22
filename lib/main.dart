import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/Splash.dart';
import 'package:ujuzi_xpress/UI/widgets/MapBox.dart';
import 'package:ujuzi_xpress/UI/widgets/MapUi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ujuzi Express',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashPage(),
    );
  }
}

