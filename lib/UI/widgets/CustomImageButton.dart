import 'package:flutter/material.dart';


class CustomImageButton extends StatelessWidget {
  final Function onPressed;
  final String path;
  final double widthFactor;

  CustomImageButton({
    this.onPressed,
    this.path,
    this.widthFactor = 0.08
});




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return GestureDetector(
        onTap: onPressed,
        child: Image.asset(path,
          width: size.width * widthFactor,),
    );
  }
}
