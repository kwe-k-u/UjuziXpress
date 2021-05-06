

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/FirebaseDatabase.dart';



class UjuziUser{
  User _firebaseUser;
  DeliveryLocation _location = new DeliveryLocation();
  DocumentReference _reference;

  String get username => this._firebaseUser.displayName ?? "User";
  String get id => this._firebaseUser.uid;
  String get number => this._firebaseUser.phoneNumber ?? "";
  String get profileImageUrl => this._firebaseUser.photoURL;
  String get email => this._firebaseUser.email ?? "";
  DeliveryLocation get location => this._location;
  DocumentReference get reference => this._reference;


  UjuziUser({User user,String number}){

    this._firebaseUser = user;
    getUserDetails(user.uid)
        .then((value) {
          if (value != null)
        this._location = new DeliveryLocation(name: value["locationName"],
            lat: LatLng(value["latitude"], value["longitude"]) );
      else
        this._location = null;
    }
    );
  }

  void updateUserName(String name){
    this._firebaseUser.updateProfile(displayName: name);
  }


  void updateDefaultLocation(DeliveryLocation location){
    this._location = location;
  }

  void updateEmail(String mail){
    this._firebaseUser.updateEmail(mail);
  }

  void updateProfileImage(String url){
    //todo merge all updates into one function
    this._firebaseUser.updateProfile(photoURL:  url);
  }

  // void updateId(String id){
  //   this.__id = id;
  // }

  void updateNumber(String newNumber) {
    //todo complete implementation
    // postUserDetails(this.)
    // this._firebaseUser.linkWithPhoneNumber(newNumber, RecaptchaVerifier());
  }







  // Map<String, dynamic> asMap(){
  //   return {
  //     "number" : number,
  //     "username" : username,
  //     "email" : email,
  //     "id" : id,
  //     "location" : location.asMap()
  //   };
  //
  //
  //
  // }



}