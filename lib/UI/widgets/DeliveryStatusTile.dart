import 'package:flutter/material.dart';
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


              /**todo
               * get icon for pending, ongoing, complete, cancelled
               */
              CustomIcon(
                  icon: Icons.my_location,
                  text: "Pending",
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
                icon: Icons.my_location,
                text: "In transit",
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
                  icon: Icons.my_location,
                  text: "Completed",
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
                icon: Icons.my_location,
                text: "Pending",
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
                icon: Icons.my_location,
                text: "In transit",
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
                icon: Icons.my_location,
                text: "Completed",

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
                icon: Icons.my_location,
                text: "Pending",
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
                icon: Icons.my_location,
                text: "In transit",

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
                icon: Icons.my_location,
                text: "Completed",

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
                icon: Icons.my_location,
                text: "Pending",
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
                icon: Icons.my_location,
                text: "In transit",
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
                icon: Icons.my_location,
                text: "Cancelled",
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
                  icon: Icons.my_location,
                  text: "Pending"

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
                  icon: Icons.my_location,
                  text: "Pending"

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
                  icon: Icons.my_location,
                  text: "Pending"

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



