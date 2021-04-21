import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  @required final String url;
  final bool enabled;
  final Function onPressed;


  ProfileImage({Key key, this.url, this.enabled = false, this.onPressed}) : super(key: key);


  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return
    GestureDetector(
      child: ClipOval(
        child: widget.url != null ?
        Image.network(
          widget.url,
        ) : CircleAvatar(),
      ),


      onTap: widget.onPressed,
    );
  }
}