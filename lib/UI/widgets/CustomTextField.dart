import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;

  CustomTextField({
   this.label,
   this.controller,
    this.obscureText = false
});



  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(left: 8.0),
      width: size.width * 0.7,
      child: TextField(
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label ,
        ),
      ),
    );
  }
}
