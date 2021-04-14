import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';
import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/FirebaseDatabase.dart';
import 'package:ujuzi_xpress/utils/LocationHandler.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  @required
  final UjuziUser user;
  ProfilePage({this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<bool> selectedArray = [true, false];
  TextEditingController username = new TextEditingController();
  TextEditingController number = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController ccv = new TextEditingController();
  TextEditingController cardHolderName = new TextEditingController();
  TextEditingController cardNumber = new TextEditingController();




  DeliveryLocation deliveryLocation = new DeliveryLocation();
  String imageUrl;
  DateTime expiryDate = new DateTime.now();

  ButtonStyle selectedStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
  );

  TextStyle selectedText = TextStyle(color: Colors.white);













  Widget display(Size size, bool profileBool, AsyncSnapshot snapshot) {

    final List<dynamic> months = [
      AppLocalizations.of(context).jan,
      AppLocalizations.of(context).feb,
      AppLocalizations.of(context).mar,
      AppLocalizations.of(context).apr,
      AppLocalizations.of(context).may,
      AppLocalizations.of(context).jun,
      AppLocalizations.of(context).jul,
      AppLocalizations.of(context).aug,
      AppLocalizations.of(context).sept,
      AppLocalizations.of(context).oct,
      AppLocalizations.of(context).nov,
      AppLocalizations.of(context).dec
    ];

    if (profileBool) {
      return SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 8.0,
                  right: 8.0,
                  bottom: 8.0,
                ),


                child: ClipOval(
                  child: Image.network(widget.user
                      .profileImageUrl), //ontap to change
                ),
              ),


              CustomTextField(
                label:   AppLocalizations.of(context).username,
                labelColor: Colors.grey,
                color: Colors.black,
                widthFactor: 0.85,
                controller: username,
              ),
              CustomTextField(
                label:   AppLocalizations.of(context).phoneNumber,
                labelColor: Colors.grey,
                color: Colors.black,
                widthFactor: 0.85,
                controller: number,
              ),
              CustomTextField(
                label:   AppLocalizations.of(context).default_pickup_person_location,
                color: Colors.black,
                labelColor: Colors.grey,
                widthFactor: 0.85,
                controller: location,
                icon: IconButton(
                  icon: Icon(Icons.my_location),
                  onPressed: () {
                    determinePosition().then((value) {
                      setState(() {
                        location.text = value.locationName;
                        deliveryLocation = value;
                        deliveryLocation = new DeliveryLocation(name: value.locationName, lat: value.location);
                      });
                    });
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomRoundedButton(
                  text:   AppLocalizations.of(context).update_profile.toUpperCase(),
                  textColor: Colors.white,
                  onPressed: () {

                    if (widget.user.username != username.text) widget.user.updateUserName(username.text);
                    if (widget.user.number != number.text) widget.user.updateNumber(number.text);
                    widget.user.updateDefaultLocation(deliveryLocation);
                    postUserDetails(user: widget.user, location :deliveryLocation);
                    Navigator.pop(context, widget.user);
                  },
                ),
              )
            ],
          ),
        ),
      );
    }




    if (snapshot.data.exists) {
      ccv.text = snapshot.data["ccv"];
      cardNumber.text = snapshot.data['cardNumber'];
      cardHolderName.text = snapshot.data["holderName"];
      expiryDate = DateTime.parse(snapshot.data["expiryDate"]);
    }

    //display credit card information
    return SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              label:   AppLocalizations.of(context).cardholder_name,
              labelColor: Colors.grey,
              color: Colors.black,
              controller: cardHolderName,
              widthFactor: 0.85,
            ),


            GestureDetector(
              onTap: (){
                DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    minTime: DateTime((DateTime.now().year - 20), 1, 1),
                    maxTime: DateTime((DateTime.now().year + 20), 12, 1),
                    onConfirm: (date) {
                      if (date != null)
                        setState(() {
                          expiryDate = date;
                        });
                    },
                    currentTime: expiryDate,
                    locale: LocaleType.en //todo get to work with local running on   AppLocalizations.delegate
                );
              },
              child:Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(  AppLocalizations.of(context).day),
                            Text(this.expiryDate.day.toString(), style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context).textTheme.subtitle1.fontSize
                            ),),
                          ],
                        ),
                        width: size.width * 0.2,
                        color: Colors.grey.withOpacity(0.6),
                      ),

                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(AppLocalizations.of(context).month),
                            Text(months.elementAt(expiryDate.month-1), style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context).textTheme.subtitle1.fontSize
                            ),),
                          ],
                        ),
                        width: size.width * 0.3,
                        color: Colors.grey.withOpacity(0.6),
                      ),

                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(AppLocalizations.of(context).year),
                            Text(expiryDate.year.toString(), style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Theme.of(context).textTheme.subtitle1.fontSize
                            ),),
                          ],
                        ),
                        width: size.width * 0.2,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                    ],
                  )
              )
            ),


            CustomTextField(
              label: AppLocalizations.of(context).card_number,
              labelColor: Colors.grey,
              color: Colors.black,
              controller: cardNumber,
              widthFactor: 0.85,
            ),

            CustomTextField(
              label: AppLocalizations.of(context).ccv,
              labelColor: Colors.grey,
              color: Colors.black,
              controller: ccv,
              widthFactor: 0.85,
            ),




            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomRoundedButton(
                text: AppLocalizations.of(context).update_card_details.toUpperCase(),
                textColor: Colors.white,
                onPressed: (){


                  postUserCreditCard(
                    user: widget.user,
                    ccv: ccv.text,
                    expiryDate: expiryDate,
                    cardNumber: cardNumber.text,
                    holderName: cardHolderName.text
                  );

                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }











  @override
  void initState() {
    super.initState();
    setState(() {


       imageUrl = widget.user.profileImageUrl;
       username.text = widget.user.username;
       number.text = widget.user.number;
       deliveryLocation = widget.user.location;
       location.text = widget.user.location.locationName;
    });
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
          title: Text(AppLocalizations.of(context).profile),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getUserCreditCard(widget.user.id),
          builder: (context, snapshot){
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ToggleButtons(
                    borderWidth: 1.5,
                    isSelected: selectedArray,
                    color: Colors.black,
                    borderColor: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    fillColor: Colors.deepPurple,
                    onPressed: (index) {
                      selectedArray = [false, false];
                      setState(() {
                        selectedArray[index] = true;
                      });
                    },
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          AppLocalizations.of(context).profile,
                          textAlign: TextAlign.center,
                          style: selectedArray.elementAt(0)
                              ? selectedText
                              : TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          AppLocalizations.of(context).credit_card,
                          textAlign: TextAlign.center,
                          style: selectedArray.elementAt(1)
                              ? selectedText
                              : TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: 1,
                child: display(size, selectedArray.elementAt(0), snapshot))


              ],
            );


          },
        ),
      ),
    );
  }
}
