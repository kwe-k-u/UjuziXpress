import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/LoginPage.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
        },
        child: Center(
          child: FlutterLogo(
            size: 94.0,
          ),
        ),
      ),
    );
  }
}
