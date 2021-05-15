import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ujuzi_xpress/UI/screens/HomePage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/custom_date_picker.dart';
import 'package:ujuzi_xpress/utils/models/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/models/LocationTextEditingController.dart';
import 'package:ujuzi_xpress/utils/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ujuzi_xpress/utils/services/FirebaseDatabase.dart';


class PaymentOptionsSheet extends StatefulWidget {
  final DeliveryRequest request;

  const PaymentOptionsSheet({Key key, @required this.request}) : super(key: key);

  @override
  _PaymentOptionsSheetState createState() => _PaymentOptionsSheetState();
}

class _PaymentOptionsSheetState extends State<PaymentOptionsSheet> {
  AppResources resources = new AppResources();
  List<bool> _selectedIndexes = [true, false, false];

  void updateSelection(int index){
    setState(() {
      _selectedIndexes = [false, false, false];
      _selectedIndexes[index] = true;
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Container(
      height: size.height * 0.4,
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          //date of delivery
          ListTile(//todo for changing request start date
            enabled: false,
            title: Text("When should delivery begin?"),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDatePicker(
                date: DateTime.now(),
              ),
            ),
          ),


          //payment method
          ListTile(
            enabled: false,
            title: Text("How do you want to pay?"),
            subtitle: Row(
              children: [
                Spacer(
                  flex: 1,
                ),



                OutlinedButton(
                    style: ButtonStyle(
                      elevation: _selectedIndexes[0] ? MaterialStateProperty.all<double>(1) : null,
                        shadowColor: _selectedIndexes[0] ? MaterialStateProperty.all<Color>(resources.primaryColour.withOpacity(0.6)) : null,
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                        )
                    ),
                    child: Text("With Card"), //todo localisations
                    onPressed: (){
                      updateSelection(0);
                    }),

                Spacer(
                  flex: 8,
                ),


                OutlinedButton(
                    style: ButtonStyle(
                        elevation: _selectedIndexes[1] ? MaterialStateProperty.all<double>(1) : null,
                        shadowColor: _selectedIndexes[1] ? MaterialStateProperty.all<Color>(resources.primaryColour.withOpacity(0.6)) : null,
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                        )
                    ),
                    child: Text("On Delivery"), //todo localisations
                    onPressed: (){
                    updateSelection(1);

                    }),
                Spacer(
                  flex: 2,
                ),

                OutlinedButton(
                    style: ButtonStyle(
                        elevation: _selectedIndexes[2] ? MaterialStateProperty.all<double>(1) : null,
                        shadowColor: _selectedIndexes[2] ? MaterialStateProperty.all<Color>(resources.primaryColour.withOpacity(0.6)) : null,
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                        )
                    ),

                    child: Text("On Pickup"), //todo localisations
                    onPressed: (){
                      updateSelection(2);
                    }),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),

          Spacer(),

          CustomRoundedButton(
            elevation: 0,
            widthFactor: 0.3,
            text: "Complete Payment",
            textColor: Colors.white,
            onPressed: (){
              {



                  requestDelivery(widget.request).then((value) =>
                      Navigator.pop(context));


                int i =0;
                Navigator.popUntil(context, (route) => i++ == 2);

              }

            },
          ),
        ],
      ),
    );
  }
}
