import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/utils/resources.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'UI/screens/Splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AppResources resources = AppResources();
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Ujuzi Express',
      theme: ThemeData(
        primarySwatch: resources.primaryColour,
      ),
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
      locale: Locale('en',''),
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('fr', '')
      ],
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

