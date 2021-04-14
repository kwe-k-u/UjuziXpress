import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color buttonColor;
  final double widthFactor;
  final double heightPadding;
  final Color textColor;
  final double elevation;

  CustomRoundedButton({
    this.text,
    this.onPressed,
    this.buttonColor = Colors.deepPurple,
    this.widthFactor = 0.15,
    this.heightPadding = 12.0,
    this.textColor,
    this.elevation
});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * widthFactor;

    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(elevation),
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(vertical: heightPadding, horizontal: width)
        ),
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
              ),
          )
      ),
        onPressed: onPressed,
            child: Text(text,
              style: TextStyle(color: textColor,),
            )
        );
  }
}






enum ButtonState { loading, normal }