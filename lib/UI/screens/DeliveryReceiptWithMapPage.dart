import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/DeliveryReceiptTextOnlyPage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/DeliveryStatusTile.dart';
import 'package:ujuzi_xpress/UI/widgets/MapUi.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';


class DeliveryReceiptWithMapPage extends StatefulWidget {
  @required final DeliveryRequest deliveryRequest;

DeliveryReceiptWithMapPage({this.deliveryRequest});



  @override
  _DeliveryReceiptWithMapPageState createState() => _DeliveryReceiptWithMapPageState();
}

class _DeliveryReceiptWithMapPageState extends State<DeliveryReceiptWithMapPage> {






  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(


      body: Stack(
        children: [
          MapUi(),


          DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.1,
              maxChildSize: 0.3,
              builder: (context, controller){
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))
                  ),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [



                        Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,//todo darker
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))
                          ),
                          height: size.height * 0.1,
                          width: size.width,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all( Radius.circular(16.0))
                              ),
                              width: size.width * 0.6,
                              height: size.height *0.01,
                            ),
                          ),
                        ),

                        DeliveryStatusTile(
                          status: widget.deliveryRequest.status,
                        ),

                        ListTile(
                          leading: Icon(Icons.account_circle_rounded),
                          title: Text("Delivery Rider"),
                          subtitle: Text("+21336547898"),
                          trailing: OutlinedButton.icon(
                              onPressed: (){},
                              icon: Icon(Icons.call), label: Text("")),
                        ),

                        CustomRoundedButton(
                          text: "View Package Information",
                          textColor: Colors.white,
                          elevation: 0,
                          widthFactor: 0.25,
                          heightPadding: 15.0,
                          onPressed: (){
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context)=> DeliveryReceiptWithTextOnlyPage(deliveryRequest: widget.deliveryRequest,)
                            )
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }
}

