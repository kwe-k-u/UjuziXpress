import 'package:flutter/material.dart';


class BackgroundWidget extends StatelessWidget {
  final Widget child;

  BackgroundWidget({this.child});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset("assets/background_image.png",
          scale: 0.001,
          fit: BoxFit.fill,
          width: size.width,
          height: size.height,),

        child
      ]
    );
  }
}

