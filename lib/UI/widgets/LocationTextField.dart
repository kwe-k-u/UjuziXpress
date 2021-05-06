import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomLoadingIndicator.dart';
import 'package:ujuzi_xpress/utils/resources.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart' as arg;


class LocationTextField extends StatefulWidget {

  @required final String label;
  final TextEditingController controller;
  final bool obscureText;
  final Color color;
  final Color labelColor;
  final Color selectedColor;
  final double widthFactor;
  final String value;
  final Function(String) validator;
  final Function(String value) onChanged;
  final Function onIconTap;

  LocationTextField({
    this.label,
    this.value,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.color = Colors.white,
    this.selectedColor = Colors.pink,
    this.labelColor = Colors.white,
    this.widthFactor =0.7,
    this.onChanged,
    @required this.onIconTap,


  });



  @override
  _LocationTextFieldState createState() => _LocationTextFieldState();
}

class _LocationTextFieldState extends State<LocationTextField> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Theme(
      data: new ThemeData(
          primaryColor: widget.selectedColor
      ),
      child:  Container(
        padding: EdgeInsets.only(left: 8.0),
        width: size.width * widget.widthFactor,
        child: Row(
          children: [
            Flexible(
              flex: 8,
              child: TextFormField(
                validator: widget.validator,
                obscureText: widget.obscureText,
                controller: widget.controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(

                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: widget.color)
                    ),
                    labelText: widget.label ,
                    labelStyle: TextStyle(color: widget.labelColor),
                ),
              ),
            ),
            Flexible(child: arg.ArgonButton(
              height: MediaQuery.of(context).size.width * 0.05,
              roundLoadingShape: true,
              width: MediaQuery.of(context).size.width * 0.05,
              borderRadius: 5.0,
              color: Colors.transparent,
              elevation: 0,
              child: Icon(Icons.my_location),

              onTap: (startLoading, stopLoading, btnState) {
                startLoading();

                widget.onIconTap();

                stopLoading();
              },
              loader: Container(
                padding: EdgeInsets.all(10),
                child:  CustomLoadingIndicator(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
