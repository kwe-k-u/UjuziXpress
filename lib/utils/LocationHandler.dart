








import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/UI/screens/PickLocationPage.dart';
import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/Directions.dart';
import 'package:ujuzi_xpress/utils/places_search.dart';



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
  } catch (e) {
    return "${e.toString()}";
  }
}




Future<LatLng> getLatLngFromAddress(String place) async{
  Address location = (await Geocoder.local.findAddressesFromQuery(place)).first;

  LatLng latLng = LatLng(location.coordinates.latitude, location.coordinates.longitude);

  return latLng;
}



Future<DeliveryLocation> pickLocation(BuildContext context) async{
  DeliveryLocation location = await Navigator.push(context, MaterialPageRoute(
    builder: (context)=> PickLocationPage()
  ));

  return location;
}



Future<Directions> getDirections(LatLng pickup, LatLng dropOff) async{

  Dio dio = new Dio();
  final response = await dio.get(
      "https://maps.googleapis.com/maps/api/directions/json?",
      queryParameters: {
        'origin' : "${pickup.latitude},${pickup.longitude}",
        'destination' : "${dropOff.latitude},${dropOff.longitude}",
        'key' : "AIzaSyDVwR6I_C_e3Pe9LCnWPn1c0kHmMFckP7w"
      });

  if (response.statusCode == 200)
    return Directions.fromMap(response.data);


  return null ;

}


Future<List<PlaceSearch>> getPlaceSuggestions(String text, String lang ) async{

  Dio dio = new Dio();
  final response = await dio.get(
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
      ,
      queryParameters: {
        "input" : text,
        'types' : "(regions)",
        "language" : lang,
        'key' : "AIzaSyDVwR6I_C_e3Pe9LCnWPn1c0kHmMFckP7w"
      });
  var json = response.data["predictions"] as List;

  return json.map((e) => PlaceSearch.fromJson(e)).toList();

}



