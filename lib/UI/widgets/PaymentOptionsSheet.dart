import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/custom_date_picker.dart';
import 'package:ujuzi_xpress/utils/models/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/models/LocationTextEditingController.dart';
import 'package:ujuzi_xpress/utils/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ujuzi_xpress/utils/services/FirebaseDatabase.dart';


class PaymentOptionsSheet extends StatefulWidget {
  final DeliveryRequest request;

  const PaymentOptionsSheet({Key? key, required this.request}) : super(key: key);

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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          //date of delivery
          ListTile(
            enabled: false,
            title: Text(AppLocalizations.of(context)!.when_delivery_begin),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomDatePicker(
                date: widget.request.startDate ?? DateTime.now(),
                onChanged: (value){
                  widget.request.setStartDate(value);
                },
              ),
            ),
          ),


          //payment method
          ListTile(
            enabled: false,
            title: Text(AppLocalizations.of(context)!.how_do_you_pay),
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
                    child: Text(AppLocalizations.of(context)!.with_card),
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
                    child: Text(AppLocalizations.of(context)!.on_delivery),
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

                    child: Text(AppLocalizations.of(context)!.on_pickup),
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
            text: AppLocalizations.of(context)!.complete_delivery,
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
