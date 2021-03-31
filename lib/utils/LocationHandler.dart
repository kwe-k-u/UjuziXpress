







import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';



Future<DeliveryLocation> determinePosition() async {
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  String placeName = await getAddressFromLatLng(position);

  return DeliveryLocation(lat: LatLng(position.latitude, position.longitude), name: placeName);
}


Future<String> getAddressFromLatLng(Position position) async {
  try {


    Address place = (await Geocoder.local.findAddressesFromCoordinates(new Coordinates(position.latitude, position.longitude))).first;

      return  place.addressLine;
      // return  "${place.adminArea}, ${place.addressLine} ${place.countryName}";
  } catch (e) {
    return "${e.toString()}";
  }
}// From a query
// final query = "1600 Amphiteatre Parkway, Mountain View";
// var addresses = await Geocoder.local.findAddressesFromQuery(query);
// var first = addresses.first;
// print("${first.featureName} : ${first.coordinates}");
