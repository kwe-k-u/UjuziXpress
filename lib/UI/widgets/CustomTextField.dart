import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget {
  @required final String label;
  final TextEditingController controller;
  final bool obscureText;
  final Color color;
  final Color labelColor;
  final Color selectedColor;
  final Widget icon;

  CustomTextField({
    this.label,
    this.icon,
    this.controller,
    this.obscureText = false,
    this.color = Colors.white,
    this.selectedColor = Colors.pink,
    this.labelColor = Colors.white,

});



  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Theme(
      data: new ThemeData(
        primaryColor: widget.selectedColor
      ),
      child: Container(
        padding: EdgeInsets.only(left: 8.0),
        width: size.width * 0.7,
        child: TextField(
          obscureText: widget.obscureText,
          controller: widget.controller,
          decoration: InputDecoration(

            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget.color)
            ),
            suffixIcon: widget.icon,
            labelText: widget.label ,
            labelStyle: TextStyle(color: widget.labelColor),
          ),
        ),
      ),
    );
  }
}
