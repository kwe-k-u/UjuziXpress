

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/utils/models/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/services/FirebaseDatabase.dart';



class UjuziUser{
  User _firebaseUser;
  DeliveryLocation _location = new DeliveryLocation();
  DocumentReference _reference;
  String _number = "";

  String get username => this._firebaseUser.displayName ?? "User";
  String get id => this._firebaseUser.uid;
  String get number => this._number ?? "";
  String get profileImageUrl => this._firebaseUser.photoURL;
  String get email => this._firebaseUser.email ?? "";
  DeliveryLocation get location => this._location;
  DocumentReference get reference => this._reference;


  UjuziUser({User user,String number}){

    this._firebaseUser = user;
    getUserDetails(user.uid)
        .then((value) {
          if (value != null) {
            this._location =
            new DeliveryLocation(name: value["location"]["locationName"],
                lat: LatLng(value["location"]["latitude"],
                    value["location"]["longitude"]));

            this._number = value["number"];
          }
      else
        this._location = null;
    }
    );
  }

  void update({String number, String mail, DeliveryLocation location, String profileUrl, String userName}){

    if (number != null)
      this._number = number;

    if (userName != null)
      this._firebaseUser.updateDisplayName( userName);

    if (mail != null)
      this._firebaseUser.updateEmail(mail);

    if (profileUrl != null)
      this._firebaseUser.updatePhotoURL( profileUrl);

    if (location != null)
      this._location = location;

  }






  Map<String, dynamic> asMap(){
    return {
      "number" : number,
      "location" : location.asMap()
    };



  }



}