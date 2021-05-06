import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:ujuzi_xpress/utils/resources.dart';


class CustomTextField extends StatefulWidget {

  @required final String label;
  final TextEditingController controller;
  final bool obscureText;
  final Color color;
  final Color labelColor;
  final Color selectedColor;
  final TextInputType inputType;
  final double widthFactor;
  final bool expanded;
  final String value;
  final Function(String) validator;
  final Function(String value) onChanged;

  CustomTextField({
    this.label,
    this.value,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.color = Colors.white,
    this.selectedColor = Colors.pink,
    this.labelColor = Colors.white,
    this.inputType,
    this.widthFactor =0.7,
    this.expanded = false,
    this.onChanged,


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
      child: widget.expanded ?
          //Expanded textField
      Container(
        padding: EdgeInsets.only(left: 8.0),
        width: size.width * widget.widthFactor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 20),
              child: Text(
                  widget.label,
                  style: TextStyle(color: widget.labelColor)
              ),
            ),
            TextFormField(
              onChanged: widget.onChanged,
              obscureText: widget.obscureText,
              controller: widget.controller,
              minLines: 4,
              maxLines: 9,
              initialValue: widget.value,
              keyboardType: widget.inputType,

              decoration: InputDecoration(

                focusedBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: widget.selectedColor, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: widget.color, width: 1.5)
                ),

                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      )
      :
          //regular textField
      Container(
        padding: EdgeInsets.only(left: 8.0),
        width: size.width * widget.widthFactor,
        child: TextFormField(
          validator: widget.validator,
          obscureText: widget.obscureText,
          controller: widget.controller,
          keyboardType: widget.inputType,
          decoration: InputDecoration(

            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.color)
            ),
            labelText: widget.label ,
            labelStyle: TextStyle(color: widget.labelColor),
          ),
        ),
      ),
    );
  }
}
