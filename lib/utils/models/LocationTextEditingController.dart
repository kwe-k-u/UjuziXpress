
export  'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/utils/models/DeliveryLocation.dart';



class LocationTextEditingController extends TextEditingController{
  DeliveryLocation _deliveryLocation = new DeliveryLocation();



  DeliveryLocation get  location => this._deliveryLocation;


  @override
  set text(String t){
    _deliveryLocation.setLocationName(t);
    super.text = t;
  }



  set location(DeliveryLocation location) {
    _deliveryLocation = location;
    text = location.locationName;
  }
}