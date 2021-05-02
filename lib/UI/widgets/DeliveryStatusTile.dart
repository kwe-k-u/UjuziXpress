import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DeliveryStatusTile extends StatelessWidget {
  final DeliveryStatus status;

  DeliveryStatusTile({this.status});



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    switch(status){
      case DeliveryStatus.complete:

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [


              /**todo
               * get icon for pending, ongoing, complete, cancelled
               */
              CustomIcon(
                  icon: Icons.timer,
                  text: AppLocalizations.of(context).pending,
                color: Colors.black,

              ),


              Expanded(
                  child: Container(
                    width: size.width * 0.3,
                    child: Divider(
                      color: Colors.black,
                      height: 30,
                      thickness: 2.0,
                    ),
                  )
              ),



              CustomIcon(
                icon: FlutterIcons.shipping_fast_faw5s,
                text: AppLocalizations.of(context).in_transit,
                color: Colors.black,

              ),

              Expanded(
                  child: Container(
                    width: size.width * 0.3,
                    child: Divider(
                      height: 30,
                      thickness: 2.0,
                      color: Colors.black,
                    ),
                  )
              ),



              CustomIcon(
                  icon: Icons.check_circle_outline,
                  text: AppLocalizations.of(context).complete,
                color: Colors.black,

              ),


            ],
          ),
        );

      case DeliveryStatus.ongoing:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [

              CustomIcon(
                icon: Icons.timer,
                text: AppLocalizations.of(context).pending,
                color: Colors.black,

              ),


              Expanded(
                  child: Container(
                    width: size.width * 0.3,
                    child: Divider(
                      color: Colors.black,
                      height: 30,
                      thickness: 2.0,
                    ),
                  )
              ),



              CustomIcon(
                icon: FlutterIcons.shipping_fast_faw5s,
                text: AppLocalizations.of(context).in_transit,
                color: Colors.black,

              ),

              Expanded(
                  child: Container(
                    width: size.width * 0.3,
                    child: Divider(
                      height: 30,
                    ),
                  )
              ),



              CustomIcon(
                icon: Icons.check_circle_outline,
                text: AppLocalizations.of(context).complete,

              ),


            ],
          ),
        );

      case DeliveryStatus.pending:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [

              CustomIcon(
                icon: Icons.timer,
                text: AppLocalizations.of(context).pending,
                color: Colors.black,

              ),


              Expanded(
                  child: Container(
                    width: size.width * 0.3,
                    child: Divider(
                      height: 30,
                    ),
                  )
              ),



              CustomIcon(
                icon: FlutterIcons.shipping_fast_faw5s,
                text: AppLocalizations.of(context).in_transit,

              ),

              Expanded(
                  child: Container(
                    width: size.width * 0.3,
                    child: Divider(
                      height: 30,
                    ),
                  )
              ),



              CustomIcon(
                icon: Icons.check_circle_outline,
                text: AppLocalizations.of(context).complete,

              ),


            ],
          ),
        );

      case DeliveryStatus.cancelled:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [

              CustomIcon(
                icon: Icons.timer,
                text: AppLocalizations.of(context).pending,
                color: Colors.black,

              ),


              Expanded(
                  child: Container(
                    width: size.width * 0.3,
                    child: Divider(
                      color: Colors.black,
                      height: 30,
                      thickness: 2.0,
                    ),
                  )
              ),



              CustomIcon(
                icon: FlutterIcons.shipping_fast_faw5s,
                text: AppLocalizations.of(context).in_transit,
                color: Colors.black,

              ),

              Expanded(
                  child: Container(
                    width: size.width * 0.3,
                    child: Divider(
                      height: 30,
                      thickness: 2.0,
                      color: Colors.black,
                    ),
                  )
              ),



              CustomIcon(
                icon: FlutterIcons.circle_slash_oct,
                text: AppLocalizations.of(context).cancelled,
                color: Colors.red,

              ),


            ],
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [


              CustomIcon(
                  icon: Icons.timer,
                  text: AppLocalizations.of(context).pending

              ),


              Expanded(
                  child: Container(
                    width: size.width * 0.3,
                    child: Divider(
                      height: 30,
                    ),
                  )
              ),



              CustomIcon(
                  icon: FlutterIcons.shipping_fast_faw5s,
                  text: AppLocalizations.of(context).in_transit

              ),

              Expanded(
                  child: Container(
                    width: size.width * 0.3,
                    child: Divider(
                      height: 30,
                    ),
                  )
              ),



              CustomIcon(
                  icon: Icons.check_circle_outline,
                  text: AppLocalizations.of(context).complete

              ),


            ],
          ),
        );
    }
  }
}



class CustomIcon extends StatelessWidget {
  @required final IconData icon;
  @required final bool enabled;
  @required final String text;
  final Color color;

  CustomIcon({
    this.icon,
    this.enabled,
    this.text,
    this.color = Colors.grey
});

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Icon(icon, color: color,),
          Text(text, style: TextStyle(color: color),)
        ],
      );
  }
}



