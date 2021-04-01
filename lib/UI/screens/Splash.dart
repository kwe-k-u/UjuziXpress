import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/LoginPage.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {


    Timer(Duration(milliseconds: 500), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
    }
    );


    return Scaffold(
      body: Center(
        child: Image.asset("assets/ujuzi_logo.jpg"),
      ),
    );
  }
}
