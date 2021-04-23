import 'package:flutter/cupertino.dart';
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
        ConstrainedBox(
          child: Image.network(
            widget.url,
            errorBuilder: (context,snapshot, stacktrace){
              return CircleAvatar(
                minRadius: 20,
                maxRadius: 40,
                child: Icon(Icons.error, size: 40.0,),
              );
            },
          ),
          constraints: BoxConstraints(minHeight:100, maxHeight: 150, minWidth: 60, maxWidth: 90),
        ) : CircleAvatar(
          minRadius: 20,
          maxRadius: 40,
          child: Icon(Icons.person, size: 40.0,),),
      ),


      onTap: widget.onPressed,
    );
  }
}