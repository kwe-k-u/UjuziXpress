import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/widgets/DeliveryListTile.dart';
import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/Person.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';



class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // DeliveryStatus __status = DeliveryStatus.pending;
  List<bool> selectedArray = [true, false, false];




  ButtonStyle selectedStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.deepPurple),

  );
  // ButtonStyle deSelectedStyle = ButtonStyle();


  TextStyle selectedText = TextStyle(color: Colors.white);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        centerTitle: true,
      ),


      body: Container(
        child: Column(
          children: [


            Container(
              margin: EdgeInsets.only(top: 8.0),
              height: MediaQuery.of(context).size.height *0.05,
              child: ToggleButtons(
                borderWidth: 1.5,
                isSelected: selectedArray,
                color: Colors.black,
                borderColor: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                fillColor: Colors.deepPurple,
                onPressed: (index){
                  setState(() {
                    selectedArray = [false, false, false];
                    selectedArray[index] = true;
                  });
                },
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text("Pending",

                      textAlign: TextAlign.center,
                      style: selectedArray.elementAt(0) ? selectedText : TextStyle(fontWeight: FontWeight.bold),),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child:  Text("completed",
                      textAlign: TextAlign.center,
                      style: selectedArray.elementAt(1) ? selectedText : TextStyle(fontWeight: FontWeight.bold),),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text("Canceled",
                      textAlign: TextAlign.center,
                      style: selectedArray.elementAt(2) ? selectedText : TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: 2,
                  itemBuilder: (context,index){
                  return DeliveryListTile(
                    deliveryRequest: new DeliveryRequest(
                        requestingUser: UjuziUser(),
                        paymentMethod: PaymentMethod.creditCard,
                        dropOffLocation: DeliveryLocation(name: "SomePlace"),
                        pickupLocation: DeliveryLocation(name: "other"),
                        requestDate: DateTime.now(),
                        dropOffPerson:new Person(
                            name: "Billy",
                            number: "0556598",
                            location: new DeliveryLocation(
                                name: "Accra new town"
                            )
                        ),
                        pickupPerson: new Person(
                            name: "Billy",
                            number: "0556598",
                            location: new DeliveryLocation(
                                name: "Accra new town"
                            )
                        ),
                        status: DeliveryStatus.complete,
                        packageType: PackageType.parcel
                    ),
                  );
              }),
            )
          ],
        ),
      ),
    );
  }
}
