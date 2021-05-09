import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }



  showSnackBar({String actionLabel = "",String content = "", BuildContext context}) {
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


  Future<File> pickImage() async{

    final picker = ImagePicker();

      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        return File(pickedFile.path);
        }
      return null;

  }

}
