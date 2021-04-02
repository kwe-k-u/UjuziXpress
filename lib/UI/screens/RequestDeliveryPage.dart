import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';
import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/FirebaseDatabase.dart';
import 'package:ujuzi_xpress/utils/LocationHandler.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';


class RequestDeliveryPage extends StatefulWidget {
  final DeliveryRequest request;
  @required final UjuziUser requestingUser;

  RequestDeliveryPage({this.request, this.requestingUser});


  @override
  _RequestDeliveryPageState createState() => _RequestDeliveryPageState();
}

class _RequestDeliveryPageState extends State<RequestDeliveryPage> {
  String deliveryID;
  UjuziUser requestingUser ; // the ujuzi user who requested the delivery //todo is this a duplicate of pickup person?
  DateTime requestDate = DateTime.now(); // the date and time at which the delivery request was made
  DateTime startDate; //the date and time at which the delivery commenced
  DateTime completionDate; //the date and time at which the delivery completed
  DeliveryStatus  status = DeliveryStatus.pending; // the status of the delivery
  PackageType packageType = PackageType.parcel;
  PaymentMethod paymentMethod = PaymentMethod.paymentOnPickup;
  TextEditingController dropOffPersonName = new TextEditingController();
  TextEditingController dropOffPersonNumber = new TextEditingController();
  DeliveryLocation dropOffLocation = new DeliveryLocation();
  TextEditingController pickupPersonName = new TextEditingController();
  TextEditingController pickupPersonNumber = new TextEditingController();
  DeliveryLocation pickupLocation = new DeliveryLocation();
  TextEditingController notes = new TextEditingController();
  TextEditingController pickupLocationController = new TextEditingController();
  TextEditingController dropOffLocationController = new TextEditingController();




//todo locations should return json of long lat as string
  @override
  void initState() {
    super.initState();
    setState(() {
      requestingUser = widget.requestingUser ?? widget.request.requestingUser;
      pickupPersonName.text = requestingUser.username;
      pickupPersonNumber.text = requestingUser.number;
    });


     if (widget.request != null){
       setState(() {

         requestDate = widget.request.requestDate;
         startDate = widget.request.startDate;
         completionDate = widget.request.completionDate;
         status = widget.request.status;
         packageType = widget.request.packageType;
       });
     }
  }

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
                      child: Text("${requestingUser.username}, ${requestingUser.number}, ${pickupLocation.locationName}"),
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
                          value: requestingUser.username,
                          color: Colors.black,
                          onChanged: (value){
                            setState(() {
                              // requestingUser.updateUserName(value);
                              pickupPersonName.text = value;

                            });
                          },
                          widthFactor: 0.85,
                          labelColor: Colors.grey,
                        ),


                        CustomTextField(
                          label: "Pickup person Number",
                          color: Colors.black,
                          inputType: TextInputType.number,
                          labelColor: Colors.grey,
                          widthFactor: 0.85,
                          value: requestingUser.number,
                          onChanged: (value){
                            setState(() {
                              requestingUser.updateNumber(value);
                              // pickupPersonNumber = value;

                            });
                          },
                        ),



                        CustomTextField(
                          label: "Pickup person location",
                          color: Colors.black,
                          labelColor: Colors.grey,
                          widthFactor: 0.85,
                          controller: pickupLocationController,
                          icon: IconButton(
                              icon:Icon(Icons.my_location),
                            onPressed: (){
                                determinePosition().then((value) {
                                  setState(() {
                                    pickupLocation = value;
                                    pickupLocationController.text = value.locationName;
                                  });
                                });
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
                controller: dropOffLocationController,
                value: dropOffLocation.locationName,
                icon: IconButton(
                  icon:Icon(Icons.my_location),
                  onPressed: (){

                    pickLocation(context).then((value) {

                      if (value != null) {
                        setState(() {
                          dropOffLocation = value;
                          dropOffLocationController.text = value.locationName;

                        });
                      }
                    });


                  },
                ),
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
                controller: dropOffPersonName,
                label: "DropOff person name",
                color: Colors.black,
                onChanged: (value){
                },
                widthFactor: 0.85,
                labelColor: Colors.grey,
              ),


              CustomTextField(
                label: "DropOff person Number",
                color: Colors.black,
                labelColor: Colors.grey,
                inputType: TextInputType.number,
                controller: dropOffPersonNumber,
                widthFactor: 0.85,
                onChanged: (value){

                },
              ),






              CustomTextField(
                label: "Notes",
                color: Colors.black,
                labelColor: Colors.grey,
                widthFactor: 0.85,
                expanded: true,
                controller: notes,
                onChanged: (value){
                  // setState(() {
                  //   notes = value;
                  // });
                },
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
                        setState(() {
                          packageType = value;

                        });
                      },
                      hint: Text("Package type"),
                      value: packageType,
                      items: [
                        DropdownMenuItem(value: PackageType.letter, child: Text("Letter")),
                        DropdownMenuItem(value: PackageType.parcel, child: Text("Parcel")),
                        DropdownMenuItem(value: PackageType.large, child: Text("Large")),
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
                          setState(() {
                            paymentMethod = value;
                          });
                        },
                        hint: Text("Payment method"),
                        value: paymentMethod,
                        items: [
                          DropdownMenuItem(value: PaymentMethod.paymentOnDelivery, child: Text("Payment on delivery")),
                          DropdownMenuItem(value: PaymentMethod.paymentOnPickup, child: Text("Payment on pickup")),
                          DropdownMenuItem(value: PaymentMethod.creditCard, child: Text("Payment via Credit Card")),
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
                  DeliveryRequest request = DeliveryRequest(
                    requestingUser: requestingUser,
                    dropOffLocation: dropOffLocation,
                    dropOffPersonName: dropOffPersonName.text,
                    dropOffPersonNumber: dropOffPersonNumber.text,
                    pickupPersonName: pickupPersonNumber.text,
                    pickupPersonNumber: pickupPersonName.text,
                    pickupLocation: pickupLocation,
                    requestDate: requestDate,
                    status: DeliveryStatus.pending,
                    paymentMethod: paymentMethod,
                    packageType: packageType,
                    startDate: startDate,
                    completionDate: completionDate,
                    deliveryID: deliveryID,
                    note: notes.text
                  );

                  // print(request.asMap().toString());

                  requestDelivery(request).then((value) => Navigator.pop(context));
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}
