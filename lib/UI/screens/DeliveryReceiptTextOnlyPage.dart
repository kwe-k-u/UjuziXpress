import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DeliveryReceiptWithTextOnlyPage extends StatelessWidget {
  @required final DeliveryRequest deliveryRequest;


  DeliveryReceiptWithTextOnlyPage({this.deliveryRequest});




  Widget displayStatus(BuildContext context){
    switch(deliveryRequest.status){
      case DeliveryStatus.complete:
        return Text(AppLocalizations.of(context).complete,style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),);
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
        title: Text(AppLocalizations.of(context).order.toUpperCase(),
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
                title: Text("${AppLocalizations.of(context).order_no} ${deliveryRequest.deliveryID}"),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top:4.0),
                  child: Text("${AppLocalizations.of(context).order_date} ${displayDate(deliveryRequest.requestDate)}"),
                ),
                trailing: Column(
                  children: [
                    Text(AppLocalizations.of(context).status),
                    displayStatus(context),
                  ],
                ),
              ),

              RichText(
                text: TextSpan(

                    children: [
                      TextSpan(
                        text: "${AppLocalizations.of(context).date_completed} \t",
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
                        text: "${AppLocalizations.of(context).package_type}:\t",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),

                      TextSpan(

                        //todo language translation?
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
                            text: "${AppLocalizations.of(context).from}\t",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),

                          TextSpan(

                            text: AppLocalizations.of(context).pickup_person_details,
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

              RichText(
                text: TextSpan(

                    children: [
                      TextSpan(
                        text: "${AppLocalizations.of(context).pickup_person_name}\t",
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
                              text: "${AppLocalizations.of(context).to}\t",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),

                            TextSpan(

                              text: AppLocalizations.of(context).dropoff_person_details,
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
                        text: "${AppLocalizations.of(context).pickup_person_name}:\t",
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
                        text: "${AppLocalizations.of(context).number}:\t",
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
                        text: "${AppLocalizations.of(context).location}:\t",
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
