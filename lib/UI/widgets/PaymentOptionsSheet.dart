import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/HomePage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/custom_date_picker.dart';
import 'package:ujuzi_xpress/utils/models/LocationTextEditingController.dart';
import 'package:ujuzi_xpress/utils/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PaymentOptionsSheet extends StatefulWidget {
  @override
  _PaymentOptionsSheetState createState() => _PaymentOptionsSheetState();
}

class _PaymentOptionsSheetState extends State<PaymentOptionsSheet> {
  AppResources resources = new AppResources();

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

                    child: Text("With Card"), //todo localisations
                    onPressed: (){

                    }),
                Spacer(
                  flex: 8,
                ),
                OutlinedButton(

                    child: Text("On Delivery"), //todo localisations
                    onPressed: (){

                    }),
                Spacer(
                  flex: 2,
                ),
                OutlinedButton(

                    child: Text("On Pickup"), //todo localisations
                    onPressed: (){

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
