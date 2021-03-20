import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';
import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/Person.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';


class RequestDeliveryPage extends StatefulWidget {
  @override
  _RequestDeliveryPageState createState() => _RequestDeliveryPageState();
}

class _RequestDeliveryPageState extends State<RequestDeliveryPage> {
  //todo make it possible to receive deliveryRequest and edit its contents
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


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
          width: size.width,
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Card(
                margin: EdgeInsets.all(12.0),
                color: Colors.white60,
                child: ExpandablePanel(

                  header: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Pickup Person details"),
                  ), //todo prefill with the ujuzi user's details
                  collapsed: Container(
                    padding: EdgeInsets.all(8),
                    width: size.width,
                      child: Text("Billy's house, 0559581254, Martins Gardens"),
                    color: Colors.white54,
                  ),
                  expanded: Container(
                    width: size.width,
                    margin: EdgeInsets.all(4.0),
                    padding: EdgeInsets.all(8.0),
                    color: Colors.white60,
                    child: Column(
                      children: [


                        CustomTextField(
                          label: "Pickup person name",
                          color: Colors.black,

                          widthFactor: 0.85,
                          labelColor: Colors.grey,
                        ),


                        CustomTextField(
                          label: "Pickup person Number",
                          color: Colors.black,
                          labelColor: Colors.grey,
                          widthFactor: 0.85,
                        ),



                        CustomTextField(
                          label: "Pickup person location",
                          color: Colors.black,
                          labelColor: Colors.grey,
                          widthFactor: 0.85,
                          icon: IconButton(
                              icon:Icon(Icons.my_location),
                            onPressed: (){
                                //todo location picker
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),



              CustomTextField(
                label: "Where to?",
                color: Colors.black,
                labelColor: Colors.grey,
                widthFactor: 0.85,
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 32.0),
                  child: Text(
                    "Package Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                    ),
                  ),
                ),
              ),

              CustomTextField(
                label: "DropOff person name",
                color: Colors.black,

                widthFactor: 0.85,
                labelColor: Colors.grey,
              ),


              CustomTextField(
                label: "DropOff person Number",
                color: Colors.black,
                labelColor: Colors.grey,
                widthFactor: 0.85,
              ),



              CustomTextField(
                label: "DropOff person location",
                color: Colors.black,
                labelColor: Colors.grey,
                widthFactor: 0.85,
                icon: IconButton(
                  icon:Icon(Icons.my_location),
                  onPressed: (){
                    //todo location picker
                  },
                ),
              ),



              CustomTextField(
                label: "Notes",
                color: Colors.black,
                labelColor: Colors.grey,
                widthFactor: 0.85,
                expanded: true,
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 36.0),
                    child: Text("Package Type: "),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: DropdownButton(
                      onChanged: (value){

                      },
                      hint: Text("Payment method"),
                      value: "parcel",
                      items: [
                        DropdownMenuItem(value: "letter", child: Text("Letter")),
                        DropdownMenuItem(value: "parcel", child: Text("Parcel")),
                        DropdownMenuItem(value: "large", child: Text("Large")),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(left: 36.0, bottom: 8.0, top: 8.0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Payment Method: "),

                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: DropdownButton(
                        onChanged: (value){

                        },
                        hint: Text("Payment method"),
                        value: "now",
                        items: [
                          DropdownMenuItem(value: "delivery", child: Text("Payment on delivery")),
                          DropdownMenuItem(value: "pickup", child: Text("Payment on pickup")),
                          DropdownMenuItem(value: "now", child: Text("Payment now")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //todo add date picker


              CustomRoundedButton(
                text: "request delivery".toUpperCase(),
                onPressed: (){
                  //todo schedule delivery

                  DeliveryRequest(
                    requestingUser: new UjuziUser(),
                    dropOffLocation: new DeliveryLocation(),
                    pickupLocation: new DeliveryLocation(),
                    pickupPerson: new Person(),
                    dropOffPerson: new Person(),
                    requestDate: new DateTime.now(),
                    status: DeliveryStatus.pending,
                    packageType: PackageType.parcel
                  );
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
