import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';
import 'package:ujuzi_xpress/UI/widgets/LocationTextField.dart';
import 'package:ujuzi_xpress/UI/widgets/custom_date_picker.dart';
import 'package:ujuzi_xpress/UI/widgets/profile_image.dart';
import 'package:ujuzi_xpress/utils/models/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/services/FirebaseDatabase.dart';
import 'package:ujuzi_xpress/utils/services/LocationHandler.dart';
import 'package:ujuzi_xpress/utils/models/UjuziUser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ujuzi_xpress/utils/resources.dart';

class ProfilePage extends StatefulWidget {
  @required
  final UjuziUser? user;
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
  String? imageUrl;
  DateTime expiryDate = new DateTime.now();
  AppResources resources = new AppResources();

  ButtonStyle selectedStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
  );

  TextStyle selectedText = TextStyle(color: Colors.white);


  @override
  void initState() {
    super.initState();
    setState(() {
      imageUrl = widget.user!.profileImageUrl;
      username.text = widget.user!.username;
      number.text = widget.user!.number;
      deliveryLocation = widget.user!.location;
      location.text = widget.user!.location.locationName!;
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations
              .of(context)!
              .profile),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getUserCreditCard(widget.user!.id),
          builder: (context, snapshot) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05,
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
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.45,
                        child: Text(
                          AppLocalizations
                              .of(context)!
                              .profile,
                          textAlign: TextAlign.center,
                          style: selectedArray.elementAt(0)
                              ? selectedText
                              : TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.45,
                        child: Text(
                          AppLocalizations
                              .of(context)!
                              .credit_card,
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


  Widget display(Size size, bool profileBool, AsyncSnapshot snapshot) {
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


                child: ProfileImage(
                  url: widget.user!.profileImageUrl,
                  onPressed: () async {
                    final image = await (resources.pickImage());
                    await uploadImage(image: image!, user: widget.user!);
                  },
                ),
              ),


              CustomTextField(
                label: AppLocalizations
                    .of(context)!
                    .username,
                labelColor: Colors.grey,
                color: Colors.black,
                widthFactor: 0.85,
                controller: username,
              ),


              Padding(
                padding: const EdgeInsets.only(
                    right: 50, left: 50.0, top: 8.0, bottom: 8.0),
                child: InternationalPhoneNumberInput(
                    countries: ["CD"],
                    textFieldController: number,
                    inputDecoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)
                      ),
                    ),
                    hintText: AppLocalizations
                        .of(context)!
                        .phoneNumber,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return AppLocalizations
                            .of(context)!
                            .required_field;
                      else if (value.length <= 9)
                        return AppLocalizations
                            .of(context)!
                            .valid_phone_number;
                      return "";
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.DROPDOWN,
                      useEmoji: true,
                      setSelectorButtonAsPrefixIcon: false,
                    ),
                    onInputChanged: (value) {}
                ),
              ),

              LocationTextField(
                focusNode: new FocusNode(),
                label: AppLocalizations
                    .of(context)!
                    .default_pickup_person_location,
                color: Colors.black,
                labelColor: Colors.grey,
                widthFactor: 0.85,
                controller: location,
                onIconTap: () {
                  determinePosition().then((value) {
                    setState(() {
                      location.text = value.locationName!;
                      deliveryLocation = value;
                      deliveryLocation = new DeliveryLocation(name: value
                          .locationName, lat: value.location);
                    });
                  });
                },
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomRoundedButton(
                  text: AppLocalizations
                      .of(context)!
                      .update_profile
                      .toUpperCase(),
                  textColor: Colors.white,
                  onPressed: () {
                    if (widget.user!.username != username.text)
                      widget.user!.update(userName: username.text);
                    if (widget.user!.number != number.text)
                      widget.user!.update(number: number.text);

                    widget.user!.update(location:deliveryLocation);
                    postUserDetails(user: widget.user!);
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
              label: AppLocalizations
                  .of(context)!
                  .cardholder_name,
              labelColor: Colors.grey,
              color: Colors.black,
              controller: cardHolderName,
              widthFactor: 0.85,
            ),

            Container(
                width: size.width,
                padding: EdgeInsets.only(left: 30.0),
                margin: EdgeInsets.only(top: 30, bottom: 4.0),
                child: Text(
                  "Expiry date", style: TextStyle(color: Colors.grey),)
            ),

            GestureDetector(
                onTap: () {
                  DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime((DateTime
                          .now()
                          .year - 20), 1, 1),
                      maxTime: DateTime((DateTime
                          .now()
                          .year + 20), 12, 1),
                      onConfirm: (date) {
                        if (date != null)
                          setState(() {
                            expiryDate = date;
                          });
                      },
                      currentTime: expiryDate,
                      locale: Localizations.localeOf(context)
                  );
                },
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 4.0, bottom: 8.0, left: 24, right: 24),
                    child: CustomDatePicker(date: expiryDate,)
                )
            ),


            CustomTextField(
              label: AppLocalizations
                  .of(context)!
                  .card_number,
              labelColor: Colors.grey,
              color: Colors.black,
              controller: cardNumber,
              widthFactor: 0.85,
            ),

            CustomTextField(
              label: AppLocalizations
                  .of(context)!
                  .ccv,
              labelColor: Colors.grey,
              color: Colors.black,
              controller: ccv,
              widthFactor: 0.85,
            ),


            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomRoundedButton(
                text: AppLocalizations
                    .of(context)!
                    .update_card_details
                    .toUpperCase(),
                textColor: Colors.white,
                onPressed: () {
                  postUserCreditCard(
                      user: widget.user!,
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


}
