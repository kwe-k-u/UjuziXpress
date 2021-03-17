

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/Person.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';

class DeliveryRequest{
  String __deliveryID; // unique identifier for deliveries
  UjuziUser __requestingUser; // the ujuzi user who requested the delivery //todo is this a duplicate of pickup person?
  DateTime __requestDate; // the date and time at which the delivery request was made
  DateTime __startDate; //the date and time at which the delivery commenced
  DateTime __completionDate; //the date and time at which the delivery completed
  DeliveryStatus  __status; // the status of the delivery
  PackageType __package; // the type of package delivered
  Person __dropoffPerson; // person to whom the package will be dropped off
  Person __pickupPerson; // person to whom the package will be dropped off //todo make this null if pickup details are those of the ujuzi user
  DeliveryLocation __pickupLocation ; // the location where the package is to be picked up
  DeliveryLocation __dropOffLocation; // the location where the package is to be dropped off


String get deliveryID => this.__deliveryID;
UjuziUser get requestingUser => this.__requestingUser;
DeliveryStatus get status => this.__status;
PackageType get packageType => this.__package;
Person get pickupPerson => this.__pickupPerson;
Person get dropOffPerson => this.__dropoffPerson;
DateTime get requestDate => this.__requestDate;
DateTime get startDate => this.__startDate;
DateTime get completionDate => this.__completionDate;
DeliveryLocation get pickupLocation => this.__pickupLocation;
DeliveryLocation get dropOffLocation => this.__dropOffLocation;



  DeliveryRequest({
    String deliveryID,
    UjuziUser requestingUser,
    DeliveryLocation dropOffLocation,
    DeliveryLocation pickupLocation,
    DateTime startDate,
    DateTime completionDate,
    DateTime requestDate,
    Person dropOffPerson,
    Person pickupPerson,
    DeliveryStatus status,
    PackageType packageType,
  }){
    this.__deliveryID = deliveryID;
    this.__requestingUser = requestingUser;
    this.__dropOffLocation = dropOffLocation;
    this.__pickupLocation = pickupLocation;
    this.__requestDate = requestDate;
    this.__startDate = startDate;
    this.__completionDate = completionDate;
    this.__dropoffPerson = dropOffPerson;
    this.__pickupPerson = pickupPerson;
    this.__status = status;
  }



  void updateStatus(DeliveryStatus status){
    this.__status = status;
  }


  void setPackageType(PackageType type){
    this.__package = type;
  }

  void setStartDate(DateTime date){
    this.__startDate = date;
  }


  void setCompletionDate(DateTime date){
    //todo check if the date is not before start and request date
    this.__completionDate = date;
  }


  void setDropOffPerson(Person person){
    this.__dropoffPerson = person;
  }


  void setPickupPerson(Person person){
    this.__pickupPerson = person;
  }


  void setPickupLocation(DeliveryLocation location){
    this.__pickupLocation = location;
  }

  void setDropOffLocation(DeliveryLocation location){
    this.__dropOffLocation = location;
  }


  String generateID(){
    //todo generate id
    return 'id';
  }


}






enum DeliveryStatus{
  complete,
  ongoing,
  pending,
  cancelled

}


enum PackageType{
  letter,
  parcel,
  large
}