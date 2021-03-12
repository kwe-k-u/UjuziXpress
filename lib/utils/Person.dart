


import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';

class Person{
  String __name;
  String __mobileNumber;
  DeliveryLocation __location;


  String get name => this.__name;
  String get mobileNumber => this.__mobileNumber;
  DeliveryLocation get location => this.__location;

  Person({String name, String number, DeliveryLocation location}){
    this.__name = name;
    this.__mobileNumber = number;
    this.__location = location;
  }

  void setName(String newName){
    this.__name = newName;
  }

  void setMobileNumber(String newNumber) => this.__mobileNumber = newNumber;

  void setLocation(DeliveryLocation location) => this.__location = location;







}