import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  CustomRoundedButton({
   this.text,
   this.onPressed
});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.all(12.0)
        ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(30.0),
              )
          )
      ),
        onPressed: onPressed,
            child: Text(text),
        );
  }
}
