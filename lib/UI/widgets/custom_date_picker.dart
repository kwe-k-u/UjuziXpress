import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDatePicker extends StatefulWidget {
  @required final DateTime date;
  
  CustomDatePicker({Key key, this.date}) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  
  
  
  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;


    final List<dynamic> months = [
      AppLocalizations.of(context).jan,
      AppLocalizations.of(context).feb,
      AppLocalizations.of(context).mar,
      AppLocalizations.of(context).apr,
      AppLocalizations.of(context).may,
      AppLocalizations.of(context).jun,
      AppLocalizations.of(context).jul,
      AppLocalizations.of(context).aug,
      AppLocalizations.of(context).sept,
      AppLocalizations.of(context).oct,
      AppLocalizations.of(context).nov,
      AppLocalizations.of(context).dec
    ];
    
    
    
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2.40, color: Colors.black),
              color: Colors.grey.withOpacity(0.14),
            borderRadius: BorderRadius.circular(20.0)
          ),
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(AppLocalizations.of(context).day),
              ),
              Text(widget.date.day.toString(), style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.subtitle1.fontSize
              ),),
            ],
          ),
          width: size.width * 0.2,
        ),


        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2.40, color: Colors.black),
              color: Colors.grey.withOpacity(0.14),
            borderRadius: BorderRadius.circular(20.0)
          ),
          padding: EdgeInsets.all( 8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(AppLocalizations.of(context).month),
              ),
              Text(months.elementAt(widget.date.month-1), style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.subtitle1.fontSize
              ),),
            ],
          ),
          width: size.width * 0.3,
        ),


        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 2.40, color: Colors.black),
              color: Colors.grey.withOpacity(0.14),
            borderRadius: BorderRadius.circular(20.0)
          ),
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(AppLocalizations.of(context).year),
              ),
              Text(widget.date.year.toString(), style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.subtitle1.fontSize
              ),),
            ],
          ),
          width: size.width * 0.2,
        ),
      ],
    );
  }
}