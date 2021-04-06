import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'UI/screens/Splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Ujuzi Express',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context,future){
          if (future.connectionState == ConnectionState.done && !future.hasError) {

            return SplashPage();
          }

          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}

