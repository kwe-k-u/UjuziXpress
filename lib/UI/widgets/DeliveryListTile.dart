import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:ujuzi_xpress/UI/screens/DeliveryReceiptWithMapPage.dart';
import 'package:ujuzi_xpress/UI/screens/RequestDeliveryPage.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DeliveryListTile extends StatelessWidget {
final DeliveryRequest deliveryRequest;
final UjuziUser user;

DeliveryListTile({@required this.deliveryRequest, this.user});



Widget displayStatus(BuildContext context){
  switch(deliveryRequest.status){
    case DeliveryStatus.complete:
      return Text(AppLocalizations.of(context).complete.toUpperCase(),style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),);
    case DeliveryStatus.ongoing:
      return Text(AppLocalizations.of(context).in_progress.toUpperCase(),style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),);
    case DeliveryStatus.pending:
      return Text(AppLocalizations.of(context).pending.toUpperCase(),style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),);
    case DeliveryStatus.cancelled:
      return Text(AppLocalizations.of(context).cancelled.toUpperCase(),style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),);
    default:
      return Text(AppLocalizations.of(context).error);
  }
}

String displayDate(){
  DateTime date = deliveryRequest.requestDate;

  return "${date.day}/${date.month}/${date.year}";
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        //only pending requests can be changed
        if (deliveryRequest.status == DeliveryStatus.pending){
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=> RequestDeliveryPage(request: deliveryRequest, requestingUser: user,))
          );
        } else {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  DeliveryReceiptWithMapPage(deliveryRequest: deliveryRequest))
          );

        }
      },

      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.black, )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text("${AppLocalizations.of(context).order_no}: ${deliveryRequest.deliveryID}"),
              subtitle: Padding(
                padding: const EdgeInsets.only(top:4.0),
                child: Text("${AppLocalizations.of(context).order_date}: ${displayDate()}"),
              ),
              trailing: Column(
                children: [
                  Text(AppLocalizations.of(context).status),
                  displayStatus(context),
                ],
              ),
            ),

            Divider(
              thickness: 2.0,
              indent: 12.0,
              endIndent: 12.0,
              color: Colors.black,
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Entypo.paper_plane,
                    size: 20,
                    color: Colors.deepPurple,
                  ),
                ),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(

                      children: [
                        TextSpan(
                            text: "${AppLocalizations.of(context).from}:\t",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                          ),
                        ),

                        TextSpan(

                          text: deliveryRequest.pickupLocation.locationName,

                          style: TextStyle(
                              fontWeight: FontWeight.bold,

                            color: Colors.black
                          ),
                        )
                      ]
                  ),
                ),
                // Text("From: Billy's house"),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.location_on, color: Colors.deepPurple,),
                  ),
                  RichText(
                    text: TextSpan(

                        children: [
                          TextSpan(
                            text: "${AppLocalizations.of(context).to}:\t",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),

                          TextSpan(

                            text: deliveryRequest.dropOffLocation.locationName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,

                                color: Colors.black
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
