

import 'package:flutter/cupertino.dart';
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
  // Person __pickupPerson; // person to whom the package will be dropped off //todo make this null if pickup details are those of the ujuzi user
  String __notes;
  PaymentMethod _paymentMethod;

String get deliveryID => this.__deliveryID;
UjuziUser get requestingUser => this.__requestingUser;
DeliveryStatus get status => this.__status;
PackageType get packageType => this.__package;
// Person get pickupPerson => this.__pickupPerson;
Person get dropOffPerson => this.__dropoffPerson;
DateTime get requestDate => this.__requestDate;
DateTime get startDate => this.__startDate;
DateTime get completionDate => this.__completionDate;
// DeliveryLocation get pickupLocation => this.__pickupPerson.location;
DeliveryLocation get dropOffLocation => this.__dropoffPerson.location;
String get notes => this.__notes;
PaymentMethod get paymentMethod => this._paymentMethod;





  DeliveryRequest({
    String deliveryID,
    @required UjuziUser requestingUser,
    @required DeliveryLocation dropOffLocation,
    @required DeliveryLocation pickupLocation,
    DateTime startDate,
    DateTime completionDate,
    @required DateTime requestDate,
    @required Person dropOffPerson,
    @required Person pickupPerson,
    @required DeliveryStatus status,
    @required PackageType packageType,
    @required PaymentMethod paymentMethod,
    String note,
  }){
    this.__requestingUser = requestingUser;
    this.__requestDate = requestDate;
    this.__startDate = startDate;
    this.__completionDate = completionDate;
    this.__dropoffPerson = dropOffPerson;
    // this.__pickupPerson = pickupPerson;
    this.__status = status;
    this.__dropoffPerson.setLocation(dropOffLocation);
    // this.__pickupPerson.setLocation(pickupLocation);
    this.__notes = note;
    this._paymentMethod = paymentMethod;

    //assigning delivery id
    deliveryID == null //if no delivery id is given
    ? this.__deliveryID = __generateID() //generate id
        : this.__deliveryID = deliveryID; //use given id
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

  void setPaymentMethod(PaymentMethod method){
    this._paymentMethod = method;
  }


  void setCompletionDate(DateTime date){
    //todo check if the date is not before start and request date
    this.__completionDate = date;
  }

  void setNotes(String newNote){
    this.__notes = newNote;
  }


  void setDropOffPerson(Person person){
    this.__dropoffPerson = person;
  }


  // void setPickupPerson(Person person){
  //   this.__pickupPerson = person;
  // }


  // void setPickupLocation(DeliveryLocation location){
  //   this.__pickupPerson.setLocation(location);
  // }

  void setDropOffLocation(DeliveryLocation location){
    this.__dropoffPerson.setLocation(location);
  }


  String __generateID(){
    //todo include useraccount pointer
    /**
     * format for delivery id (uuidd-dd-mm-yy-hh-mm-ss)
     *  pointer for requesting user (last 5 letters in id for app)
     *  dateCreated
     *  timeCreated
     *algorithm for mapping
     *
     * encrypting the delivery id
     *  shuffled using an offset of 4
     *  letter index -> newIndex
     *  0 -> 0
     *  1 -> 5
        2 -> 7
        3 -> 9
        4 ->11
        5 ->8
        6 ->13
        7 ->3
        8 ->15
        9 -> 14
        10 -> 2
        11 -> 1
        12 -> 4
        13 -> 12
        14 -> 10
        15 -> 6
        16 -> 16
     */

     /**
     *  decrypting the delivery id
     *  new index <-old index
     *  0 <- 0
     *  1 <-7
        2 <- 9
        3 <-11
        4 <-8
        5 <-13
        6 <-3
        7 <-15
        8 <-14
        9 <-2
        10 <-1
        11 <-4
        12 <-12
        13 <-10
        14 <-6
        15 <-16
     *  16 <- 16
     */
    String id = "";
    String source = "UUIDD" //todo get user id characters
        + __parseInt(this.requestDate.day)
        + __parseInt(this.requestDate.month)
        + __parseInt(this.requestDate.year) //obtaining last two digits
        + __parseInt(this.requestDate.hour)
        + __parseInt(this.requestDate.minute)
        + __parseInt(this.requestDate.second);

    //shuffling the deliveryid
    for (int index in [0,5,7,9,11,8,13,3,15,14,2,1,4,12,10,6,16])
      id += source[index];

    return id;
  }


  /// Returns a two digit string of the passed [number]
  String __parseInt(int number){
    number %= 100;
    if (number <10)
      return number.toString().padLeft(2,"0");
    return number.toString();
  }


  Map<String, dynamic> asMap(){
    return {
      "deliveryID" : deliveryID ?? __generateID(),
      "requestingUser" : requestingUser.asMap(),
      'requestDate' : requestDate.toString(),
      'startDate' : startDate,
      'completionDate' : completionDate,
      'status' :status.index,
      'packageType' : packageType
    };
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

enum PaymentMethod{
  creditCard,
  paymentOnDelivery,
  paymentOnPickup
}