import 'package:flutter/material.dart';


class CustomIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color color;

  CustomIconButton({
    this.onPressed,
    this.icon = Icons.arrow_forward_outlined,
    this.color
});



  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(8.0),
      color: color,
        onPressed: onPressed,
      child: Icon(icon, size: 32.0,),
      shape: CircleBorder(),
    );
  }
}
