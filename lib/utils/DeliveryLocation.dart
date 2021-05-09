

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/utils/LocationHandler.dart';

class DeliveryLocation{
  String __placeName;
  LatLng __location;

  DeliveryLocation({String name, LatLng lat}){
    __placeName = name;
    __location = lat;
  }




  void setLocationName(String newName){

    this.__placeName = newName;
    getLatLngFromAddress(newName).then((value) {
      this.__location = value;
    });

  }


  void setLocation(LatLng newLatLng){
    this.__location = newLatLng;
    getAddressFromLatLng(newLatLng).then((value) => this.__placeName = value);
  }

  LatLng get location => __location;
  String get locationName => __placeName;

  set location(LatLng newLat){
    this.__location = newLat;
  }

  set name(String newName) => this.__placeName = newName;

  bool equals(Object obj){
    if (this == obj) return true; //if both references point to the same memory location
    if (obj == null || this.runtimeType != obj.runtimeType) return false;

    DeliveryLocation loc =  obj;
    return this.location == loc.location
        && this.locationName == loc.locationName;
  }

  Map<String, dynamic> asMap(){
    return {
      "locationName" : this.locationName,
      "latitude" : this.location.latitude,
      "longitude" : this.location.longitude
    };
  }

}