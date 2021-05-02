import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


// ignore: must_be_immutable
class CustomIcon extends StatelessWidget {
  IconData _icon;
  final DeliveryStatus status;
  String text;
  final bool enabled;
  Color color = Colors.grey;

  CustomIcon({
    @required this.status,
    this.enabled = false
  });

  @override
  Widget build(BuildContext context) {
    _display(context);

    return
      Column(
        children: [
          Icon(_icon, color: color,),
          Text(text, style: TextStyle(color: color),)
        ],
      );
  }



  void _display(context){
    if (enabled)
      this.color = Colors.black;


    switch (this.status){
      case DeliveryStatus.pending:
        this._icon = Icons.timer;
        this.text = AppLocalizations.of(context).pending;
        break;


      case DeliveryStatus.ongoing:
        this._icon = FlutterIcons.shipping_fast_faw5s;
        this.text = AppLocalizations.of(context).in_transit;
        break;


      case DeliveryStatus.complete:
        this._icon = Icons.check_circle_outline;
        this.text = AppLocalizations.of(context).complete;
        break;

        //Cancelled and others
      default:
        this._icon = FlutterIcons.circle_slash_oct;
        this.color = Colors.red;
        this.text = AppLocalizations.of(context).canceled;
    }

  }

}