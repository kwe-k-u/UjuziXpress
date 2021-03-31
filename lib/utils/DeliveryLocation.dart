

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryLocation{
  String __placeName;
  LatLng __location;

  DeliveryLocation({String name, LatLng lat}){
    __placeName = name;
    __location = lat;
  }




  void setLocationName(String newName){

    this.__placeName = newName;

  }


  void setLocation(LatLng newLatLng){
    this.__location = newLatLng;
  }

  LatLng get location => __location;
  String get locationName => __placeName;

  bool equals(Object obj){
    if (this == obj) return true; //if both references point to the same memory location
    if (obj == null || this.runtimeType != obj.runtimeType) return false;

    DeliveryLocation loc =  obj;
    return this.location == loc.location
        && this.locationName == loc.locationName;
  }


}