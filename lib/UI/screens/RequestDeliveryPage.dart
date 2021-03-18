import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextButton.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Order",
          style: TextStyle(
          color: Colors.black
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),


      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            CustomTextField(
              label: "Where to?",
            ),

            Text("Package Details"),


            CustomTextField(
              label: "Pickup person name",
            ),


            CustomTextField(
              label: "Pickup person Number",
            ),


            DropdownButton(
              hint: Text("Payment method"),
              value: "now",
              items: [
                DropdownMenuItem(value: "delivery", child: Text("Payment on delivery")),
                DropdownMenuItem(value: "pickup", child: Text("Payment on pickup")),
                DropdownMenuItem(value: "now", child: Text("Payment now")),
              ],
            ),

            CustomTextField(
              label: "Pickup person location",
            ),


            CustomTextField(
              label: "Notes",
            ),

            CustomRoundedButton(
              text: "create order".toUpperCase(),
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
    );
  }
}
