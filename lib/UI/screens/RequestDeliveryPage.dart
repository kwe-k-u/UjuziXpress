
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';
import 'package:ujuzi_xpress/UI/widgets/LocationTextField.dart';
import 'package:ujuzi_xpress/UI/widgets/PaymentOptionsSheet.dart';
import 'package:ujuzi_xpress/utils/models/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/services/LocationHandler.dart';
import 'package:ujuzi_xpress/utils/models/LocationTextEditingController.dart';
import 'package:ujuzi_xpress/utils/models/UjuziUser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
  // DeliveryLocation dropOffLocation = new DeliveryLocation();
  TextEditingController pickupPersonName = new TextEditingController();
  TextEditingController pickupPersonNumber = new TextEditingController();
  // DeliveryLocation pickupLocation = new DeliveryLocation();
  TextEditingController notes = new TextEditingController();
  // TextEditingController pickupLocationController = new TextEditingController();
  LocationTextEditingController pickupLocationController = new LocationTextEditingController() ;
  LocationTextEditingController dropOffLocationController = new LocationTextEditingController() ;
  // TextEditingController dropOffLocationController = new TextEditingController();
  FocusNode pickupLocationNode = new FocusNode();
  FocusNode dropoffLocationNode = new FocusNode();




  @override
  void initState() {
    super.initState();
    setState(() {
      requestingUser = widget.requestingUser ?? widget.request.requestingUser;
      pickupPersonName.text = requestingUser.username;
      pickupPersonNumber.text = requestingUser.number;
      pickupLocationController.location = requestingUser.location;
      pickupLocationController.location = requestingUser.location;
    });


     if (widget.request != null){
       setState(() {

         requestDate = widget.request.requestDate;
         startDate = widget.request.startDate;
         completionDate = widget.request.completionDate;
         status = widget.request.status;
         packageType = widget.request.packageType;
         dropOffPersonName.text = widget.request.dropOffPersonName;
         dropOffPersonNumber.text = widget.request.dropOffPersonNumber;
         dropOffLocationController.text = widget.request.dropOffLocation.locationName;
         dropOffLocationController.location = widget.request.dropOffLocation;
         pickupPersonNumber.text = widget.request.pickupPersonNumber;
         pickupPersonName.text = widget.request.pickupPersonName;
         pickupLocationController.location = widget.request.pickupLocation;
         pickupLocationController.text = widget.request.pickupLocation.locationName;
         notes.text = widget.request.notes;


       });
     }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                      child: Text(AppLocalizations.of(context).pickup_person_details),
                    ),
                    collapsed: Container(
                      padding: EdgeInsets.all(8),
                      width: size.width,
                        child: Text("${requestingUser.username}, ${requestingUser.number}, ${pickupLocationController.text}"),
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
                            label: AppLocalizations.of(context).pickup_person_name,
                            color: Colors.black,
                            controller: pickupPersonName,
                            onChanged: (value){
                            },
                            widthFactor: 0.85,
                            labelColor: Colors.grey,
                          ),



                          InternationalPhoneNumberInput(
                              countries: ["CD"],
                              textFieldController: pickupPersonNumber,
                              hintText: AppLocalizations.of(context).pickup_person_number,
                              validator: (value){
                                if (value == null || value.isEmpty)
                                  return AppLocalizations.of(context).required_field;
                                else if (value.length <= 9)
                                  return AppLocalizations.of(context).valid_phone_number;
                                return "";
                              },
                              selectorConfig: SelectorConfig(
                                selectorType: PhoneInputSelectorType.DROPDOWN,
                                useEmoji:  true,
                                setSelectorButtonAsPrefixIcon: false,
                              ),
                              onInputChanged: (value){
                              }
                          ),



                          LocationTextField(
                            label: AppLocalizations.of(context).pickup_person_location,
                            color: Colors.black,
                            focusNode: pickupLocationNode,
                            labelColor: Colors.grey,
                            widthFactor: 0.85,
                            controller: pickupLocationController,
                            onIconTap: (){
                              determinePosition().then((value) {
                                setState(() {
                                  pickupLocationController.location = value;
                                  pickupLocationController.text = value.locationName;
                                });
                              });
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),



                LocationTextField(
                  label: AppLocalizations.of(context).where_to,
                  color: Colors.black,
                  focusNode: dropoffLocationNode,
                  labelColor: Colors.grey,
                  widthFactor: 0.85,
                  controller: dropOffLocationController,
                  value: dropOffLocationController.text,
                  onIconTap: (){

                    pickLocation(context).then((value) {
                      if (value != null) {
                        setState(() {
                          dropOffLocationController.text = value.locationName;

                        });
                      }
                    });
                  },
                ),





                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 32.0),
                    child: Text(
                      AppLocalizations.of(context).pickup_details,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0
                      ),
                    ),
                  ),
                ),

                CustomTextField(
                  controller: dropOffPersonName,
                  label: AppLocalizations.of(context).dropoff_person_name,
                  color: Colors.black,
                  onChanged: (value){
                  },
                  widthFactor: 0.85,
                  labelColor: Colors.grey,
                ),


                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0
                  ),
                  child: InternationalPhoneNumberInput(
                      countries: ["CD"],
                    textFieldController: dropOffPersonNumber,
                    hintText: AppLocalizations.of(context).dropoff_person_number,
                      validator: (value){
                        if (value == null || value.isEmpty)
                          return AppLocalizations.of(context).required_field;
                        else if (value.length <= 9)
                          return AppLocalizations.of(context).valid_phone_number;
                        return "";
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.DROPDOWN,
                        useEmoji:  true,
                        setSelectorButtonAsPrefixIcon: false,
                      ),
                      onInputChanged: (value){
                      }
                  ),
                ),






                CustomTextField(
                  label: AppLocalizations.of(context).notes,
                  color: Colors.black,
                  labelColor: Colors.grey,
                  widthFactor: 0.85,
                  expanded: true,
                  controller: notes,
                  onChanged: (value){

                  },
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 36.0),
                      child: Text("${AppLocalizations.of(context).package_type}: "),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: DropdownButton(
                        onChanged: (value){
                          setState(() {
                            packageType = value;

                          });
                        },
                        hint: Text(AppLocalizations.of(context).package_type),
                        value: packageType,
                        items: [
                          DropdownMenuItem(value: PackageType.letter, child: Text(AppLocalizations.of(context).letter)),
                          DropdownMenuItem(value: PackageType.parcel, child: Text(AppLocalizations.of(context).parcel)),
                          DropdownMenuItem(value: PackageType.large, child: Text(AppLocalizations.of(context).large)),
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
                      Text("${AppLocalizations.of(context).payment_method}: "),

                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: DropdownButton(
                          onChanged: (value){
                            setState(() {
                              paymentMethod = value;
                            });
                          },
                          hint: Text(AppLocalizations.of(context).payment_method),
                          value: paymentMethod,
                          items: [
                            DropdownMenuItem(value: PaymentMethod.paymentOnDelivery, child: Text(AppLocalizations.of(context).payment_on_delivery)),
                            DropdownMenuItem(value: PaymentMethod.paymentOnPickup, child: Text(AppLocalizations.of(context).payment_on_pickup)),
                            DropdownMenuItem(value: PaymentMethod.creditCard, child: Text(AppLocalizations.of(context).payment_via_credit_card)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //todo add date picker to final popup about payment and stuff


                CustomRoundedButton(
                  text: AppLocalizations.of(context).request_delivery.toUpperCase(),
                  onPressed: (){
                    showModalBottomSheet(
                      enableDrag: false,
                      context: context,
                      builder: (context) => PaymentOptionsSheet()
                    );




                    // DeliveryRequest request = DeliveryRequest(
                    //   requestingUser: requestingUser,
                    //   dropOffLocation: dropOffLocationController.location,
                    //   dropOffPersonName: dropOffPersonName.text,
                    //   dropOffPersonNumber: dropOffPersonNumber.text,
                    //   pickupPersonName: pickupPersonName.text,
                    //   pickupPersonNumber: pickupPersonNumber.text,
                    //   pickupLocation: pickupLocationController.location,
                    //   requestDate: requestDate,
                    //   status: DeliveryStatus.pending,
                    //   paymentMethod: paymentMethod,
                    //   packageType: packageType,
                    //   startDate: startDate,
                    //   completionDate: completionDate,
                    //   deliveryID: deliveryID,
                    //   note: notes.text
                    // );
                    //
                    //
                    // if (widget.request != null)//old delivery
                    //   request.setReference(widget.request.reference);
                    //
                    //   requestDelivery(request).then((value) =>
                    //       Navigator.pop(context));
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}



//todo add custom text editing controller for locations