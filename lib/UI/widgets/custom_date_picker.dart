import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDatePicker extends StatefulWidget {
  DateTime date;
  Function (DateTime) onChanged;

  CustomDatePicker({
    Key? key,
    required this.date,
    required this.onChanged
  })
      : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  
  
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(left: 8.0),
      width: size.width * 0.7,
      child: DateTimeFormField(
        initialValue: widget.date,
        decoration:  InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.5)
          ),

          alignLabelWithHint: true,
        ),
        mode: DateTimeFieldPickerMode.date,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onDateSelected: (DateTime value) {
          widget.onChanged(value);
        },
      ),
    );

    
  }
}







