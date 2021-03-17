import 'package:flutter/material.dart';


class CustomTextButton extends StatelessWidget {
  final String foreText;
  @required final  String actionText;
  @required final onPressed;

  CustomTextButton({
   this.foreText,
   this.onPressed,
   this.actionText
});



  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text(actionText),
        onPressed: onPressed,
      );
  }
}
