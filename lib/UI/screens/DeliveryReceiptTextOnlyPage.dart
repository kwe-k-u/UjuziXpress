import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';


class DeliveryReceiptWithTextOnlyPage extends StatelessWidget {
  @required final DeliveryRequest deliveryRequest;


  DeliveryReceiptWithTextOnlyPage({this.deliveryRequest});




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

  String displayDate(DateTime date){
    // DateTime date = deliveryRequest.requestDate;
    if (date == null)
      return "";

    return "${date.day}/${date.month}/${date.year}";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Order".toUpperCase(),
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.deepPurple,
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),


      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height ,
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
                  child: Text("order date: ${displayDate(deliveryRequest.requestDate)}"),
                ),
                trailing: Column(
                  children: [
                    Text("Status"),
                    displayStatus(),
                  ],
                ),
              ),

              RichText(
                text: TextSpan(

                    children: [
                      TextSpan(
                        text: "Date completed: \t",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),

                      TextSpan(

                        text: displayDate(deliveryRequest.completionDate),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,

                            color: Colors.black
                        ),
                      )
                    ]
                ),
              ),
              RichText(
                text: TextSpan(

                    children: [
                      TextSpan(
                        text: "Package Type: \t",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),

                      TextSpan(

                        text: deliveryRequest.status.toString().split(".")[1], //todo remove datetime.now
                        style: TextStyle(
                            fontWeight: FontWeight.bold,

                            color: Colors.black
                        ),
                      )
                    ]
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
                  RichText(
                    text: TextSpan(

                        children: [
                          TextSpan(
                            text: "From: \t",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),

                          TextSpan(

                            text: "Pickup Person Details",
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

              RichText(
                text: TextSpan(

                    children: [
                      TextSpan(
                        text: "Pickup Person Name: \t",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),

                      // TextSpan(
                      //
                      //   text: deliveryRequest.pickupPerson.name,
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold,
                      //
                      //       color: Colors.black
                      //   ),
                      // )
                    ]
                ),
              ),

              // RichText(
              //   text: TextSpan(
              //
              //       children: [
              //         TextSpan(
              //           text: "Number: \t",
              //           style: TextStyle(
              //             fontWeight: FontWeight.normal,
              //             color: Colors.black,
              //           ),
              //         ),
              //
              //         TextSpan(
              //
              //           text: deliveryRequest.pickupPerson.mobileNumber,
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //
              //               color: Colors.black
              //           ),
              //         )
              //       ]
              //   ),
              // ),

              // RichText(
              //   text: TextSpan(
              //
              //       children: [
              //         TextSpan(
              //           text: "Location: \t",
              //           style: TextStyle(
              //             fontWeight: FontWeight.normal,
              //             color: Colors.black,
              //           ),
              //         ),
              //
              //         TextSpan(
              //
              //           text: deliveryRequest.pickupPerson.location.locationName,
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //
              //               color: Colors.black
              //           ),
              //         )
              //       ]
              //   ),
              // ),


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

                              text: "Drop off Person Details",
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


              RichText(
                text: TextSpan(

                    children: [
                      TextSpan(
                        text: "Pickup Person Name: \t",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),

                      TextSpan(

                        text: deliveryRequest.dropOffPersonName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,

                            color: Colors.black
                        ),
                      )
                    ]
                ),
              ),

              RichText(
                text: TextSpan(

                    children: [
                      TextSpan(
                        text: "Number: \t",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),

                      TextSpan(

                        text: deliveryRequest.dropOffPersonNumber,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,

                            color: Colors.black
                        ),
                      )
                    ]
                ),
              ),

              RichText(
                text: TextSpan(

                    children: [
                      TextSpan(
                        text: "Location: \t",
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
      ),
    );
  }
}
