import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color buttonColor;
  final double widthFactor;

  CustomRoundedButton({
    this.text,
    this.onPressed,
    this.buttonColor = Colors.deepPurple,
    this.widthFactor = 0.15,
});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * widthFactor;

    return ElevatedButton(
      style: ButtonStyle(
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
            child: Text(text),
        );
  }
}
