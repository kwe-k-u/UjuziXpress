import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';
import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/FirebaseDatabase.dart';
import 'package:ujuzi_xpress/utils/LocationHandler.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';

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
  DeliveryLocation deliveryLocation = new DeliveryLocation();
  String imageUrl; //todo implement display image

  ButtonStyle selectedStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
  );

  TextStyle selectedText = TextStyle(color: Colors.white);












  Widget display(Size size, bool profileBool, AsyncSnapshot snapshot) {
    if (profileBool) {
      //display profile information
      // if(snapshot.hasData)
      // if (snapshot.data[0] != null) { // prefill data if exists
      //   setState(() {
      //     username.text = snapshot.data[0]['username'] ?? "";
      //     number.text = snapshot.data[0]["number"] ?? "";
      //
      //     if (snapshot.data[0]["location"] != null)
      //       deliveryLocation = new DeliveryLocation(
      //           name: snapshot.data[0]["location"]['locationName'],
      //           lat: LatLng(snapshot.data[0]["location"]['latitude'],
      //               snapshot.data[0]["location"]['longitude']));
      //
      //     location.text = deliveryLocation.locationName ?? "";
      //   });
      // }

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


                child: CircleAvatar(
                  minRadius: size.width * 0.05,
                  maxRadius: size.width * 0.15,
                  child: Image.network(widget.user.profileImageUrl),//todo clip image and ontap to change
                ),
              ),
              CustomTextField(
                label: "Username",
                labelColor: Colors.grey,
                color: Colors.black,
                widthFactor: 0.85,
                controller: username,
              ),
              CustomTextField(
                label: "Number",
                labelColor: Colors.grey,
                color: Colors.black,
                widthFactor: 0.85,
                controller: number,
              ),
              CustomTextField(
                label: "Default Pickup person location",
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

                      });
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomRoundedButton(
                  text: "Update profile".toUpperCase(),
                  textColor: Colors.white,
                  onPressed: (){
                    widget.user.updateUserName(username.text);
                    widget.user.updateNumber(number.text);
                    widget.user.updateDefaultLocation(deliveryLocation);
                    postUserDetails(widget.user);
                  },
                ),
              )
            ],
          ),
        ),
      );
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
              label: "Cardholder Name",
              labelColor: Colors.grey,
              color: Colors.black,
              widthFactor: 0.85,
            ),
            CustomTextField(
              label: "Expiry Date", //todo make a date picker?
              labelColor: Colors.grey,
              color: Colors.black,
              widthFactor: 0.85,
            ),
            CustomTextField(
              label: "Card Number",
              labelColor: Colors.grey,
              color: Colors.black,
              widthFactor: 0.85,
            ),
            CustomTextField(
              label: "CCV",
              labelColor: Colors.grey,
              color: Colors.black,
              widthFactor: 0.85,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomRoundedButton(
                text: "Update card details".toUpperCase(),
                textColor: Colors.white,
                onPressed: (){
                  //todo update card info
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

       username.text = widget.user.username;
       number.text = widget.user.number;
       location.text = widget.user.location.locationName;
       deliveryLocation = widget.user.location;
    });
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
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
                        "Profile",
                        textAlign: TextAlign.center,
                        style: selectedArray.elementAt(0)
                            ? selectedText
                            : TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        "Credit card",
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
    );
  }
}
