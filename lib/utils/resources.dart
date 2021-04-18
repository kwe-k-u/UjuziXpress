import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///File containing the various nonwidget resources that will be used on
///multiple pages

class AppResources {


  final Color facebookBlue = const Color.fromRGBO(13, 81, 137, 1.0);

  final Color primaryColour = Colors.deepPurple;



  showAlertDialog(String content, BuildContext _context) {
    //TODO: better design
    showDialog(
        context: _context,
        builder: (context) {
          return AlertDialog(
            content: Text(content),
          );
        });
  }





  showSnackBar({String actionLabel,String content, BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(content),
          action: SnackBarAction(
            label: actionLabel,
            textColor: Colors.black,
            onPressed: (){},
          ),
    ));
  }



}
