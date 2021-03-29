import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/DeliveryReceiptWithMapPage.dart';
import 'package:ujuzi_xpress/UI/screens/RequestDeliveryPage.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';


class DeliveryListTile extends StatelessWidget {
final DeliveryRequest deliveryRequest;

DeliveryListTile({@required this.deliveryRequest});



Widget displayStatus(){
  switch(deliveryRequest.status){
    case DeliveryStatus.complete:
      return Text("COMPLETE",style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),);
    case DeliveryStatus.ongoing:
      return Text("IN PROGRESS",style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),);
    case DeliveryStatus.pending:
      return Text("PENDING",style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),);
    case DeliveryStatus.cancelled:
      return Text("CANCELLED",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),);
    default:
      return Text("Error");
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
              MaterialPageRoute(builder: (context)=> RequestDeliveryPage())
          );
        } else {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  DeliveryReceiptWithMapPage(deliveryRequest: deliveryRequest,))
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
              title: Text("Order No: ${deliveryRequest.deliveryID}"),
              subtitle: Padding(
                padding: const EdgeInsets.only(top:4.0),
                child: Text("order date: ${displayDate()}"),
              ),
              trailing: Column(
                children: [
                  Text("Status"),
                  displayStatus(),
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
                  child: Icon(Icons.send,color: Colors.deepPurple,), //todo rotate icon
                ),
                // RichText(
                //   text: TextSpan(
                //
                //       children: [
                //         TextSpan(
                //             text: "From: \t",
                //           style: TextStyle(
                //               fontWeight: FontWeight.normal,
                //               color: Colors.black,
                //           ),
                //         ),
                //
                //         TextSpan(
                //
                //           text: deliveryRequest.pickupLocation.locationName,
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //
                //             color: Colors.black
                //           ),
                //         )
                //       ]
                //   ),
                // ),
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
                            text: "To: \t",
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
