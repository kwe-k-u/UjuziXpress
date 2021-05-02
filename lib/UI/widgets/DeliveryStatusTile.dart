import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/widgets/custom_status_icon.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';


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



              CustomIcon(
                status: DeliveryStatus.pending,
                enabled: true,

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
                status: DeliveryStatus.ongoing,
                enabled: true,

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
                status: DeliveryStatus.complete,
                enabled: true,

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
                status: DeliveryStatus.pending,
                enabled: true,

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
                status: DeliveryStatus.ongoing,
                enabled: true,

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
                status: DeliveryStatus.complete
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
                enabled: true,
                status: DeliveryStatus.pending,

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
                status: DeliveryStatus.ongoing
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
                status: DeliveryStatus.complete
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
                enabled: true,
                status: DeliveryStatus.pending

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
                enabled: true,
                status: DeliveryStatus.ongoing

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
                enabled: true,
                status: DeliveryStatus.cancelled,

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
                status: DeliveryStatus.pending,
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
                status: DeliveryStatus.ongoing

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
                status: DeliveryStatus.complete,
              ),


            ],
          ),
        );
    }
  }
}






