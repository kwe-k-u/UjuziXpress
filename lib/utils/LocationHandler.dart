







import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/UI/screens/PickLocationPage.dart';
import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';



Future<DeliveryLocation> determinePosition() async {
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  String placeName = await getAddressFromPosition(position);

  return DeliveryLocation(lat: LatLng(position.latitude, position.longitude), name: placeName);
}


Future<String> getAddressFromPosition(Position position) async {
  try {


    Address place = (await Geocoder.local.findAddressesFromCoordinates(new Coordinates(position.latitude, position.longitude))).first;

    return  place.addressLine;
    // return  "${place.adminArea}, ${place.addressLine} ${place.countryName}";
  } catch (e) {
    return "${e.toString()}";
  }
}// From a query


Future<String> getAddressFromLatLng(LatLng latLng) async {
  try {


    Address place = (await Geocoder.local.findAddressesFromCoordinates(new Coordinates(latLng.latitude, latLng.longitude))).first;

    return  place.addressLine;
    // return  "${place.adminArea}, ${place.addressLine} ${place.countryName}";
  } catch (e) {
    return "${e.toString()}";
  }
}// From a query



Future<DeliveryLocation> pickLocation(BuildContext context) async{
  DeliveryLocation location = await Navigator.push(context, MaterialPageRoute(
    builder: (context)=> PickLocationPage()
  ));

  return location;
}
