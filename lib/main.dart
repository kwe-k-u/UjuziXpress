import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/Splash.dart';
import 'package:ujuzi_xpress/utils/resources.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppResources resources = AppResources();
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Ujuzi Express',
      theme: ThemeData(
        primarySwatch: resources.primaryColour as MaterialColor?,
      ),
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
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

          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}

