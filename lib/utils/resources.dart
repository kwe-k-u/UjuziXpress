import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

///File containing the various nonwidget resources that will be used on
///multiple pages

class AppResources {


  final Color facebookBlue = const Color.fromRGBO(13, 81, 137, 1.0);

  final Color primaryColour = Colors.deepPurple;



  showAlertDialog(String content, BuildContext _context) {
    showDialog(
        context: _context,
        builder: (context) {

          return AlertDialog(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
            title: Row (
              children: [
                Container(
                  child: Icon(MaterialCommunityIcons.alert_circle,
                      size: 40,
                    color: Colors.red,
                  ),
                  margin: EdgeInsets.only(right:12.0),
                ),
                Text("WARNING")
              ],
            ),
            content: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(child: Text(content)
                )
            ),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    },
                  child: Text("Okay")
              )
            ],
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
