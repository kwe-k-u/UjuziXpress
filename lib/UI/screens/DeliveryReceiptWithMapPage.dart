import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/DeliveryReceiptTextOnlyPage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
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
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))
                  ),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.account_circle_rounded),
                          title: Text("Kate Wilson"),
                          subtitle: Text("+21336547898"),
                          trailing: OutlinedButton.icon(
                              onPressed: (){},
                              icon: Icon(Icons.call), label: Text("")),
                        ),
                        CustomRoundedButton(
                          text: "View Package Information",
                          textColor: Colors.white,
                          heightPadding: 14.0,
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

