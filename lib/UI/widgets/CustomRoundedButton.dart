import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color buttonColor;
  final double widthFactor;
  final Color textColor;
  final double elevation;

  CustomRoundedButton({
    this.text,
    this.onPressed,
    this.buttonColor = Colors.deepPurple,
    this.widthFactor = 0.15,
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
            EdgeInsets.symmetric(vertical: 12.0, horizontal: width)
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
